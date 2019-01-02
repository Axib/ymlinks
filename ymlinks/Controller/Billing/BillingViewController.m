//
//  BillingViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/18.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "BillingViewController.h"
#import "BillingConsumeCell.h"
#import "BillingCommodityCell.h"
#import "BillingGoodsCell.h"
#import "TransactionHistoryCell.h"
#import "MemberDepositCell.h"
#import "MemberEarnestCell.h"

@interface BillingViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *sex_view;
@property (weak, nonatomic) IBOutlet UITableView *consume_table;
@property (weak, nonatomic) IBOutlet UIView *btn_view;
@property (weak, nonatomic) IBOutlet UIView *cardInfo_view;
@property (weak, nonatomic) IBOutlet UITableView *commodity_table;
@property (weak, nonatomic) IBOutlet UIView *commodity_bg;
@property (weak, nonatomic) IBOutlet UIView *shadow_bg;
@property (weak, nonatomic) IBOutlet UIView *shadow_view;
@property (weak, nonatomic) IBOutlet UIView *deposit_header;
@property (weak, nonatomic) IBOutlet UIView *earnest_header;
@property (weak, nonatomic) IBOutlet UIScrollView *commodity_scroll;
@property (weak, nonatomic) IBOutlet UITableView *commType_table;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btns;
@property (weak, nonatomic) IBOutlet UIView *function_view;


@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property (strong, nonatomic) UIBezierPath *path;

@property (assign, nonatomic) NSInteger commodity_index;
@property (strong, nonatomic) NSArray *btnNames;
@property (strong, nonatomic) NSDictionary *functionDic;

@property (strong, nonatomic) NSMutableDictionary *commodityDic;
@property (strong, nonatomic) NSMutableArray *commodityArray;

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
    
    for (UIButton *btn in _btns) {
        btn.layer.cornerRadius = 3;
    }
    
    _commodity_scroll.contentSize = CGSizeMake(_commodity_scroll.frame.size.width * 2, 0);
    _commodity_scroll.bounces = NO;
    
    _cardInfo_view.layer.masksToBounds = true;
    [Public setBorderWithView:_function_view.layer top:NO left:NO bottom:YES right:NO borderColor:RGBCOLOR(238, 238, 238) borderWidth:1];
    
    if (!_memberCard) {
        CGRect rect = _cardInfo_view.frame;
        rect.size.height = 50;
        [_cardInfo_view setFrame:rect];
        
        CGRect rect_s = _commodity_scroll.frame;
        rect_s.size.height += rect_s.origin.y - rect.origin.y + rect.size.height + 8;
        rect_s.origin.y = rect.origin.y + rect.size.height;
        [_commodity_scroll setFrame:rect_s];
    }
    
    _commodity_bg.layer.shadowColor = [UIColor clearColor].CGColor;
    _commodity_bg.layer.shadowOpacity = 0.6f;
    _commodity_bg.layer.shadowRadius = 4.f;
    _commodity_bg.layer.shadowOffset = CGSizeMake(0,0);
    _shadow_bg.layer.masksToBounds = YES;
    _shadow_view.layer.shadowColor = [UIColor blackColor].CGColor;
    _shadow_view.layer.shadowOpacity = 0.8f;
    _shadow_view.layer.shadowRadius = 3.0f;
    _shadow_view.layer.shadowOffset = CGSizeMake(1,0);
    
    float btnWidth = _function_view.frame.size.width / (_memberCard ? 6 : 2);
    _btnNames = _memberCard ? @[@{@"title": @"疗程信息", @"flag":@0},
                                @{@"title": @"单次体验", @"flag":@1},
                                @{@"title": @"客装产品", @"flag":@2},
                                @{@"title": @"寄存产品", @"flag":@3},
                                @{@"title": @"账户记录", @"flag":@4},
                                @{@"title": @"预付金", @"flag":@5}] : @[
                                @{@"title": @"单次体验", @"flag":@1},
                                @{@"title": @"客装产品", @"flag":@2}];
    _functionDic = [_btnNames objectAtIndex:0];
    for (int i = 0; i < _btnNames.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*btnWidth, 0, btnWidth, _function_view.frame.size.height)];
        _functionDic = [_btnNames objectAtIndex:i];
        [btn setTag:i];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn setTitle:[_functionDic objectForKey:@"title"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(chooseFunction:) forControlEvents:UIControlEventTouchUpInside];
        [_function_view addSubview:btn];
        
        [Public setBorderWithView:btn.layer top:NO left:NO bottom:NO right:(i < _btnNames.count ? YES : NO) borderColor:RGBCOLOR(238, 238, 238) borderWidth:1];
    }
    double delayInseconds = 0.4;
    dispatch_time_t afterTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInseconds * NSEC_PER_SEC));
    dispatch_after(afterTime, dispatch_get_main_queue(), ^{
        [self chooseFunction:[_function_view.subviews objectAtIndex:0]];
    });
    
    _commodityDic = [[NSMutableDictionary alloc] init];
    
    [Public setBorderWithView:_commType_table.layer
                          top:NO
                         left:NO
                       bottom:NO
                        right:YES
                  borderColor:RGBCOLOR(229, 229, 229)
                  borderWidth:(CGFloat)1];
    if ([_commType_table respondsToSelector:@selector(setSeparatorInset:)]) {
        [_commType_table setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_commType_table respondsToSelector:@selector(setLayoutMargins:)]) {
        [_commType_table setLayoutMargins:UIEdgeInsetsZero];
    }

    // Do any additional setup after loading the view.
}

