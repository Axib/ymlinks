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
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface BillingViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, BCommodityCellDelegate, BGoodsCellDelegate>
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

@property (weak, nonatomic) IBOutlet UIImageView *avatar_img;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *cardNo_label;
@property (weak, nonatomic) IBOutlet UILabel *accountAmt_lab;
@property (weak, nonatomic) IBOutlet UILabel *accountPay_lab;
@property (weak, nonatomic) IBOutlet UILabel *accountGive_lab;
@property (weak, nonatomic) IBOutlet UILabel *manager_label;

@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property (strong, nonatomic) UIBezierPath *path;

@property (assign, nonatomic) NSInteger commodity_index;
@property (strong, nonatomic) NSArray *btnNames;
@property (strong, nonatomic) NSDictionary *functionDic;

@property (strong, nonatomic) NSMutableDictionary *commodityDic;
@property (strong, nonatomic) NSMutableArray *commodityArray;

@property (strong, nonatomic) NSArray *payTypeList;
@property (strong, nonatomic) NSDictionary *systemSetting;
@property (strong, nonatomic) NSArray *projectTypeList;
@property (strong, nonatomic) NSArray *productTypeList;
@property (strong, nonatomic) NSArray *prodStatisticsList;
@property (strong, nonatomic) NSArray *projStatisticsList;
@property (strong, nonatomic) NSMutableArray *projInfoList;
@property (strong, nonatomic) NSMutableArray *prodInfoList;
@property (strong, nonatomic) NSDictionary *memberInfoDic;
@property (strong, nonatomic) NSMutableDictionary *cardInfoDic;
@property (strong, nonatomic) NSDictionary *accountInfoDic;
@property (strong, nonatomic) NSMutableArray *tradeHistoryList;
@property (strong, nonatomic) NSMutableArray *memberAdvanceList;

@property (assign, nonatomic) NSInteger projPage;
@property (assign, nonatomic) NSInteger projTypeIndex;
@property (assign, nonatomic) NSInteger prodPage;
@property (assign, nonatomic) NSInteger prodTypeIndex;
@property (assign, nonatomic) NSInteger tradeHisPage;
@property (assign, nonatomic) NSInteger memberAdvPage;

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
        [btn.layer setBorderWidth:1];
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
    
    [_commType_table setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    _avatar_img.layer.cornerRadius = 10;
    _avatar_img.layer.masksToBounds = YES;
    
    
    _commodity_table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if ([[_functionDic objectForKey:@"flag"] isEqual:@1]) {
            if (_projInfoList && [_projInfoList count] > 0) {
                _projPage++;
            }
            [self loadRequest:1];
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@2]) {
            if (_prodInfoList && [_prodInfoList count] > 0) {
                _prodPage++;
            }
            [self loadRequest:2];
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@4]) {
            if (_tradeHistoryList && [_tradeHistoryList count] > 0) {
                _tradeHisPage++;
            }
            [self loadRequest:3];
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@5]) {
            if (_memberAdvanceList && [_memberAdvanceList count] > 0) {
                _memberAdvPage++;
            }
            [self loadRequest:4];
        }
    }];
    
    [self loadRequest:0];

    // Do any additional setup after loading the view.
}

