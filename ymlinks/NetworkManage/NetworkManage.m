//
//  NetworkManage.m
//  ymlinks
//
//  Created by nick on 2018/12/15.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "NetworkManage.h"
#import "AFNetworking.h"

NetworkManage *m_networkManage;
@interface NetworkManage ()

/**
 *  保存请求 用作-取消请求
 */
@property (nonatomic, strong) NSMapTable *m_requestMap;
///**
// *  代理保存
// */
//@property (nonatomic, strong) NSMapTable *m_delegateMap;

@end

@implementation NetworkManage
- (NSMapTable *)m_requestMap {
    if (_m_requestMap == nil)
        _m_requestMap = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory];
    
    return _m_requestMap;
}

//- (NSMapTable *)m_delegateMap {
//    if (_m_delegateMap == nil)
//        _m_delegateMap = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory valueOptions:NSMapTableWeakMemory];
//
//    return _m_delegateMap;
//}

#pragma mark - Creat
- (AFHTTPSessionManager *)creatRequestManagerAndSaveInfo:(id<NetworkManageDelegate>)delegate WithTag:(NetworkInterfaceTag)tag{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer    = [AFJSONResponseSerializer serializer];
    
    [self setHeaderInfo:manager type:@"GET"];
    manager.requestSerializer.timeoutInterval = 20.f;
    
    [self.m_requestMap  setObject:manager forKey:@(tag)];
    
    return manager;
}

#pragma mark - 单例

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    if (m_networkManage == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            m_networkManage = [[super allocWithZone:zone] init];
        });
    }
    
    return m_networkManage;
}

+ (instancetype)shareNetworkManage {
    return [[self alloc] init];
}


#pragma mark - 网络请求
/** 发送 Get请求 */
- (void)getRequest:(NSDictionary *)parameDic Tag:(NetworkInterfaceTag)tag Delegate:(id<NetworkManageDelegate>)delegate{
    NSString *strUrl = [NetworkInterface net_getRequestUrlWithNetworkTag:tag];
    
    AFHTTPSessionManager *manager = [self creatRequestManagerAndSaveInfo:delegate WithTag:tag];
    
    [delegate net_requestBeginTag:tag];
    
    NSURLSessionDataTask *task = [manager GET:strUrl parameters:parameDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self requestDataSuccess:task ResponseObject:responseObject Tag:tag Delegate:delegate];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestDataFailed:task Error:error Tag:tag Delegate:delegate];
    }];
    
    ZNLog(@"当前 网络请求：Tag:%zi \nURL:%@", tag, task.currentRequest.URL);
}

/** 发送 带有url拼接的 Get请求 */
- (void)getRequest:(NSDictionary *)parameDic Tag:(NetworkInterfaceTag)tag Delegate:(id<NetworkManageDelegate>)delegate SpliceInfo:(NSArray *)spliceInfo{
    
    NSMutableString *strUrl = [[NetworkInterface net_getRequestUrlWithNetworkTag:tag] mutableCopy];
    
    NSString *splicStr = [spliceInfo componentsJoinedByString:@"/"];
    [strUrl appendString:splicStr];
    
    AFHTTPSessionManager *manager = [self creatRequestManagerAndSaveInfo:delegate WithTag:tag];
    
    [delegate net_requestBeginTag:tag];
    
    NSURLSessionDataTask *task = [manager GET:strUrl parameters:parameDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self requestDataSuccess:task ResponseObject:responseObject Tag:tag Delegate:delegate];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestDataFailed:task Error:error Tag:tag Delegate:delegate];
        
    }];
    
    ZNLog(@"当前 网络请求：Tag:%zi \nURL:%@", tag, task.currentRequest.URL);
}

/** 发送 DELETE请求 */
- (void)deleteRequest:(NSDictionary *)parameDic Tag:(NetworkInterfaceTag)tag Delegate:(id<NetworkManageDelegate>)delegate{
    
    NSString *strUrl = [NetworkInterface net_getRequestUrlWithNetworkTag:tag];
    
    AFHTTPSessionManager *manager = [self creatRequestManagerAndSaveInfo:delegate WithTag:tag];
    
    ZNLog(@"当前 网络请求：Tag:%zi \nURL:%@", tag, strUrl);
    
    [delegate net_requestBeginTag:tag];
    
    [manager DELETE:strUrl parameters:parameDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self requestDataSuccess:task ResponseObject:responseObject Tag:tag Delegate:delegate];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestDataFailed:task Error:error Tag:tag Delegate:delegate];
    }];
}

/** 发送 PostValue请求 */
- (void)postValueRequest:(NSDictionary *)parameDic Tag:(NetworkInterfaceTag)tag Delegate:(id<NetworkManageDelegate>)delegate{
    
    NSString *strUrl = [NetworkInterface net_getRequestUrlWithNetworkTag:tag];
    
    AFHTTPSessionManager *manager = [self creatRequestManagerAndSaveInfo:delegate WithTag:tag];
    manager.requestSerializer     = [AFHTTPRequestSerializer serializer];
    
    [delegate net_requestBeginTag:tag];
    
    [manager POST:strUrl parameters:parameDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self requestDataSuccess:task ResponseObject:responseObject Tag:tag Delegate:delegate];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self requestDataFailed:task Error:error Tag:tag Delegate:delegate];
    }];
}

