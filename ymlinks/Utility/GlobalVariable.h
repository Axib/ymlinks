//
//  GlobalVariable.h
//  ymlinks
//
//  Created by nick on 2018/12/13.
//  Copyright © 2018年 ym. All rights reserved.
//

#ifndef GlobalVariable_h
#define GlobalVariable_h


/** 当前登录门店 */
ShopMD *m_currentShopInfo;

/** 屏幕宽度 */
CGFloat mainScreen_Width;
/** 屏幕高度 */
CGFloat mainScreen_Height;

/** 当前操作的TextField */
UIView *m_currentTextField;


/** UUID */
NSString *m_UUIDStr;

/** 当前App版本 */
NSString *m_AppVersion;

/** 当前设备类型 */
NSString *m_deviceType;

/** 当前设备版本 */
NSString *m_deviceVersion;

/** 产品名称 */
NSString *m_productName;

/** 当前定位城市 */
NSString *m_currentCity;
/** 当前经度 */
NSString *m_longitude;
/** 当前纬度 */
NSString *m_latitude;


/** Token 登录Token 如果为空 则未登录 有值则为 登录成功 */
NSDictionary *m_loginInfo;


#pragma mark - VIEWTAG
#define TAG_POPBCVIEW (2331234)

#pragma mark - 常用颜色
/** 浅灰色线 */
#define COLOR_LIGHTGRAY_LINE RGBACOLOR(224, 224, 224, 0.7)
#define COLOR_NAVYGRAY_LINE  RGBCOLOR (185, 185, 185)

/** 边框颜色 */
#define COLOR_ALPHAGRAY_BORDER RGBACOLOR(235, 235, 235, 0.7)

/** 文字深黑 */
#define COLOR_NAVYBLACK_TEXT RGBCOLOR (40, 40, 40)
#define COLOR_BLACK_TEXT     RGBCOLOR (52, 52, 52)

#define COLOR_GRAY_TEXT      RGBCOLOR (140, 140, 140)

#define COLOR_LIGHTRED_TEXT  RGBCOLOR (244, 120, 100)

#define COLOR_LIGHTBLUE_TEXT RGBCOLOR (64, 156, 246)

#define COLOR_ORANGE_TEXT    RGBCOLOR (242, 117, 0)

#define COLOR_DeepPurple_TEXT M_COLORWITHIMG([UIImage imageNamed:@"Color_DeepPurple"])

/** 背景浅灰 */
//#define COLOR_LIAGHTGARY_BC RGBCOLOR (244, 245, 247)
#define COLOR_LIAGHTGARY_BC RGBCOLOR (239, 244, 245)

/** 背景浅蓝 */
#define COLOR_LIGHTBLUE_BC  RGBCOLOR (116, 199, 243)

/** 默认阴影颜色 */
#define COLOR_SHADOW_DEFAULT RGBCOLOR (198, 198, 198)

#endif /* GlobalVariable_h */
