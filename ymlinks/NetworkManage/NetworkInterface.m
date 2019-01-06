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
                    CurrentURL];
            
        case NetworkTag_GetWaterList://获取流水列表
            return [NSString stringWithFormat:@"%@/reserve/bill/comp/detail/get/ex",
                    CurrentURL];
            
        case NetworkTag_GetWaterInfo://获取流水信息
            return [NSString stringWithFormat:@"%@/reserve/bill/comp/performance/analysis",
                    CurrentURL];
            
        case NetworkTag_refundWaterOrder://流水单作废
            return [NSString stringWithFormat:@"%@/reserve/bill/refund/save",
                    CurrentURL];
            
        case NetworkTag_GetPriceType://获取价目分类
            return [NSString stringWithFormat:@"%@/shop/category/mobile", CurrentURL];
            
        case NetworkTag_GetPriceList://获取价目列表
            return [NSString stringWithFormat:@"%@/shop/project/mobile/cat/get", CurrentURL];
            
        case NetworkTag_SearchMemberCardByKeyword://根据关键字查询会员卡
            return [NSString stringWithFormat:@"%@/wallet/card/chain",
                    CurrentURL];
            
        case NetworkTag_GetTradeHistory://查询会员帐户历史/api/user/card/-/trade/history?page=
            return [NSString stringWithFormat:@"%@/wallet/trans",
                    CurrentURL];
            
        case NetworkTag_GetMemberAdvance://获取会员保证金账户历史/api/user/-/advance?page=
            return [NSString stringWithFormat:@"%@/wallet/advance",
                    CurrentURL];
            
        case NetworkTag_GetServiceCount://获取预约人数
            return [NSString stringWithFormat:@"%@/shop/setting",
                    CurrentURL];
            
        case NetworkTag_GetMemberInfoByUserId://根据卡Id获取会员资料 拼接接口 /user/admin/" + userId + "/get
            return [NSString stringWithFormat:@"%@/user/admin/",
                    CurrentURL];
            
        case NetworkTag_GetCardInfoById://根据卡Id获取会员卡信息 拼接接口 /wallet/card/"+cardId+"/get
            return [NSString stringWithFormat:@"%@/wallet/card/",
                    CurrentURL];
            
        case NetworkTag_GetAccountByUserId://获取会员帐户
            return [NSString stringWithFormat:@"%@/wallet/my",
                    CurrentURL];
            
        case NetworkTag_UpdateCourseRemark://修改疗程备注 /wallet/card/course/remark/change?courseId=&newRemark=
            return [NSString stringWithFormat:@"%@/wallet/card/course/remark/change",
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
            
            
            
        case NetworkTag_GetPayType://支付方式
            return [NSString stringWithFormat:@"%@/shop/pay/type",
                    CurrentURL];
            
        case NetworkTag_GetSystemSetting://系统参数
            return [NSString stringWithFormat:@"%@/shop/pay/setting",
                    CurrentURL];
            
        case NetworkTag_GetServiceEmp://服务员工
            return [NSString stringWithFormat:@"%@/user/emp/chain",
                    CurrentURL];
            
        case NetworkTag_GetProjType://项目／产品大类 系统级别的
        case NetworkTag_GetProdType:
            return [NSString stringWithFormat:@"%@/shop/category/base",
                    CurrentURL];
            
        case NetworkTag_GetProjStatisticsType://获取统计分类 连锁自定义的
        case NetworkTag_GetProdStatisticsType:
            return [NSString stringWithFormat:@"%@/shop/category/chain",
                    CurrentURL];
            
        case NetworkTag_GetProjectList://获取项目／产品列表 /api/project/list?type=&page=
        case NetworkTag_GetProductList:
            return [NSString stringWithFormat:@"%@/shop/project/search",
                    CurrentURL];
            
            
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