/** 发送 PostJson请求 */
- (void)postJsonRequest:(NSDictionary *)parameDic Tag:(NetworkInterfaceTag)tag Delegate:(id<NetworkManageDelegate>)delegate{
    
    NSString *strUrl = [NetworkInterface net_getRequestUrlWithNetworkTag:tag];
    
    AFHTTPSessionManager *manager = [self creatRequestManagerAndSaveInfo:delegate WithTag:tag];
    manager.requestSerializer     = [AFJSONRequestSerializer serializer];
    [self setHeaderInfo:manager type:@"POST"];
    
    [delegate net_requestBeginTag:tag];
    
    ZNLog(@"当前 网络请求：Tag:%zi \nURL:%@", tag, strUrl);
    
    [manager POST:strUrl parameters:parameDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZNLog(@"成功！");
        
        [self requestDataSuccess:task ResponseObject:responseObject Tag:tag Delegate:delegate];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZNLog(@"失败");
        
        [self requestDataFailed:task Error:error Tag:tag Delegate:delegate];
    }];
}

/** 发送 带有二进制的网络请求 */
- (void)postDataRequest:(NSDictionary *)parameDic UploadData:(NSData *)data UploadKey:(NSString *)key  Tag:(NetworkInterfaceTag)tag Delegate:(id)delegate{
    
    NSString *strUrl = [NetworkInterface net_getRequestUrlWithNetworkTag:tag];
    
    AFHTTPSessionManager *manager = [self creatRequestManagerAndSaveInfo:delegate WithTag:tag];
    
    NSString *fileName = [NSString stringWithFormat:@"%.0f.JPEG", [[NSDate date] timeIntervalSince1970]];
    
    [delegate net_requestBeginTag:tag];
    
    ZNLog(@"当前 网络请求：Tag:%zi \nURL:%@", tag, strUrl);
    
    [manager POST:strUrl parameters:parameDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:key fileName:fileName mimeType:@"image/JPEG"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self requestDataSuccess:task ResponseObject:responseObject Tag:tag Delegate:delegate];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self requestDataFailed:task Error:error Tag:tag Delegate:delegate];
    }];
}

/** 取消请求 */
- (void)cancelRequestWithTag:(NetworkInterfaceTag)tag{
    AFHTTPSessionManager *manager = [self.m_requestMap objectForKey:@(tag)];
    
    [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [manager invalidateSessionCancelingTasks:true];
    
    [self.m_requestMap  removeObjectForKey:@(tag)];
    //    [self.m_delegateMap removeObjectForKey:@(tag)];
}

- (void)checkAppVersion:(NSString *)currentAppVersion Update:(void (^)(BOOL update, NSString *appStoreVersion))update{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *strUrl = [NetworkInterface net_getAppStoreVersionUrlStr];
    
    [manager GET:strUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *appInfo  = [responseObject[@"results"] firstObject];
        
        NSString *storeVersion = [NSString ex_stringWithId:appInfo[@"version"]];
        
        ZNLog(@"当前AppStore版本：%@",storeVersion);
        
        if (storeVersion &&  ([currentAppVersion compare:storeVersion] == -1)) {
            if (update)
                update (true, storeVersion);
        }
        
        
    } failure:nil];
}

#define CC_MD5_DIGEST_LENGTH    16          /* digest length in bytes */

#define CC_MD5_BLOCK_BYTES      64          /* block size in bytes */

#define CC_MD5_BLOCK_LONG       (CC_MD5_BLOCK_BYTES / sizeof(CC_LONG))


#pragma mark - 设置头部信息
- (void)setHeaderInfo:(AFHTTPSessionManager *)manager type:(NSString *) requestType {
    
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *deviceUuId = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    if ([m_loginInfo count]) {
        [manager.requestSerializer setValue:[NSString ex_stringWithId:[m_loginInfo objectForKey:@"deviceId"]]
                         forHTTPHeaderField:@"device_id"];
    }
    else {
        [manager.requestSerializer setValue:deviceUuId
                         forHTTPHeaderField:@"device_id"];
    }
    
    [manager.requestSerializer setValue:[NSString ex_stringWithId:[m_loginInfo objectForKey:@"accessToken"]]
                     forHTTPHeaderField:@"access_token"];
    
    [manager.requestSerializer setValue:@"iOS"
                     forHTTPHeaderField:@"phone_type"];
    
    [manager.requestSerializer setValue:[NSString ex_stringWithId:m_AppVersion]
                     forHTTPHeaderField:@"app_version"];
    
    [manager.requestSerializer setValue:[NSString ex_stringWithId:m_productName]
                     forHTTPHeaderField:@"product"];
    
    if ([requestType isEqualToString:@"POST"]) {
        NSString *ticketStr = [NSString stringWithFormat:@"%i%i", (int)([[NSDate date] timeIntervalSince1970] * 1000), arc4random()];
        [manager.requestSerializer setValue:[ticketStr ex_md5Security]
                         forHTTPHeaderField:@"ticket"];
    }
}

