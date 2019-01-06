//
//  Public.h
//  ymlinks
//
//  Created by nick on 2018/12/31.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Public : NSObject

+ (void)setBorderWithView:(CALayer *)vlayer top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;

+ (NSString *)checkString:(NSString *) string replace:(NSString *) replace;

+ (float)checkNumber:(NSString *) number replace:(float) replace;

@end
