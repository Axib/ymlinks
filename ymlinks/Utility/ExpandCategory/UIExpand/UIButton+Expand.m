//
//  UIButton+Expand.m
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "UIButton+Expand.h"

@implementation UIButton (Expand)


+ (instancetype)ex_buttonWithFrame:(CGRect)frame
                             Title:(NSString *)title
                              Font:(UIFont *)font
                         TextColor:(UIColor *)color
                            Target:(id)target Action:(SEL)action{
    
    UIButton *btn = [[self class] buttonWithType:UIButtonTypeCustom];
    
    [btn setFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    
    btn.titleLabel.font = font;
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
    
}

+ (instancetype)ex_buttonWithFrame:(CGRect)frame Title:(NSString *)title BcImg:(UIImage *)bcImg Radius:(CGFloat)radius Target:(id)target Action:(SEL)action{
    
    UIButton *btn          = [[self class] buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font    = M_FONT_SYSTEM(15);
    
    btn.layer.cornerRadius = radius;
    btn.layer.masksToBounds= true;
    
    [btn setBackgroundImage:bcImg forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

+ (instancetype)ex_buttonWithFrame:(CGRect)frame
                            NorImg:(UIImage *)norImg
                            selImg:(UIImage *)selImg
                            Target:(id)target Action:(SEL)action{
    
    UIButton *btn          = [[self class] buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    
    [btn setImage:norImg forState:UIControlStateNormal];
    [btn setImage:selImg forState:UIControlStateSelected];
    
    btn.adjustsImageWhenHighlighted = false;
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

+ (instancetype)ex_buttonWithFrame:(CGRect)frame
                             Title:(NSString *)title
                            NorImg:(UIImage *)norImg
                             BcImg:(UIImage *)bcImg
                            Radius:(CGFloat)radius
                            Target:(id)target Action:(SEL)action{
    
    UIButton *btn          = [[self class] buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font    = M_FONT_BOLD(21);
    
    btn.layer.cornerRadius = radius;
    btn.layer.masksToBounds= true;
    
    [btn setImage:norImg forState:UIControlStateNormal];
    [btn setBackgroundImage:bcImg forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)ex_setTitle:(NSString *)title AndFont:(UIFont *)font AndTitleColor:(UIColor *)color{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    
    self.titleLabel.font = font;
}

#pragma mark - 默认按钮样式
+ (instancetype)ex_defaultPurpleButtonWithFrame:(CGRect)frame
                                          Title:(NSString *)title
                                         Target:(id)target Action:(SEL)action{
    UIButton *btn          = [[self class] buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font    = M_FONT_SYSTEM(15);
    
    btn.layer.cornerRadius = 5.f;
    btn.layer.masksToBounds= true;
    
    [btn setBackgroundImage:[UIImage imageNamed:@"Button_DeepPurple"] forState:UIControlStateNormal];
    //    [btn setBackgroundImage:[UIImage imageNamed:@"Button_NavyBlue"] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}


@end
