//
//  CommodityViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/19.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "CommodityViewController.h"

@interface CommodityViewController ()

@end

@implementation CommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    // Do any additional setup after loading the view.
}

- (IBAction)purchaseCommodity:(id)sender {
    [self performSegueWithIdentifier:([sender tag] == 1 ? @"toExperience" : @"buyCommodity") sender:nil];
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
