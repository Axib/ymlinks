//
//  BasicPopView.m
//  ymlinks
//
//  Created by nick on 2018/12/23.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "BasicPopView.h"

@interface BasicPopView ()<UIGestureRecognizerDelegate>

@end

@implementation BasicPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.m_animationType = PopAnimation_Fade;
        self.m_clearBcColor  = false;
    }
    return self;
}


- (void)show {
    [self initView];
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:true];
    UIViewController *topVic = [self getAppRootVic];
    [topVic.view addSubview:self];
    
    [self setPopGestureEnabled:false];
}

- (void)close {
    [self endEditing:true];
    [self setPopGestureEnabled:true];
    
    [self removeFromSuperview];
}

- (void)setPopGestureEnabled:(BOOL)enabled {
    UIViewController *topVic = [self getAppRootVic];
    
    UINavigationController *nav = nil;
    if ([topVic isKindOfClass:[UINavigationController class]])
        nav = (UINavigationController *)topVic;
    else
        nav = topVic.navigationController;
    
    nav.interactivePopGestureRecognizer.enabled = enabled;
}

- (void)initView {
    
}

- (UIViewController *)getAppRootVic {
    UIViewController *appRootVic = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVic     = appRootVic;
    
    while (topVic.presentedViewController) {
        topVic = topVic.presentedViewController;
    }
    
    if ([topVic isMemberOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)topVic;
        
        if (tab.selectedIndex < [tab.viewControllers count])
            topVic = tab.viewControllers[tab.selectedIndex];
    }
    
    if ([topVic isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)topVic;
        topVic = [nav.viewControllers lastObject];
        
        return topVic;
    }
    
    return topVic;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) return;
    
    UIViewController *topVic = [self getAppRootVic];
    
    if (!self.m_bcView) {
        self.m_bcView     = [[UIView alloc] initWithFrame:topVic.view.bounds];
        self.m_bcView.tag = TAG_POPBCVIEW;
        
        self.m_bcView.alpha           = 0.f;
        self.m_bcView.backgroundColor = [UIColor blackColor];
        
        if (self.m_clearBcColor) {
            if (CGRectEqualToRect(self.m_transparentFrame , CGRectZero))
                self.m_transparentFrame = self.frame;
            
            [self.m_bcView ex_addTransparentLayerInFrame:self.m_transparentFrame AndRadius:5.f];
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        
        [self.m_bcView addGestureRecognizer:tap];
        
        if (self.m_fuzzyBc && ISIOS8) {
            self.m_bcView.backgroundColor = [UIColor clearColor];
            
            UIVisualEffectView *effView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
            effView.frame = self.m_bcView.bounds;
            
            [self.m_bcView addSubview:effView];
        }
    }
    
    [topVic.view addSubview:self.m_bcView];
    
    if (self.m_animationType == PopAnimation_Fade)
        self.alpha = 0.f;
    
    if (self.m_animationType == PopAnimation_Right)
        self.m_x = mainScreen_Width;
    
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (self.m_animationType == PopAnimation_Fade) {
            self.alpha          = 1.f;
            self.m_bcView.alpha = self.m_fuzzyBc ? 1.f : 0.5f;
        }
        if (self.m_animationType == PopAnimation_Right) {
            self.m_x            = mainScreen_Width - self.m_width;
            self.m_bcView.alpha = 0.5f;
        }
        
    } completion:nil];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    [self close];
    return true;
}

- (void)removeFromSuperview {
    
    [UIView animateWithDuration:0.3f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (self.m_animationType == PopAnimation_Fade) {
            self.alpha          = 0;
            self.m_bcView.alpha = 0.f;
        }
        if (self.m_animationType == PopAnimation_Right) {
            self.m_x            = mainScreen_Width;
            self.m_bcView.alpha = 0.f;
        }
        
    } completion:^(BOOL finished) {
        [self.m_bcView removeFromSuperview];
        self.m_bcView = nil;
        [super removeFromSuperview];
    }];
}

@end
