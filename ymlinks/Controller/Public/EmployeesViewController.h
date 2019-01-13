//
//  EmployeesViewController.h
//  ymlinks
//
//  Created by nick on 2019/1/6.
//  Copyright © 2019年 ym. All rights reserved.
//

#import "YMSuperViewController.h"

@protocol EmployeesDelegate <NSObject>
- (void)chooseEmployees:(NSArray *) emps;
@end

@interface EmployeesViewController : YMSuperViewController

@property (nonatomic, strong) id<EmployeesDelegate> delegate;

@end
