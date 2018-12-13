//
//  ShopMD.h
//  ymlinks
//
//  Created by nick on 2018/12/13.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopMD : NSObject

/**
 *  shopId 门店主键Id
 */
@property (nonatomic, copy) NSString *m_shopId;

/**
 *  name
 */
@property (nonatomic, copy) NSString *m_name;

/**
 *  custId 连锁Id
 */
@property (nonatomic, copy) NSString *m_custId;

/**
 *  compId 门店Id
 */
@property (nonatomic, copy) NSString *m_compId;

/**
 *  address
 */
@property (nonatomic, copy) NSString *m_address;

/**
 *  phone
 */
@property (nonatomic, copy) NSString *m_phone;

@end
