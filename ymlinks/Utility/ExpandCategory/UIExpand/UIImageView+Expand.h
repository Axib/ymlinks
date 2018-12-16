//
//  UIImageView+Expand.h
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Expand)

+ (instancetype)ex_imageViewWithFrame:(CGRect)frame Image:(UIImage *)image ContentMode:(UIViewContentMode)mode;

@end
