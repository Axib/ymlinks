//
//  NetworkInterface.h
//  ymlinks
//
//  Created by nick on 2018/12/13.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

//正式环境
#define FormalBasicURL @"https://api.ymlinks.com"
//测试环境
#define TestBasicURL   @"https://test.ymlinks.com"

//#define CurrentURL FormalBasicURL
#define CurrentURL FormalBasicURL

/** 命名 NetworkTag + Get/Post 请求 + 功能描述 */
typedef enum : NSUInteger {//网络接口
    NetworkTag,
    
    /**************************************** 登录 ****************************************/
    /** 获取连锁下ShopList */
    NetworkTag_GetShopList,
    /** 用户登录 */
    NetworkTag_UserLogin,
    
    /**************************************** 门店 ****************************************/
    /** 获取门店shopId (主键Id) */
    NetworkTag_GetShopId,
    /** 获取门店员工list */
    NetworkTag_GetShopEmpList,
    
    /**************************************** 会员 ****************************************/
    /** 关键字 查询会员信息 */
    NetworkTag_SearchMemberInfoByKeyword,
    /** 关键字 查询会员卡信息 */
    NetworkTag_SearchVipCardByKeyword,
    /** 会员卡Id 获取会员信息 */
    NetworkTag_GetMemberInfoByCardId,
    /** 会员卡Id 获取账户信息 */
    NetworkTag_GetMemberAccountInfoByCardId,
    /** 会员卡Id 获取疗程账户信息 */
    NetworkTag_GetMemberCourseInfoByCardId,
    /** 会员卡Id 获取交易历史信息 */
    NetworkTag_GetMemberTransactionListByCardId,
    /** 会员卡Id 获取沟通记录信息 */
    NetworkTag_GetMemberReturnVistListByCardId,
    
    /**************************************** 预约 ****************************************/
    /** 根据日期查询预约 */
    NetworkTag_PostReservationListByDate,
    /** 查询预约列表根据员工排序 */
    NetworkTag_PostReservationListSortByEmp,
    /** 查询未处理预约 */
    NetworkTag_PostUnprocessedReservationList,
    /** 拒绝预约 */
    NetworkTag_PostCancelReservation,
    /** 接受预约 */
    NetworkTag_PostAcceptReservation,
    /** 查询预约订单金额 */
    NetworkTag_GetReservationAmout,
    /** 查询预约服务list */
    NetworkTag_GetReservationReserves,
    
    /** 根据日期查询可预约时间 */
    NetworkTag_GetCanReservationTimeListByDate,
    /** 获取门店可预约服务项目 */
    NetworkTag_GetCanReservationServiceList,
    /** 新增预约 */
    NetworkTag_Add
    
} NetworkInterfaceTag;
@interface NetworkInterface : NSObject




+ (NSString *)net_getRequestUrlWithNetworkTag:(NetworkInterfaceTag)tag;


/**
 *  获取APPStore版本
 */
+ (NSString *)net_getAppStoreVersionUrlStr;
@end
