//
//  YMSuperViewController.h
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkManage.h"

@interface YMSuperViewController : UIViewController<NetworkManageDelegate>

/**
 *  NavBar
 */
@property (nonatomic, strong) UIView *m_navBar;

- (void)showError:(NSString *)errorMsg;

@end
