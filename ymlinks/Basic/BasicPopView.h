//
//  BasicPopView.h
//  ymlinks
//
//  Created by nick on 2018/12/23.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /** 默认 渐显 */
    PopAnimation_Fade = 0,
    /** 右边出现 */
    PopAnimation_Right = 1,
    
} PopAnimationType;

@interface BasicPopView : UIView

@property (nonatomic, strong) UIView *m_bcView;

/**
 *  模糊背景
 */
@property (nonatomic, assign) BOOL m_fuzzyBc;

@property (nonatomic, assign) BOOL m_clearBcColor;
/**
 *  透明区域
 */
@property (nonatomic, assign) CGRect m_transparentFrame;

@property (nonatomic, assign) PopAnimationType m_animationType;


- (void)show;

- (void)close;

- (void)initView;


@end
