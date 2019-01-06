//
//  NetworkManage.h
//  ymlinks
//
//  Created by nick on 2018/12/15.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkInterface.h"
#import "MJExtension.h"

@protocol NetworkManageDelegate <NSObject>

@optional

/** 将要发送网络请求 */
- (void)net_requestBeginTag:(NetworkInterfaceTag)tag;

/** 网络请求成功 */
- (void)net_requestSuccess:(id)result Tag:(NetworkInterfaceTag)tag;

/** 网络请求失败 */
- (void)net_requestFail:(id)result Tag:(NetworkInterfaceTag)tag;

/** 网络请求进度 */
- (void)net_requestProgress:(NSProgress *)uploadProgress Tag:(NetworkInterfaceTag)tag;

@end

@interface NetworkManage : NSObject

+ (instancetype)shareNetworkManage;

/** 发送 Get请求 */
- (void)getRequest:(NSDictionary *)parameDic Tag:(NetworkInterfaceTag)tag Delegate:(id<NetworkManageDelegate>)delegate;

/** 发送 带有url拼接的 Get请求 */
- (void)getRequest:(NSDictionary *)parameDic Tag:(NetworkInterfaceTag)tag Delegate:(id<NetworkManageDelegate>)delegate SpliceInfo:(NSArray *)spliceInfo;

/** 发送 DELETE请求 */
- (void)deleteRequest:(NSDictionary *)parameDic Tag:(NetworkInterfaceTag)tag Delegate:(id<NetworkManageDelegate>)delegate;

/** 发送 PostValue请求 */
- (void)postValueRequest:(NSDictionary *)parameDic Tag:(NetworkInterfaceTag)tag Delegate:(id<NetworkManageDelegate>)delegate;

/** 发送 PostJson请求 */
- (void)postJsonRequest:(NSDictionary *)parameDic Tag:(NetworkInterfaceTag)tag Delegate:(id<NetworkManageDelegate>)delegate;

- (void)postJsonRequest:(NSDictionary *)parameDic subParam:(NSDictionary *)subParam Tag:(NetworkInterfaceTag)tag Delegate:(id<NetworkManageDelegate>)delegate;

/** 发送 带有二进制参数 请求 */
- (void)postDataRequest:(NSDictionary *)parameDic UploadData:(NSData *)data UploadKey:(NSString *)key  Tag:(NetworkInterfaceTag)tag Delegate:(id)delegate;

/** 取消请求 */
- (void)cancelRequestWithTag:(NetworkInterfaceTag)tag;

/** 检测APP版本 */
- (void)checkAppVersion:(NSString *)currentAppVersion Update:(void (^)(BOOL update, NSString *appStoreVersion))update;



@end
