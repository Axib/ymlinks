//
//  NSString+Expand.h
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Expand)

/**
 *  获得移除指定字符串后的新字符串
 */
- (NSString *)ex_removeSpecifiedString:(NSString *)string;

/**
 *  指定 宽度 Font 获取高度
 */
- (CGSize)ex_getContentSizeWithFont:(UIFont *)font AndWidth:(CGFloat)width;


/**
 *  字符串 NSNull nil处理
 */
+ (NSString *)ex_stringWithId:(id)value;
+ (NSInteger)ex_integerWithId:(id)value;
+ (long long)ex_longLongWithId:(id)value;
+ (CGFloat)ex_floatWithId:(id)value;


/** 时间戳转->字符串 */
+ (NSString *)ex_getTimeStrWithTimeStamp:(double)stamp;

/** 时间戳->字符串 指定格式 dateFormat */
+ (NSString *)ex_getTimeStrWithTimeStamp:(double)stamp DateFormat:(NSString *)dateFormat;

/** 字符串转->时间戳 指定格式 */
+ (double)ex_getTimeStampWithTimeStr:(NSString *)str DateFormat:(NSString *)dateFormat;

/** 判断是否int类型数字 */
+ (BOOL)ex_isPureInt:(NSString *)string;

/** 判断是否Float数字 */
+ (BOOL)ex_isPureFloat:(NSString *)string;

/**
 *  是否是 手机号码
 *
 *  @return 是 返回 nil 否 返回error
 */
- (BOOL)ex_isMobileString;

/** 判断是否为 非 @"", nil, NSNull 合法 返回true 不合法 false */
- (BOOL)ex_isLegalString;

/** MD5加密 */
- (NSString *)ex_md5Security;

/** 手机号 *密文 */
- (NSString *)ex_mobileSecurity;

- (NSMutableAttributedString *)ex_getAttStringWithAttributeInfo:(NSDictionary *)info InRange:(NSRange)range;

@end
