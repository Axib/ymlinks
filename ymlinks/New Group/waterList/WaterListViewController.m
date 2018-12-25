//
//  WaterListViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "WaterListViewController.h"
#import "DateSelectPopView.h"
#import "WaterListViewCell.h"
#import "MJRefresh.h"
#import "WaterDetailViewController.h"

@interface WaterListViewController ()<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, WaterRefreshDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *content_collection;
@property (weak, nonatomic) IBOutlet UIView *info_view;
@property (weak, nonatomic) IBOutlet UIView *title_view;
@property (weak, nonatomic) IBOutlet UIButton *from_btn;
@property (weak, nonatomic) IBOutlet UIButton *to_btn;
@property (weak, nonatomic) IBOutlet UIButton *search_btn;
@property (nonatomic, strong) DateSelectPopView *dateSelect;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *circular_views;
@property (weak, nonatomic) IBOutlet UILabel *man_label;
@property (weak, nonatomic) IBOutlet UILabel *woman_label;
@property (weak, nonatomic) IBOutlet UILabel *old_label;
@property (weak, nonatomic) IBOutlet UILabel *newly_label;
@property (weak, nonatomic) IBOutlet UIButton *project_btn;
@property (weak, nonatomic) IBOutlet UIButton *product_btn;
@property (weak, nonatomic) IBOutlet UIButton *sellinfo_btn;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *waterList;
@property (nonatomic, strong) NSDictionary *waterInfo;
@property (nonatomic, strong) NSDictionary *detailInfo;

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
    
    _from_btn.layer.borderColor = _to_btn.layer.borderColor = _search_btn.layer.borderColor = RGBCOLOR(188, 140, 53).CGColor;
    _from_btn.layer.borderWidth = _to_btn.layer.borderWidth = _search_btn.layer.borderWidth = 1;
    _from_btn.layer.cornerRadius = _to_btn.layer.cornerRadius = _search_btn.layer.cornerRadius = 3;
    NSString *dateStr = [[NSDate date] ex_getDataStrWithFormatType:@"yyyy-MM-dd"];
    [_from_btn setTitle:dateStr forState:UIControlStateNormal];
    [_to_btn setTitle:dateStr forState:UIControlStateNormal];
    
    for (UIView *item in _circular_views) {
        item.layer.cornerRadius = item.frame.size.width/2.0;
    }
    
    _page = 1;
    
    WEAKSELF;
    _content_collection.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf searchData:nil];
    }];
    
    _content_collection.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (_waterList.count > 0) {
            weakSelf.page += 1;
        }
        [weakSelf searchData:nil];
    }];
    [self waterRefresh];
    // Do any additional setup after loading the view.
}

- (void)endTableViewRefresh {
    [_content_collection.mj_header endRefreshing];
    [_content_collection.mj_footer endRefreshing];
}

- (IBAction)chooseDate:(id)sender {
    _flag = [sender tag];
    [self.m_dateSelectPopView show];
}

- (DateSelectPopView *)m_dateSelectPopView {
    if (_dateSelect == nil) {
        _dateSelect = [[DateSelectPopView alloc] initWithFinishSelect:^(NSDate *date) {
            if (_flag == 1) {
                [_from_btn setTitle:[date ex_getDataStrWithFormatType:@"yyyy-MM-dd"] forState:UIControlStateNormal];

            }
            else if (_flag == 2) {
                [_to_btn setTitle:[date ex_getDataStrWithFormatType:@"yyyy-MM-dd"] forState:UIControlStateNormal];

            }
        }];
    }
    
    return _dateSelect;
}
- (IBAction)searchData:(id)sender {
    NSDate *fromDate = [NSDate ex_getDateWithDateStr:_from_btn.titleLabel.text AndFormat:@"yyyy-MM-dd"];
    NSDate *toDate = [NSDate ex_getDateWithDateStr:_to_btn.titleLabel.text AndFormat:@"yyyy-MM-dd"];
    if (fromDate.timeIntervalSince1970 > toDate.timeIntervalSince1970) {
        [self showError:@"查询开始日期不能大于截止日期！"];
        return;
    }
    
    //流水body
    NSDictionary *parameDic = @{@"page": [NSNumber numberWithInteger:_page],
                  @"beginDate": _from_btn.titleLabel.text,
                  @"endDate": _to_btn.titleLabel.text,
                  @"type": @"1"};
    //流水单
    [[NetworkManage shareNetworkManage] postJsonRequest:parameDic Tag:NetworkTag_GetWaterList Delegate:self];
    //流水信息
    if (_page == 1) {
        parameDic = @{@"page": [NSNumber numberWithInteger:_page],
                      @"beginDate": _from_btn.titleLabel.text,
                      @"endDate": _to_btn.titleLabel.text,
                      @"searchType": @"1"};
        [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetWaterInfo Delegate:self];
    }
}


