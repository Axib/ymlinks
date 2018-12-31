//
//  PurchaseViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/19.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "PurchaseViewController.h"

@interface PurchaseViewController ()

@end

@implementation PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买";
    // Do any additional setup after loading the view.
}

- (IBAction)saveOrder:(id)sender {
    [self performSegueWithIdentifier:@"jumpBilling" sender:nil];
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