- (void)chooseFunction:(UIButton *) sender {
    for (UIButton *item in _function_view.subviews) {
        if (sender != item) {
            [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            item.layer.borderColor = [UIColor clearColor].CGColor;
        }
        else {
            [item setTitleColor:RGBCOLOR(188,140,53) forState:UIControlStateNormal];
            item.layer.borderColor = RGBCOLOR(188,140,53).CGColor;
            item.layer.borderWidth = 1;
        }
    }
    _commodity_index = -1;
    _functionDic = [_btnNames objectAtIndex:[sender tag]];
    [_commodity_table reloadData];
    [_commType_table reloadData];
    [_commodity_table.mj_footer endRefreshing];
    
    _commodity_table.mj_footer.hidden = NO;
    if ([[_functionDic objectForKey:@"flag"] isEqual:@0] || [[_functionDic objectForKey:@"flag"] isEqual:@3]) {
        _commodity_table.mj_footer.hidden = YES;
    }
    
    //动画
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
            cell.delegate = self;
            cell.tag = indexPath.row;
            NSDictionary *data = [[_cardInfoDic objectForKey:@"projects"] objectAtIndex:indexPath.row];
            [cell.name_label setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"courseName"]]];
            [cell.price_label setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"remainTimes"]]];
            [cell.times_label setText:[NSString stringWithFormat:@"／%@次", [data objectForKey:@"quantity"]]];
            NSString *dateStr = [data objectForKey:@"createDate"];
            if (dateStr && dateStr.length > 10) {
                dateStr = [dateStr substringToIndex:10];
            }
            [cell.buy_label setText:[NSString stringWithFormat:@"购买日期：%@", dateStr]];
            dateStr = [data objectForKey:@"expireDate"];
            if (dateStr && dateStr.length > 10) {
                dateStr = [dateStr substringToIndex:10];
            }
            [cell.term_label setText:[NSString stringWithFormat:@"过期日期：%@", dateStr]];
            [cell.remark_txt setText:[NSString stringWithFormat:@"%@", ([data objectForKey:@"remark"] ? [data objectForKey:@"remark"] : @"")]];
            [cell.count_text setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"count"]]];
            [cell.emp_text setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"emps"]]];
            cell.save_btn.userInteractionEnabled = NO;
            cell.save_icon.hidden = YES;
            if (_commodity_index == indexPath.row) {
                cell.save_btn.userInteractionEnabled = YES;
                cell.save_icon.hidden = NO;
            }
            return cell;
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@1]) {
            BillingGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BillingGoodsCell class]) forIndexPath:indexPath];
            cell.delegate = self;
            cell.tag = indexPath.row;
            NSDictionary *data = [_projInfoList objectAtIndex:indexPath.row];
            [cell.name_label setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"name"]]];
            [cell.price_label setText:[NSString stringWithFormat:@"¥%@", [data objectForKey:@"price"]]];
            [cell.count_text setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"count"]]];
            [cell.price_text setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"price_s"]]];
            [cell.emps_text setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"emps"]]];
            return cell;
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@2]) {
            BillingGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BillingGoodsCell class]) forIndexPath:indexPath];
            cell.delegate = self;
            cell.tag = indexPath.row;
            NSDictionary *data = [_prodInfoList objectAtIndex:indexPath.row];
            [cell.name_label setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"name"]]];
            [cell.price_label setText:[NSString stringWithFormat:@"¥%@", [data objectForKey:@"price"]]];
            [cell.count_text setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"count"]]];
            [cell.price_text setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"price_s"]]];
            [cell.emps_text setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"emps"]]];
            return cell;
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@3]) {
            MemberDepositCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MemberDepositCell class]) forIndexPath:indexPath];
            NSDictionary *data = [[_cardInfoDic objectForKey:@"goods"] objectAtIndex:indexPath.row];
            [cell.pName_lab setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"projectName"]]];
            NSString *dateStr = [data objectForKey:@"createDate"];
            if (dateStr && dateStr.length > 10) {
                dateStr = [dateStr substringToIndex:10];
            }
            [cell.date_label setText:[NSString stringWithFormat:@"%@", dateStr]];
            [cell.sName_label setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"operatorName"]]];
            NSString *number = @"0";
            if ([data objectForKey:@"quantity"]) {
                number = [data objectForKey:@"quantity"];
            }
            [cell.dNumber_label setText:[NSString stringWithFormat:@"%@", number]];
            number = @"0";
            if ([data objectForKey:@"quantity"]) {
                number = [data objectForKey:@"quantity"];
                if ([data objectForKey:@"remainTimes"]) {
                    number = [NSString stringWithFormat:@"%.2f", [number floatValue] - [[data objectForKey:@"remainTimes"] floatValue]];
                }
            }
            [cell.uNumber_label setText:[NSString stringWithFormat:@"%@", number]];
            number = @"0";
            if ([data objectForKey:@"remainTimes"]) {
                number = [data objectForKey:@"remainTimes"];
            }
            [cell.lNumber_label setText:[NSString stringWithFormat:@"%@", number]];
            return cell;
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@4]) {
            TransactionHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TransactionHistoryCell class]) forIndexPath:indexPath];
            NSDictionary *data = [_tradeHistoryList  objectAtIndex:indexPath.row];
            NSString *dateStr = [data objectForKey:@"createDate"];
            if (dateStr && dateStr.length > 10) {
                dateStr = [dateStr substringToIndex:10];
            }
            [cell.date_label setText:[NSString stringWithFormat:@"%@", dateStr]];
            [cell.type_label setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"typeName"]]];
            [cell.name_label setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"shopName"]]];
            NSString *price = @"0";
            if ([data objectForKey:@"amount"]) {
                price = [data objectForKey:@"amount"];
            }
            [cell.price_label setText:[NSString stringWithFormat:@"¥%@", price]];
            [cell.autograph_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [data objectForKey:@"signature"]]]];
            [cell.remark_label setText:@"备注信息"];
            if ([data objectForKey:@"remark"] && [[data objectForKey:@"remark"] length] > 10) {
                [cell.remark_label setText:[NSString stringWithFormat:@"备注：%@", [data objectForKey:@"remark"]]];
            }
            return cell;
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@5]) {
            MemberEarnestCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MemberEarnestCell class]) forIndexPath:indexPath];
            NSDictionary *data = [_memberAdvanceList  objectAtIndex:indexPath.row];
            [cell.type_label setText:[cell.typeList objectAtIndex:[Public checkNumber:[data objectForKey:@"type"] replace:0]]];
            NSString *dateStr = [data objectForKey:@"createDate"];
            if (dateStr && dateStr.length > 10) {
                dateStr = [dateStr substringToIndex:10];
            }
            [cell.date_label setText:[NSString stringWithFormat:@"%@", dateStr]];
            [cell.name_label setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"shopName"]]];
            [cell.amount_label setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"amount"]]];
            [cell.payType_label setText:[NSString stringWithFormat:@"%@", [Public checkString:[data objectForKey:@"payName"]  replace:@"未知"]]];
            [cell.empName_label setText:[NSString stringWithFormat:@"%@", [Public checkString:[data objectForKey:@"sellerName"]  replace:@"未知"]]];
            return cell;
        }
    }
    else if (tableView == _commType_table) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commTypeCell" forIndexPath:indexPath];
        [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
        cell.backgroundColor = RGBCOLOR(245,245,245);
        
        if ([[_functionDic objectForKey:@"flag"] isEqual:@1]) {
            if (indexPath.row == _projTypeIndex) {
                cell.backgroundColor = [UIColor whiteColor];
            }
        }
        if ([[_functionDic objectForKey:@"flag"] isEqual:@2]) {
            if (indexPath.row == _prodTypeIndex) {
                cell.backgroundColor = [UIColor whiteColor];
            }
        }
        if ([[_functionDic objectForKey:@"flag"] isEqual:@1]) {
            NSDictionary *data = [_projStatisticsList objectAtIndex:indexPath.row];
            if ([data objectForKey:@"name"]) {
                [cell.textLabel setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"name"]]];
            }
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@2]) {
            NSDictionary *data = [_prodStatisticsList objectAtIndex:indexPath.row];
            if ([data objectForKey:@"name"]) {
                [cell.textLabel setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"name"]]];
            }
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
        if ([[_functionDic objectForKey:@"flag"] isEqual:@0]) {
            if (_cardInfoDic && [_cardInfoDic objectForKey:@"projects"]) {
                return [[_cardInfoDic objectForKey:@"projects"] count];
            }
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@1]) {
            if (_projInfoList) {
                return [_projInfoList count];
            }
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@2]) {
            if (_prodInfoList) {
                return [_prodInfoList count];
            }
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@3]) {
            if (_cardInfoDic && [_cardInfoDic objectForKey:@"goods"]) {
                return [[_cardInfoDic objectForKey:@"goods"] count];
            }
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@4]) {
            if (_tradeHistoryList) {
                return [_tradeHistoryList count];
            }
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@5]) {
            if (_memberAdvanceList) {
                return [_memberAdvanceList count];
            }
        }
    }
    else if (tableView == _commType_table) {
        if ([[_functionDic objectForKey:@"flag"] isEqual:@1]) {
            if (_projStatisticsList) {
                return [_projStatisticsList count];
            }
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@2]) {
            if (_prodStatisticsList) {
                return [_prodStatisticsList count];
            }
        }
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
        if (_commodity_index == indexPath.row) {
            _commodity_index = -1;
        }
        else {
            _commodity_index = indexPath.row;
        }
        if ([[_functionDic objectForKey:@"flag"] isEqual:@0]) {
            NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:[[_cardInfoDic objectForKey:@"projects"] objectAtIndex:indexPath.row]];
            [data setValue:@"1" forKey:@"count"];
            [data setValue:@"" forKey:@"emps"];
            [[_cardInfoDic objectForKey:@"projects"] replaceObjectAtIndex:indexPath.row withObject:data];
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@1]) {
            NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:[_projInfoList objectAtIndex:indexPath.row]];
            [data setValue:[data objectForKey:@"price"] forKey:@"price_s"];
            [data setValue:@"1" forKey:@"count"];
            [data setValue:@"" forKey:@"emps"];
            [_projInfoList replaceObjectAtIndex:indexPath.row withObject:data];
            
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@2]) {
            NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:[_prodInfoList objectAtIndex:indexPath.row]];
            [data setValue:[data objectForKey:@"price"] forKey:@"price_s"];
            [data setValue:@"1" forKey:@"count"];
            [data setValue:@"" forKey:@"emps"];
            [_prodInfoList replaceObjectAtIndex:indexPath.row withObject:data];
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@3]) {
            
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@4]) {
            
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@5]) {
            
        }
        [_commodity_table reloadData];
    }
    else if (tableView == _commType_table) {
        [_commodity_table.mj_footer endRefreshing];
        if ([[_functionDic objectForKey:@"flag"] isEqual:@1]) {
            _projTypeIndex = indexPath.row;
            _projPage = 1;
            _commodity_table.mj_footer.hidden = NO;
            [self loadRequest:1];
        }
        if ([[_functionDic objectForKey:@"flag"] isEqual:@2]) {
            _prodTypeIndex = indexPath.row;
            _prodPage = 1;
            _commodity_table.mj_footer.hidden = NO;
            [self loadRequest:2];
        }
        [_commType_table reloadData];
    }
}


