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
    
    /**************************************** 流水 ****************************************/
    /** 流水单 */
    NetworkTag_GetWaterList,
    /** 流水信息 */
    NetworkTag_GetWaterInfo,
    /** 作废流水单 */
    NetworkTag_refundWaterOrder,
    
    /**************************************** 价目 ****************************************/
    /** 获取价目分类 */
    NetworkTag_GetPriceType,
    /** 获取价目列表 */
    NetworkTag_GetPriceList,
    
    /**************************************** 开单 ****************************************/
    /** 获取预约人数 */
    NetworkTag_GetServiceCount,
    /** 修改疗程备注 /wallet/card/course/remark/change?courseId=&newRemark= */
    NetworkTag_UpdateCourseRemark,
    
    /**************************************** 会员 ****************************************/
    /** 关键字 查询会员卡信息 */
    NetworkTag_SearchMemberCardByKeyword,
    /** 会员Id 获取会员信息 */
    NetworkTag_GetMemberInfoByUserId,
    /** 会员卡Id 获取会员卡信息 */
    NetworkTag_GetCardInfoById,
    /** 会员Id 获取会员帐户信息 */
    NetworkTag_GetAccountByUserId,
    /** 会员Id 页码 查询会员帐户历史 */
    NetworkTag_GetTradeHistory,
    /** 会员Id 页码 获取会员保证金账户历史 */
    NetworkTag_GetMemberAdvance,
    
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
    NetworkTag_Add,
    
    
    /** 获取门店员工list */
    NetworkTag_GetShopEmpList,
    
    /**************************************** PUB ****************************************/
    /** 获取系统参数 */
    NetworkTag_GetSystemSetting,
    /** 获取支付方式 */
    NetworkTag_GetPayType,
    /** 获取服务员工 */
    NetworkTag_GetServiceEmp,
    /** 获取项目／产品大类 系统级别的 */
    NetworkTag_GetProjType,
    NetworkTag_GetProdType,
    /** 获取统计分类 连锁自定义的 */
    NetworkTag_GetProjStatisticsType,
    NetworkTag_GetProdStatisticsType,
    /** 获取项目资料 */
    NetworkTag_GetProjectList,
    /** 获取项目资料 */
    NetworkTag_GetProductList
    
    
} NetworkInterfaceTag;
@interface NetworkInterface : NSObject




+ (NSString *)net_getRequestUrlWithNetworkTag:(NetworkInterfaceTag)tag;


/**
 *  获取APPStore版本
 */
+ (NSString *)net_getAppStoreVersionUrlStr;
@end
