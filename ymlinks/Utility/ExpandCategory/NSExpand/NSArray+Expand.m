//
//  NSArray+Expand.m
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "NSArray+Expand.h"

@implementation NSArray (Expand)


- (NSArray *)ex_containSpecifiedValueDictionary:(NSString *)value WithKey:(NSString *)key {
    
    NSString *str = [NSString stringWithFormat:@"%@ == '%@'", key, value];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:str];
    
    NSArray *resultArray   = [self filteredArrayUsingPredicate:predicate];
    
    if ([resultArray count] == 0)
        return nil;
    
    return resultArray;
}

- (NSArray *)ex_getReverseArray {
    NSArray *newArray = [[self reverseObjectEnumerator] allObjects];
    
    return newArray;
}

@end
