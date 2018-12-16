//
//  UIImage+Expand.h
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Expand)

+ (instancetype)ex_getImageWithName:(NSString *)name EdgeInsets:(UIEdgeInsets)edgeInsets;

- (instancetype)ex_getImageWithEdgeInsets:(UIEdgeInsets)edgeInsets;

/** 调整图片方向为Up */
- (instancetype)ex_adjustImageOrientationUp;

@end
