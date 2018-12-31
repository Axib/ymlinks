//
//  BillingViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/18.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "BillingViewController.h"
#import "BillingConsumeCell.h"

@interface BillingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *sex_view;
@property (weak, nonatomic) IBOutlet UITableView *consume_table;
@property (weak, nonatomic) IBOutlet UIView *btn_view;
@property (weak, nonatomic) IBOutlet UIView *cardInfo_view;
@property (weak, nonatomic) IBOutlet UITableView *commodity_table;


@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property (strong, nonatomic) UIBezierPath *path;

@end

@implementation BillingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开单";
    
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.frame = CGRectMake(0, _sex_view.frame.size.height - 3.5, _sex_view.frame.size.width+2, _sex_view.frame.size.height - 3.5);
    [_sex_view.layer addSublayer:_shapeLayer];
    _sex_view.layer.masksToBounds = true;
    _sex_view.backgroundColor = [UIColor clearColor];
    [self drawPath];
    
    _btn_view.layer.shadowColor = [UIColor blackColor].CGColor;
    _btn_view.layer.shadowOpacity = 0.6f;
    _btn_view.layer.shadowRadius = 4.f;
    _btn_view.layer.shadowOffset = CGSizeMake(0,0);
    

    if (@available(iOS 11.0, *)) {
        _consume_table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // Do any additional setup after loading the view.
}

- (void)drawPath {
    
    static double i = 0;
    
    CGFloat A = 3.5;//A振幅
    CGFloat k = 0;//y轴偏移
    CGFloat ω = 0.35;//角速度ω变大，则波形在X轴上收缩（波形变紧密）；角速度ω变小，则波形在X轴上延展（波形变稀疏）。不等于0
    CGFloat φ = 0 + i;//初相，x=0时的相位；反映在坐标系上则为图像的左右移动。
    //y=Asin(ωx+φ)+k
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointZero];
    for (int i = 0; i < _shapeLayer.frame.size.width; i ++) {
        CGFloat x = i;
        CGFloat y = A * sin(ω*x+φ)+k;
        [_path addLineToPoint:CGPointMake(x, y)];
    }
    [_path addLineToPoint:CGPointMake(_shapeLayer.frame.size.width, -_shapeLayer.frame.size.height)];
    [_path addLineToPoint:CGPointMake(0, -_shapeLayer.frame.size.height)];
    _path.lineWidth = 1;
    _shapeLayer.path = _path.CGPath;
    _shapeLayer.fillColor = RGBCOLOR(188,140,53).CGColor;
    
    i += 0.01;
    
    if (i > M_PI_2 * 2) {
        i = 0;//防止i越界
    }
}

#pragma UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _consume_table) {
        BillingConsumeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BillingConsumeCell class]) forIndexPath:indexPath];
        
        return cell;
    }
    return NULL;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 7;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
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