- (void)chooseFunction:(UIButton *) sender {
    _commodity_index = -1;
    _functionDic = [_btnNames objectAtIndex:[sender tag]];
    [UIView animateWithDuration:0.1 animations:^{
        [_commodity_table setContentOffset:CGPointMake(0, 0)];
    } completion:^(BOOL finished) {
        if ([[_functionDic objectForKey:@"flag"] isEqual:@1] || [[_functionDic objectForKey:@"flag"] isEqual:@2]) {
            _shadow_view.hidden = NO;
            [_commodity_scroll setScrollEnabled:true];
            float timer = 0.5;
            if (_commodity_scroll.contentOffset.x == 0) {
                timer = 0.25;
            }
            [_commodity_scroll setContentOffset:CGPointMake(0, 0)];
            [UIView animateWithDuration:timer animations:^{
                [_commodity_scroll setContentOffset:CGPointMake(_commodity_scroll.frame.size.width, 0) animated:false];
            }];
        }
        else {
            _shadow_view.hidden = YES;
            [_commodity_scroll setScrollEnabled:false];
            [_commodity_scroll setContentOffset:CGPointMake(_commodity_scroll.frame.size.width, 0) animated:false];
        }
        _deposit_header.hidden = YES;
        _earnest_header.hidden = YES;
        if ([[_functionDic objectForKey:@"flag"] isEqual:@3]) {
            _deposit_header.hidden = NO;
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@5]) {
            _earnest_header.hidden = NO;
        }
        
        [_commodity_table reloadData];
    }];
    
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

#pragma UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _commodity_scroll) {
        _commodity_bg.layer.shadowColor = [UIColor blackColor].CGColor;
        CGRect rect = _commodity_bg.frame;
        float deviation = _commodity_scroll.contentOffset.x > 200 ? _commodity_scroll.contentOffset.x : rect.origin.x;
        deviation = _commodity_scroll.contentOffset.x < 200 ? 200 : deviation;
        float maxWidth = (200 - _commodity_scroll.contentOffset.x) < 0 ? 0 : (200 - _commodity_scroll.contentOffset.x);
        [_commodity_bg setFrame:CGRectMake(deviation,
                                           rect.origin.y,
                                           _commodity_scroll.frame.size.width - maxWidth,
                                           rect.size.height)];
        rect = _commType_table.frame;
        [_commType_table setFrame:CGRectMake(_commodity_scroll.contentOffset.x, rect.origin.y, rect.size.width, rect.size.height)];
        
    }
    else if (scrollView == _commodity_table) {
        CGRect dRect = _deposit_header.frame;
        CGRect eRect = _earnest_header.frame;
        if (_commodity_table.contentOffset.y < 0) {
            dRect.origin.y = -_commodity_table.contentOffset.y;
            eRect.origin.y = -_commodity_table.contentOffset.y;
        }
        else {
            dRect.origin.y = 0;
            eRect.origin.y = 0;
        }
        [_deposit_header setFrame:dRect];
        [_earnest_header setFrame:eRect];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _commodity_scroll) {
        _commodity_bg.layer.shadowColor = [UIColor clearColor].CGColor;
    }
}

#pragma UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _commodity_table) {
        if ([[_functionDic objectForKey:@"flag"] isEqual:@0]) {
            BillingCommodityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BillingCommodityCell class]) forIndexPath:indexPath];
            
            return cell;
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@1] || [[_functionDic objectForKey:@"flag"] isEqual:@2]) {
            BillingGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BillingGoodsCell class]) forIndexPath:indexPath];
            
            return cell;
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@3]) {
            MemberDepositCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MemberDepositCell class]) forIndexPath:indexPath];
            
            return cell;
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@4]) {
            TransactionHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TransactionHistoryCell class]) forIndexPath:indexPath];
            
            return cell;
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@5]) {
            MemberEarnestCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MemberEarnestCell class]) forIndexPath:indexPath];
            
            return cell;
        }
    }
    else if (tableView == _commType_table) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commTypeCell" forIndexPath:indexPath];
        [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
        [cell.textLabel setText:@"类别名称"];
        cell.backgroundColor = RGBCOLOR(245,245,245);
        if (indexPath.row == 0) {
            cell.backgroundColor = [UIColor whiteColor];
        }
        return cell;
    }
    else if (tableView == _consume_table) {
        BillingConsumeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BillingConsumeCell class]) forIndexPath:indexPath];
        
        return cell;
    }
    return [[UITableViewCell alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _commodity_table) {
        return 5;
    }
    else if (tableView == _commType_table) {
        return 50;
    }
    else if (tableView == _consume_table) {
        return 5;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _commodity_table) {
        if ([[_functionDic objectForKey:@"flag"] isEqual:@0]) {
            if (_commodity_index == indexPath.row) {
                return 250;
            }
            return 130;
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@1] || [[_functionDic objectForKey:@"flag"] isEqual:@2]) {
            if (_commodity_index == indexPath.row) {
                return 225;
            }
            return 60;
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@3] || [[_functionDic objectForKey:@"flag"] isEqual:@5]) {
            return 50;
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@4]) {
            return 140;
        }
    }
    else if (tableView == _commType_table) {
        return 45;
    }
    else if (tableView == _consume_table) {
        return 135;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _commodity_table) {
        if ([[_functionDic objectForKey:@"flag"] isEqual:@3] || [[_functionDic objectForKey:@"flag"] isEqual:@5]) {
            return 44;
        }
    }
    else if (tableView == _consume_table) {
        return 7;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor clearColor];
}

#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _commodity_table) {
        _commodity_index = indexPath.row;
        [_commodity_table reloadData];
    }
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
