//
//  UITextField+Expand.h
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Expand)

+ (instancetype)ex_textFieldWithFrame:(CGRect)frame KeyboardType:(UIKeyboardType)keyboardType Placeholder:(NSString *)placeholder TextAlignment:(NSTextAlignment)textAlignment Delegate:(id<UITextFieldDelegate>)delegate;

- (void)ex_setLeftViewWithImg:(UIImage *)img;

- (void)ex_setLeftViewWithText:(NSString *)text;

- (void)ex_setLayerCornerRadius:(CGFloat)radius AndBorderColor:(UIColor *)borderColor;

- (void)ex_setBorderWidth:(CGFloat)width IsLeft:(BOOL)isLeft;

- (void)ex_setRightViewWithImg:(UIImage *)img;

- (void)ex_setRightViewWithText:(NSString *)text;

- (void)ex_setPlaceholderColor:(UIColor *)color;

- (void)ex_setPlaceholderFont:(UIFont *)font;

/**
 *  仅能输入 整数
 */
- (BOOL)ex_canOnlyEnterAnIntegerWithReplacementString:(NSString *)string InRange:(NSRange)range;

/***************************** 常用输入栏样式 *****************************/
+ (instancetype)ex_defaultSearchTextFieldWithFrame:(CGRect)frame
                                       Placeholder:(NSString *)placeholder
                                          Delegate:(id<UITextFieldDelegate>)delegate
                                            Target:(id)target Action:(SEL)action;

@end
