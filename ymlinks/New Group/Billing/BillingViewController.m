//
//  BillingViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/18.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "BillingViewController.h"

@interface BillingViewController ()

@end

@implementation BillingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开单";
    // Do any additional setup after loading the view.
}

- (void)popAction:(UIBarButtonItem *)barButtonItem
{
    UIViewController *homePage = self.navigationController.viewControllers[0];
    [self.navigationController popToViewController:homePage animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
