//
//  WaterListViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "WaterListViewController.h"

@interface WaterListViewController ()
@property (weak, nonatomic) IBOutlet UIStackView *content_stack;
@property (weak, nonatomic) IBOutlet UIView *info_view;

@end

@implementation WaterListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)RGBCOLOR(255, 255, 255).CGColor,
                       (id)RGBCOLOR(188, 140, 53).CGColor, nil];
    [_info_view.layer addSublayer:gradient];
    
    // Do any additional setup after loading the view.
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
