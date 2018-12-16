//
//  AppDelegate.m
//  ymlinks
//
//  Created by nick on 2018/12/11.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "AppDelegate.h"
#import "SSKeychain.h"
#import <sys/utsname.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    _mainScreen_Height = self.window.frame.size.height;
    [self setGlobalVariable];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 基础设置
- (void)setGlobalVariable{
    
    [M_USERDEFAULTS removeObjectForKey:MODEL_REPLACE_KEY];
    
    [self getDeviceUUID];
    
    if (ISIOS8) {
        mainScreen_Width  = [UIScreen mainScreen].bounds.size.width;
        mainScreen_Height = [UIScreen mainScreen].bounds.size.height;
    }else {
        mainScreen_Width  = [UIScreen mainScreen].bounds.size.height;
        mainScreen_Height = [UIScreen mainScreen].bounds.size.width;
    }
    
    m_loginInfo      = [[NSDictionary alloc] init];
    m_longitude       = @"0";
    m_latitude        = @"0";
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    m_deviceType    = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    m_deviceVersion = [[UIDevice currentDevice] systemVersion];
    
    m_AppVersion    = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
#warning 产品名称
    m_productName = @"reception";
    
    /** 默认登录门店信息 */
    NSDictionary *shopInfo = M_USERDEFAULTS_GET(USER_SHOP_KEY);
    m_currentShopInfo      = [ShopMD mj_objectWithKeyValues:shopInfo];
}

- (void)getDeviceUUID{
    NSString *UUIDKey = [NSBundle mainBundle].bundleIdentifier;
    
    m_UUIDStr = [NSString ex_stringWithId:[SSKeychain passwordForService:UUIDKey account:@"user"]];
    
    if ([m_UUIDStr isEqualToString:@""]) {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        m_UUIDStr = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        [SSKeychain setPassword:m_UUIDStr forService:UUIDKey account:@"user"];
    }
}


@end