#pragma mark - 网络请求结果
- (void)requestDataSuccess:(NSURLSessionDataTask * _Nonnull)task ResponseObject:(id _Nullable)responseObject Tag:(NetworkInterfaceTag)tag Delegate:(id<NetworkManageDelegate>)delegate{
    
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"返回数据格式错误");
        return;
    }
    
    //    id delegate = [self.m_delegateMap objectForKey:@(tag)];
    
    NSDictionary *resultsInfo = responseObject;
    
    BOOL status = [resultsInfo[@"success"] boolValue];
    
    if (!status) {//服务器返回 失败
        NSInteger code = [NSString ex_integerWithId:resultsInfo[@"code"]];
        
        if (code == 403) {//403 身份认证失败，重新登录
            [[NSNotificationCenter defaultCenter] postNotificationName:Notif_LogBackIn object:nil];
            
            return;
        }
        
        NSString *msg = resultsInfo[@"msg"];
        
        if (msg == nil)
            msg = [NSString stringWithFormat:@"%@", resultsInfo[@"code"]];
        
        NSLog(@"返回结果：失败 %@", msg);
        
        if ([delegate respondsToSelector:@selector(net_requestFail:Tag:)])
            [delegate net_requestFail:msg Tag:tag];
        
        return;
    }
    
    if (!delegate) return;
    
    //请求成功 回调
    switch (tag) {//需特殊处理的 网络请求
            
        case NetworkTag_UserLogin:
            //用户登录
            [self userLoginSuccessCallback:delegate Result:resultsInfo[@"result"] Tag:tag];
            
            break;
            
        case NetworkTag_GetShopId:
            //获取门店的shopId主键Id
            [self getShopIdSuccessCallbackResult:resultsInfo[@"result"]];
            
            break;
            
        case NetworkTag_PostUnprocessedReservationList:
            //获取预约list
            [self unprocessedReservationGetSuccessCallback:delegate Result:resultsInfo Tag:tag];
            
            break;
            
        default:
            //默认回调
            [self defaultCallback:delegate Result:resultsInfo[@"result"] Tag:tag];
            
            break;
    }
}

- (void)requestDataFailed:(NSURLSessionDataTask * _Nonnull)task Error:(NSError * _Nonnull)error Tag:(NetworkInterfaceTag)tag Delegate:(id<NetworkManageDelegate>)delegate{
    
    NSInteger code   = [error code];
    NSString *urlStr = [task.currentRequest.URL absoluteString];
    
    if (code == NSURLErrorCancelled) {
        ZNLog(@"\n取消请求成功 Tag:%zi \nURL:%@ \n", tag, urlStr);
        return;
    }
    NSString *errMsg = @"系统异常";
    
    if (code == NSURLErrorTimedOut)
        errMsg = @"请求超时";
    
    NSLog(@"\n请求失败 Tag:%zi \nURL:%@ MSG:%@\n", tag, urlStr, errMsg);
    
    //    id delegate = [self.m_delegateMap objectForKey:@(tag)];
    
    if ([delegate respondsToSelector:@selector(net_requestFail:Tag:)])
        [delegate net_requestFail:errMsg Tag:tag];
}

#pragma mark - 代理回调
/** 默认回调 */
- (void)defaultCallback:(id<NetworkManageDelegate>)delegate Result:(id)result  Tag:(NetworkInterfaceTag)tag {
    
    if ([delegate respondsToSelector:@selector(net_requestSuccess:Tag:)])
        [delegate net_requestSuccess:result Tag:tag];
}

#pragma mark - 用户登录
- (void)userLoginSuccessCallback:(id<NetworkManageDelegate>)delegate Result:(id)result  Tag:(NetworkInterfaceTag)tag {
    
    m_loginInfo = result;
    
    if ([delegate respondsToSelector:@selector(net_requestSuccess:Tag:)])
        [delegate net_requestSuccess:result Tag:tag];
}

- (void)getShopIdSuccessCallbackResult:(id)result {
    
    m_currentShopInfo.m_shopId = [NSString ex_stringWithId:result];
}

- (void)unprocessedReservationGetSuccessCallback:(id<NetworkManageDelegate>)delegate Result:(id)result  Tag:(NetworkInterfaceTag)tag {
    
    NSNotification *notif = [[NSNotification alloc] initWithName:Notif_RefreshUnprocessedReservationCount
                                                          object:nil userInfo:@{NotifKey_UserInfo: result[@"page"]}];
    
    [[NSNotificationCenter defaultCenter] postNotification:notif];
    
    if ([delegate respondsToSelector:@selector(net_requestSuccess:Tag:)])
        [delegate net_requestSuccess:result[@"result"] Tag:tag];
}



@end
