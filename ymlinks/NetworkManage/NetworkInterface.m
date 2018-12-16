//
//  NetworkInterface.m
//  ymlinks
//
//  Created by nick on 2018/12/13.
//  Copyright © 2018年 ym. All rights reserved.
//  

#import "NetworkInterface.h"

@implementation NetworkInterface

+ (NSString *)net_getRequestUrlWithNetworkTag:(NetworkInterfaceTag)tag{
    NSString *strUrl = nil;
    
    switch (tag) {
        case NetworkTag:
            return @"";
            
        case NetworkTag_UserLogin://用户登录
            return [NSString stringWithFormat:@"%@/user/admin/login",
                    CurrentURL, m_productName, m_currentShopInfo.m_custId, m_currentShopInfo.m_compId];
            
        case NetworkTag_GetShopId://获取门店shopId 主键Id
            return [NSString stringWithFormat:@"%@/shop/chain/%@/comp/%@/getShopId",
                    CurrentURL, m_currentShopInfo.m_custId, m_currentShopInfo.m_compId];
            
        case NetworkTag_GetShopEmpList://获取门店员工list
            return [NSString stringWithFormat:@"%@/user/designer/shop/%@/get",
                    CurrentURL, m_currentShopInfo.m_shopId];
            
        case NetworkTag_SearchMemberInfoByKeyword://根据关键字查询会员
            return [NSString stringWithFormat:@"%@/cashier/leaguer/leaguerexbyMobile/get", CurrentURL];
            
        case NetworkTag_SearchVipCardByKeyword://根据关键字查询会员卡
            return [NSString stringWithFormat:@"%@/s3connect/card/chain/%@/comp/%@/list/getCardStatistics?",
                    CurrentURL, m_currentShopInfo.m_custId, m_currentShopInfo.m_compId];
            
        case NetworkTag_GetMemberInfoByCardId://根据卡Id获取会员详情 拼接接口 {会员卡id}/getCustomerInfo
            return [NSString stringWithFormat:@"%@/s3connect/card/chain/%@/card/",
                    CurrentURL, m_currentShopInfo.m_custId];
            
        case NetworkTag_GetMemberAccountInfoByCardId://根据卡Id获取会员账户信息 拼接接口 {会员卡id}/list/getAccountLsByCardNo
            return [NSString stringWithFormat:@"%@/s3connect/card/chain/%@/card/",
                    CurrentURL, m_currentShopInfo.m_custId];
            
        case NetworkTag_GetMemberCourseInfoByCardId://根据卡Id获取会员疗程账户信息 拼接接口 {会员卡id}/account/treatment/list/ge
            return [NSString stringWithFormat:@"%@/s3connect/card/",
                    CurrentURL];
            
        case NetworkTag_GetMemberTransactionListByCardId://根据卡Id获取会员交易历史 @{会员卡id}/chain/@{连锁Id}/queryTreatInfoList
            return [NSString stringWithFormat:@"%@/s3connect/card/", CurrentURL];
            
        case NetworkTag_GetMemberReturnVistListByCardId://根据卡Id获取会员沟通历史 @{会员卡id}
            return [NSString stringWithFormat:@"%@/reserve/consume/session/card/",
                    CurrentURL];
            
            
        case NetworkTag_PostReservationListByDate://根据日期查询预约list
            return [NSString stringWithFormat:@"%@/reserve/desktop/reserve/getReserveListByDate",
                    CurrentURL];
            
        case NetworkTag_PostReservationListSortByEmp://查询预约列表根据员工排序
            return [NSString stringWithFormat:@"%@/reserve/desktop/reserve/getReserveListByShopId",
                    CurrentURL];
            
        case NetworkTag_PostUnprocessedReservationList://获取未处理预约
            return [NSString stringWithFormat:@"%@/reserve/desktop/reserve/get",
                    CurrentURL];
            
        case NetworkTag_PostCancelReservation://拒绝预约
            return [NSString stringWithFormat:@"%@/reserve/cancel", CurrentURL];
            
        case NetworkTag_PostAcceptReservation://接受预约
            return [NSString stringWithFormat:@"%@/reserve/accept", CurrentURL];
            
        case NetworkTag_GetReservationAmout://查询预约订单金额
            return [NSString stringWithFormat:@"%@/order/reserve/multi/get", CurrentURL];
            
        case NetworkTag_GetReservationReserves://查询预约服务内容
            return [NSString stringWithFormat:@"%@/reserve/project/multi/get", CurrentURL];
            
        case NetworkTag_GetCanReservationTimeListByDate://根据日期查询可预约时间
            return [NSString stringWithFormat:@"%@/reserve/date/s/%@/d/-1?",
                    CurrentURL, m_currentShopInfo.m_shopId];

        case NetworkTag_GetCanReservationServiceList://获取门店可预约服务list
            return [NSString stringWithFormat:@"%@/shop/get/%@",
                    CurrentURL, m_currentShopInfo.m_shopId];
            
            
        default:
            NSLog(@"------------------- 请先定义对应接口 %zi --------------------", tag);
            break;
    }
    
    strUrl = [self removeSpaceInString:strUrl];
    
    return strUrl;
}

+ (NSString *)removeSpaceInString:(NSString *)str{
    
    NSArray *array = [str componentsSeparatedByString:@" "];
    
    return [array componentsJoinedByString:@""];
}

+ (NSString *)net_getAppStoreVersionUrlStr{
    NSString *storeString = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", APPID];
    
    return storeString;
}

@end
