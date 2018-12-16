//
//  UIImageView+Expand.m
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "UIImageView+Expand.h"

@implementation UIImageView (Expand)

+ (instancetype)ex_imageViewWithFrame:(CGRect)frame Image:(UIImage *)image ContentMode:(UIViewContentMode)mode {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    
    imgView.image        = image;
    
    imgView.contentMode  = mode;
    
    return imgView;
}

@end
