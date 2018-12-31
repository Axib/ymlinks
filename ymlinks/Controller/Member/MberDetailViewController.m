//
//  MberDetailViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/18.
//  Copyright © 2018年 ym. All rights reserved.
//
//        会员档案


#import "MberDetailViewController.h"

@interface MberDetailViewController ()

@end

@implementation MberDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员档案";
    // Do any additional setup after loading the view.
}
- (IBAction)mberBilling:(id)sender {
    [self performSegueWithIdentifier:@"mberBilling" sender:nil];
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
