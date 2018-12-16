//
//  NSArray+Expand.h
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Expand)

/**
 *  @return 返回 包含 拥有指定 key value 的Object 的list 如果没有返回nil
 */
- (NSArray *)ex_containSpecifiedValueDictionary:(NSString *)value WithKey:(NSString *)key;

/**
 *  数组元素倒序
 *
 *  @return 倒序的心数组
 */
- (NSArray *)ex_getReverseArray;

@end