- (void)popAction:(UIBarButtonItem *)barButtonItem
{
    UIViewController *homePage = self.navigationController.viewControllers[0];
    [self.navigationController popToViewController:homePage animated:YES];
}

- (void)loadRequest:(int) flag {
    NSDictionary *parameDic = @{};
    if (!flag) {
        //支付方式
        //1现金类cashFlag 2销卡类cardFlag 3开单billFlag 4卡异动exchangeFlag(开卡,充值,买套餐) 5疗程销售courseFlag 6退卡refundFlag
        parameDic = @{@"billFlag": @"1"};
        [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetPayType Delegate:self];
        
        //获取服务人数
        parameDic = @{@"key": @"serverCount",
                      @"compId": [m_loginInfo objectForKey:@"compId"]};
        [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetServiceCount Delegate:self];
        
        //获取系统参数
        parameDic = @{@"compId": [m_loginInfo objectForKey:@"compId"]};
        [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetSystemSetting Delegate:self];
        
        //获取大类
        //产品
        parameDic = @{@"type": @"0",
                      @"chainId": [m_loginInfo objectForKey:@"chainId"]};
        [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetProjType Delegate:self];
        //项目
        parameDic = @{@"type": @"1",
                      @"chainId": [m_loginInfo objectForKey:@"chainId"]};
        [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetProdType Delegate:self];
        
        //获取统计分类
        //产品
        parameDic = @{@"type": @"0",
                      @"chainId": [m_loginInfo objectForKey:@"chainId"]};
        [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetProjStatisticsType Delegate:self];
        //项目
        parameDic = @{@"type": @"1",
                      @"chainId": [m_loginInfo objectForKey:@"chainId"]};
        [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetProdStatisticsType Delegate:self];
        
        //获取会员资料
        [[NetworkManage shareNetworkManage] getRequest:nil Tag:NetworkTag_GetMemberInfoByUserId Delegate:self
                                            SpliceInfo:@[[self.memberCard objectForKey:@"userId"], @"get"]];
        
        //获取会员卡资料
        [[NetworkManage shareNetworkManage] getRequest:nil Tag:NetworkTag_GetCardInfoById Delegate:self
                                            SpliceInfo:@[[self.memberCard objectForKey:@"id"], @"get"]];
        
        //获取会员帐户
        parameDic = @{@"userId": [self.memberCard objectForKey:@"userId"]};
        [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetAccountByUserId Delegate:self];
    }
    if (!flag || flag == 1) {
        if (!_projPage) {
            _projPage = 1;
            _projTypeIndex = 0;
        }
        //获取项目列表/api/project/list?type=0&page=
        parameDic = @{@"type": @"0",
                      @"page": [NSNumber numberWithInteger:_projPage]};
        if (_projTypeIndex > 0) {
            parameDic = @{@"type": @"0",
                          @"page": [NSNumber numberWithInteger:_projPage],
                          @"reportCatId": [[_projStatisticsList objectAtIndex:_projTypeIndex] objectForKey:@"id"]};
        }
        [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetProjectList Delegate:self];
    }
    if (!flag || flag == 2) {
        if (!_prodPage) {
            _prodPage = 1;
            _prodTypeIndex = 0;
        }
        //获取产品列表/api/project/list?type=1&page=
        parameDic = @{@"type": @"1",
                      @"page": [NSNumber numberWithInteger:_prodPage]};
        if (_prodTypeIndex > 0) {
            parameDic = @{@"type": @"1",
                          @"page": [NSNumber numberWithInteger:_prodPage],
                          @"reportCatId": [[_prodStatisticsList objectAtIndex:_prodTypeIndex] objectForKey:@"id"]};
        }
        [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetProductList Delegate:self];
    }
    if (!flag || flag == 3) {
        if (!_tradeHisPage) {
            _tradeHisPage = 1;
        }
        //查询会员帐户历史/api/user/card/-/trade/history?page=
        parameDic = @{@"cardId": [self.memberCard objectForKey:@"id"],
                      @"page": [NSNumber numberWithInteger:_tradeHisPage]};
        [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetTradeHistory Delegate:self];
    }
    if (!flag || flag == 4) {
        if (!_memberAdvPage) {
            _memberAdvPage = 1;
        }
        //获取会员保证金账户历史/api/user/-/advance?page=
        parameDic = @{@"userId": [self.memberCard objectForKey:@"userId"],
                      @"page": [NSNumber numberWithInteger:_memberAdvPage]};
        [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetMemberAdvance Delegate:self];
    }
}

