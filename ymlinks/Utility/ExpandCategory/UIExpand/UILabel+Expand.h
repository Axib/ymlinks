//
//  UILabel+Expand.h
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Expand)

/**
 *  生成Label
 */
+ (instancetype)ex_labelWithFrame:(CGRect)frame Text:(NSString *)text TextColor:(UIColor *)textColor TextAlignment:(NSTextAlignment)textAlignment Font:(UIFont *)font;


/**
 *  设置行间距
 */
- (void)ex_setLineSpacing:(CGFloat)lineSpacing;

/**
 *  文本宽度
 */
- (void)ex_widthForText:(CGFloat) padding;

/**
 *  文本高度
 */
- (void)ex_heightForText:(CGFloat) padding;

@end
