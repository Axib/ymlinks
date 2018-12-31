//
//  WaterDetailViewController.h
//  ymlinks
//
//  Created by nick on 2018/12/23.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "YMSuperViewController.h"

@protocol WaterRefreshDelegate <NSObject>

- (void)waterRefresh;

@end

@interface WaterDetailViewController : YMSuperViewController

@property(nonatomic,assign) NSObject<WaterRefreshDelegate> *delegate;

@property(nonatomic, strong) NSDictionary *infoDic;

@end