/** 网络请求成功 */
- (void)net_requestSuccess:(id)result Tag:(NetworkInterfaceTag)tag {
    [super net_requestSuccess:result Tag:tag];
    if (tag == NetworkTag_GetWaterList) {//返回 流水配
        if (_page == 1) {
            _waterList = [[NSArray alloc] init];
        }
        if (!result || result) {
            NSArray *tempArry = result;
            if (tempArry.count > 0) {
                _waterList = [_waterList arrayByAddingObjectsFromArray:result];
            }
            else if (_page != 1) {
                _page--;
            }
        }
        else if (_page != 1) {
            _page--;
        }
        [self endTableViewRefresh];
        [_content_collection reloadData];
    }
    else if (tag == NetworkTag_GetWaterInfo) {
        _waterInfo = @{};
        if (!result || result) {
            NSArray *tempArry = result;
            if (tempArry.count > 0) {
                _waterInfo = tempArry[0];
            }
        }
        //男客
        _man_label.text = @"男客: 0";
        if ([_waterInfo objectForKey:@"manCusCount"]) {
            _man_label.text = [NSString stringWithFormat:@"男客: %@", [_waterInfo objectForKey:@"manCusCount"]];
        }
        //女客
        _woman_label.text = @"女客: 0";
        if ([_waterInfo objectForKey:@"ladyCusCount"]) {
            _woman_label.text = [NSString stringWithFormat:@"女客: %@", [_waterInfo objectForKey:@"ladyCusCount"]];
        }
        //老客
        _old_label.text = @"老客: 0";
        if ([_waterInfo objectForKey:@"oldCusCount"]) {
            _old_label.text = [NSString stringWithFormat:@"老客: %@", [_waterInfo objectForKey:@"oldCusCount"]];
        }
        //新客
        _newly_label.text = @"新客: 0";
        if ([_waterInfo objectForKey:@"newCusCount"]) {
            _newly_label.text = [NSString stringWithFormat:@"新客: %@", [_waterInfo objectForKey:@"newCusCount"]];
        }
        //项目
        [_project_btn setTitle:@"产品 0.00" forState:UIControlStateNormal];
        if ([_waterInfo objectForKey:@"totalProjectPerformance"]) {
            [_project_btn setTitle:[NSString stringWithFormat:@"项目 %.2f", [(NSString *)[_waterInfo objectForKey:@"totalProjectPerformance"] floatValue]] forState:UIControlStateNormal];
        }
        //产品
        [_product_btn setTitle:@"产品 0.00" forState:UIControlStateNormal];
        if ([_waterInfo objectForKey:@"totalProductPerformance"]) {
            [_product_btn setTitle:[NSString stringWithFormat:@"产品 %.2f",  [(NSString *)[_waterInfo objectForKey:@"totalProductPerformance"] floatValue]] forState:UIControlStateNormal];
        }
        //售卡
         [_sellinfo_btn setTitle:@"产品 0.00" forState:UIControlStateNormal];
        if ([_waterInfo objectForKey:@"totalRechargePerformance"]) {
            [_sellinfo_btn setTitle:[NSString stringWithFormat:@"售卡 %.2f",  [(NSString *)[_waterInfo objectForKey:@"totalRechargePerformance"] floatValue]] forState:UIControlStateNormal];
        }
    }
    NSLog(@"%@", result);
}

- (void)net_requestFail:(id)result Tag:(NetworkInterfaceTag)tag {
    if (_page != 1) {
        _page--;
    }
    [self showError:[NSString stringWithFormat:@"%@", result]];
    [self endTableViewRefresh];
}



#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WaterListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WaterListViewCell class]) forIndexPath:indexPath];
    cell.layer.cornerRadius = 3;
    NSDictionary *data = [_waterList objectAtIndex:indexPath.row];
    cell.cardno_label.text = [data objectForKey:@"cardNo"];
    cell.billno_label.text = [data objectForKey:@"smallNo"];
    NSString *dateStr = [data objectForKey:@"createDate"];
    cell.time_label.text = dateStr;
    //格式化
    if (dateStr) {
        cell.time_label.text = [[NSDate ex_getDateWithDateStr:dateStr AndFormat:@"yyyy-MM-dd HH:mm:ss.S"] ex_getDataStrWithFormatType:@"MM-dd hh:mm"];
    }
    cell.infoList = [data objectForKey:@"projectInfos"];
    [cell.main_table reloadData];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _waterList.count;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    double width = (collectionView.bounds.size.width - 15*4)/3;
    return CGSizeMake(width, 160);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(collectionView.frame.size.width, _waterList.count > 0 ? 0 : collectionView.frame.size.height - 70);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"jumpOrderDetial" sender:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterListViewCell *cell = (WaterListViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell.main_table reloadData];
    _detailInfo = [_waterList objectAtIndex:indexPath.row];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //////这里toVc是拉的那条线的标识符
    if ([segue.identifier isEqualToString:@"jumpOrderDetial"]) {
        WaterDetailViewController *theVc = segue.destinationViewController;
        theVc.delegate = self;
        theVc.infoDic = _detailInfo;////传的参数
    }
}

#pragma WaterRefreshDelegate
- (void)waterRefresh {
    WEAKSELF;
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.content_collection.mj_header beginRefreshing];
    });
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
