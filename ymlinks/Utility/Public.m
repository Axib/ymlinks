//
//  Public.m
//  ymlinks
//
//  Created by nick on 2018/12/31.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "Public.h"

@implementation Public


+ (void)setBorderWithView:(CALayer *)vlayer top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, vlayer.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [vlayer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, vlayer.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [vlayer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, vlayer.frame.size.height - width, vlayer.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [vlayer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(vlayer.frame.size.width - width, 0, width, vlayer.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [vlayer addSublayer:layer];
    }
}

+ (NSString *)checkString:(NSString *)string replace:(NSString *)replace {
    if (string) {
        return string;
    }
    return replace;
}

+ (float)checkNumber:(NSString *)number replace:(float)replace {
    if (number) {
        return [number floatValue];
    }
    return replace;
}

@end
