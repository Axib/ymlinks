//
//  YMSuperViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "YMSuperViewController.h"

@interface YMSuperViewController ()

@end

@implementation YMSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    if (self != self.navigationController.viewControllers[0]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_return_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction:)];
    }
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_return_back"] style:UIBarButtonItemStyleBordered target:self action:@selector(popAction:)];
    // Do any additional setup after loading the view.
}

#pragma mark - NetworkManageDelegate
/** 将要发送网络请求 */
- (void)net_requestBeginTag:(NetworkInterfaceTag)tag {
    
}

- (void)popAction:(UIBarButtonItem *)barButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
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