/** 网络请求成功 */
- (void)net_requestSuccess:(id)result Tag:(NetworkInterfaceTag)tag {
    [super net_requestSuccess:result Tag:tag];
    if (tag == NetworkTag_UpdateCourseRemark) {
        [self showError:@"修改成功！"];
        return;
    }
    if (tag == NetworkTag_GetPayType) {
        //开单支付方式
        _payTypeList = result;
    }
    if (tag == NetworkTag_GetServiceCount) {
        //获取系统参数
        _systemSetting = result;
    }
    if (tag == NetworkTag_GetProjType) {
        //获取项目大类
        _projectTypeList = result;
    }
    if (tag == NetworkTag_GetProdType) {
        //获取产品大类
        _productTypeList = result;
    }
    if (tag == NetworkTag_GetProjStatisticsType) {
        //获取项目统计分类
        _projStatisticsList = [@[@{@"name": @"全部"}] arrayByAddingObjectsFromArray:result];
    }
    if (tag == NetworkTag_GetProdStatisticsType) {
        //获取产品统计分类
        _prodStatisticsList = [@[@{@"name": @"全部"}] arrayByAddingObjectsFromArray:result];
    }
    if (tag == NetworkTag_GetMemberInfoByUserId) {
        //获取会员资料
        _memberInfoDic = result;
        //姓名
        _name_label.text = @"匿名";
        if (_memberInfoDic && [_memberInfoDic objectForKey:@"realname"]) {
            _name_label.text = [NSString stringWithFormat:@"%@", [_memberInfoDic objectForKey:@"realname"]];
        }
        //负责业务员
        _manager_label.text = @"暂无业务员";
        if (_memberInfoDic && [_memberInfoDic objectForKey:@"belongEmpName"]) {
            _manager_label.text = [NSString stringWithFormat:@"%@", [_memberInfoDic objectForKey:@"belongEmpName"]];
        }
        //头像
        [_avatar_img setImage:[UIImage imageNamed:@"logo_200"]];
        if (_memberInfoDic && [_memberInfoDic objectForKey:@"avatar"]) {
            [_avatar_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/1/w/200/h/200", [_memberInfoDic objectForKey:@"avatar"]]] placeholderImage:[UIImage imageNamed:@"logo_200"]];
        }
    }
    if (tag == NetworkTag_GetCardInfoById) {
        //获取会员卡资料
        _cardInfoDic = [NSMutableDictionary dictionaryWithDictionary:result];
        if ([result objectForKey:@"projects"]) {
            [_cardInfoDic setObject:[NSMutableArray arrayWithArray:[result objectForKey:@"projects"]] forKey:@"projects"];
        }
        if ([result objectForKey:@"goods"]) {
            [_cardInfoDic setObject:[NSMutableArray arrayWithArray:[result objectForKey:@"goods"]] forKey:@"goods"];
        }
        //卡号
        _cardNo_label.text = @"无卡号";
        if (_cardInfoDic && [_cardInfoDic objectForKey:@"cardNo"]) {
            _cardNo_label.text = [NSString stringWithFormat:@"卡号.%@", [_cardInfoDic objectForKey:@"cardNo"]];
        }
        //储值金额
        _accountAmt_lab.text = @"0";
        if (_cardInfoDic && [_cardInfoDic objectForKey:@"balance"]) {
            _accountAmt_lab.text = [NSString stringWithFormat:@"%@", [_cardInfoDic objectForKey:@"balance"]];
        }
        //待付总额
        _accountPay_lab.text = @"0";
        if (_cardInfoDic && [_cardInfoDic objectForKey:@"proOverdraft"]) {
            _accountPay_lab.text = [NSString stringWithFormat:@"%@", [_cardInfoDic objectForKey:@"proOverdraft"]];
        }
        //赠送金额
        _accountGive_lab.text = @"0";
        if (_cardInfoDic && [_cardInfoDic objectForKey:@"innerBestowal"]) {
            _accountGive_lab.text = [NSString stringWithFormat:@"%@", [_cardInfoDic objectForKey:@"innerBestowal"]];
        }
    }
    if (tag == NetworkTag_GetAccountByUserId) {
        //获取会员帐户资料
        _accountInfoDic = result;
    }
    if (tag == NetworkTag_GetProjectList) {
        //获取项目资料
        if (_projPage == 1) {
            _projInfoList = [NSMutableArray arrayWithArray:result];
        }
        else {
            if (result && [result count] > 0) {
                [_projInfoList addObjectsFromArray:result];
            }
            else {
                if (_projPage > 1) {
                    _projPage--;
                }
                _commodity_table.mj_footer.hidden = YES;
            }
        }
    }
    if (tag == NetworkTag_GetProductList) {
        //获取产品资料
        if (_prodPage == 1) {
            _prodInfoList = [NSMutableArray arrayWithArray:result];
        }
        else {
            if (result && [result count] > 0) {
                [_prodInfoList addObjectsFromArray:result];
            }
            else {
                if (_prodPage > 1) {
                    _prodPage--;
                }
                _commodity_table.mj_footer.hidden = YES;
            }
        }
    }
    if (tag == NetworkTag_GetTradeHistory) {
        //获取帐户记录
        if (_tradeHisPage == 1) {
            _tradeHistoryList = [NSMutableArray arrayWithArray:result];
        }
        else {
            if (result && [result count] > 0) {
                [_tradeHistoryList addObjectsFromArray:result];
            }
            else {
                if (_tradeHisPage > 1) {
                    _tradeHisPage--;
                }
                _commodity_table.mj_footer.hidden = YES;
            }
        }
    }
    if (tag == NetworkTag_GetMemberAdvance) {
        //获取会员保证金账户历史
        if (_memberAdvPage == 1) {
            _memberAdvanceList = [NSMutableArray arrayWithArray:result];
        }
        else {
            if (result && [result count] > 0) {
                [_memberAdvanceList addObjectsFromArray:result];
            }
            else {
                if (_memberAdvPage > 1) {
                    _memberAdvPage--;
                }
                _commodity_table.mj_footer.hidden = YES;
            }
        }
    }
    [_commodity_table.mj_footer endRefreshing];
    [_commodity_table reloadData];
    NSLog(@"%@", result);
}

- (void)net_requestFail:(id)result Tag:(NetworkInterfaceTag)tag {
    [self showError:[NSString stringWithFormat:@"%@", result]];
    if (tag == NetworkTag_GetProjectList) {
        //获取项目资料
        if (_projPage > 1) {
            _projPage--;
        }
    }
    if (tag == NetworkTag_GetProductList) {
        //获取产品资料
        if (_prodPage > 1) {
            _prodPage--;
        }
    }
    if (tag == NetworkTag_GetTradeHistory) {
        //获取帐户记录
        if (_tradeHisPage > 1) {
            _tradeHisPage--;
        }
    }
    if (tag == NetworkTag_GetMemberAdvance) {
        //获取会员保证金账户历史
        if (_memberAdvPage > 1) {
            _memberAdvPage--;
        }
    }
    [_commodity_table.mj_footer endRefreshing];
}

#pragma BCommodityCellDelegate
- (void)commodityCell:(NSInteger)row flag:(NSInteger)flag {
    if (flag == -1) {
        //取消
        _commodity_index = -1;
        [_commodity_table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
    else if (flag == -2) {
        //确定
    }
    else if (flag == -3) {
        NSDictionary *data = [[_cardInfoDic objectForKey:@"projects"] objectAtIndex:row];
        //保存备注
        NSDictionary *parameDic = @{@"courseId": [data objectForKey:@"id"],
                                    @"newRemark": [data objectForKey:@"remark"]};
        [[NetworkManage shareNetworkManage] postJsonRequest:NULL subParam:parameDic Tag:NetworkTag_UpdateCourseRemark Delegate:self];
    }
    else if (flag == 0) {
        if (_commodity_index != row) {
            [self tableView:_commodity_table didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
        }
        else {
            NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:[[_cardInfoDic objectForKey:@"projects"] objectAtIndex:row]];
            [self beginFloatInput:[data objectForKey:@"remark"] placeholder:@"请输入备注" result:^(NSString *text) {
                [data setValue:[NSString stringWithFormat:@"%@", text] forKey:@"remark"];
                [[_cardInfoDic objectForKey:@"projects"] replaceObjectAtIndex:row withObject:data];
                [_commodity_table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
    }
    else if (flag == 1) {
        //数量
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:[[_cardInfoDic objectForKey:@"projects"] objectAtIndex:row]];
        [self beginFloatInput:[data objectForKey:@"count"] placeholder:@"请输入数量" result:^(NSString *text) {
            [data setValue:[NSString stringWithFormat:@"%@", text] forKey:@"count"];
            [[_cardInfoDic objectForKey:@"projects"] replaceObjectAtIndex:row withObject:data];
            [_commodity_table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
    else if (flag == 2) {
        //员工
        [self performSegueWithIdentifier:@"chooseEmp" sender:nil];
    }
}

#pragma BGoodsCellDelegate
- (void)goodsCell:(NSInteger)row flag:(NSInteger)flag {
    if (flag == -1) {
        //取消
        _commodity_index = -1;
        [_commodity_table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
    else if (flag == -2) {
        //确定
    }
    else if (flag == 0) {
        //数量
        if ([[_functionDic objectForKey:@"flag"] isEqual:@1]) {
            NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:[_projInfoList objectAtIndex:row]];
            [self beginFloatInput:[data objectForKey:@"count"] placeholder:@"请输入数量" result:^(NSString *text) {
                [data setValue:[NSString stringWithFormat:@"%@", text] forKey:@"count"];
                [_projInfoList replaceObjectAtIndex:row withObject:data];
                [_commodity_table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@2]) {
            NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:[_prodInfoList objectAtIndex:row]];
            [self beginFloatInput:[data objectForKey:@"count"] placeholder:@"请输入数量" result:^(NSString *text) {
                [data setValue:[NSString stringWithFormat:@"%@", text] forKey:@"count"];
                [_prodInfoList replaceObjectAtIndex:row withObject:data];
                [_commodity_table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
    }
    else if (flag == 1) {
        //金额
        if ([[_functionDic objectForKey:@"flag"] isEqual:@1]) {
            NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:[_projInfoList objectAtIndex:row]];
            [self beginFloatInput:[data objectForKey:@"price_s"] placeholder:@"请输入金额" result:^(NSString *text) {
                [data setValue:[NSString stringWithFormat:@"%@", text] forKey:@"price_s"];
                [_projInfoList replaceObjectAtIndex:row withObject:data];
                [_commodity_table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
        else if ([[_functionDic objectForKey:@"flag"] isEqual:@2]) {
            NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:[_prodInfoList objectAtIndex:row]];
            [self beginFloatInput:[data objectForKey:@"price_s"] placeholder:@"请输入金额" result:^(NSString *text) {
                [data setValue:[NSString stringWithFormat:@"%@", text] forKey:@"price_s"];
                [_prodInfoList replaceObjectAtIndex:row withObject:data];
                [_commodity_table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }];
        }
    }
    else if (flag == 2) {
        //员工
        [self performSegueWithIdentifier:@"chooseEmp" sender:nil];
    }
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
