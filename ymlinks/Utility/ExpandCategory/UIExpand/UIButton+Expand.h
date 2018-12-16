//
//  UIButton+Expand.h
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (Expand)


+ (instancetype)ex_buttonWithFrame:(CGRect)frame
                             Title:(NSString *)title
                              Font:(UIFont *)font
                         TextColor:(UIColor *)color
                            Target:(id)target Action:(SEL)action;

+ (instancetype)ex_buttonWithFrame:(CGRect)frame
                             Title:(NSString *)title
                             BcImg:(UIImage *)bcImg
                            Radius:(CGFloat)radius
                            Target:(id)target Action:(SEL)action;

+ (instancetype)ex_buttonWithFrame:(CGRect)frame
                            NorImg:(UIImage *)norImg
                            selImg:(UIImage *)selImg
                            Target:(id)target Action:(SEL)action;

+ (instancetype)ex_buttonWithFrame:(CGRect)frame
                             Title:(NSString *)title
                            NorImg:(UIImage *)norImg
                             BcImg:(UIImage *)bcImg
                            Radius:(CGFloat)radius
                            Target:(id)target Action:(SEL)action;


- (void)ex_setTitle:(NSString *)title AndFont:(UIFont *)font AndTitleColor:(UIColor *)color;


/***************************** 常用按钮样式 *****************************/
+ (instancetype)ex_defaultPurpleButtonWithFrame:(CGRect)frame
                                          Title:(NSString *)title
                                         Target:(id)target Action:(SEL)action;

@end
