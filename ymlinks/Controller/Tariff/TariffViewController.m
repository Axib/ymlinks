//
//  TariffViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/18.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "TariffViewController.h"
#import "TariffViewCell.h"
#import "TariffReusableView.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "TariffListViewController.h"

@interface TariffViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *tariff_collection;
@property (weak, nonatomic) IBOutlet UIView *bg_view;
@property (nonatomic, strong) NSMutableArray *priceTypeList;
@property (nonatomic, assign) NSInteger selectRow;

@end

@implementation TariffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"价目表";
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)RGBCOLOR(61,70,109).CGColor,
                       (id)RGBCOLOR(182,143,146).CGColor, nil];
    //渐变从左下角开始
    gradient.startPoint = CGPointMake(0, 0);
    //渐变到右上角结束
    gradient.endPoint = CGPointMake(1, 1);
    [self.bg_view.layer addSublayer:gradient];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //header
    flowLayout.sectionHeadersPinToVisibleBounds = YES;
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 10, 1, 10);
    [self.tariff_collection setCollectionViewLayout:flowLayout];

    
    WEAKSELF;
    MJRefreshStateHeader *header = [[MJRefreshStateHeader alloc] init];
    header.stateLabel.textColor = [UIColor whiteColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    header.refreshingBlock = ^{
        [weakSelf getPriceList];
    };
    self.tariff_collection.mj_header = header;
    
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.tariff_collection.mj_header beginRefreshing];
    });

    // Do any additional setup after loading the view.
}

- (void)getPriceList {
    //价目分类
    NSDictionary *parameDic = @{};
    [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetPriceType Delegate:self];
}

/** 网络请求成功 */
- (void)net_requestSuccess:(id)result Tag:(NetworkInterfaceTag)tag {
    [super net_requestSuccess:result Tag:tag];
    if (tag == NetworkTag_GetPriceType) {//价目分类
        _priceTypeList = result;
        [self endRefreshing];
        [_tariff_collection reloadData];
    }
    NSLog(@"%@", result);
}

- (void)net_requestFail:(id)result Tag:(NetworkInterfaceTag)tag {
    [self showError:[NSString stringWithFormat:@"%@", result]];
    [self endRefreshing];
}

- (void)endRefreshing {
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_tariff_collection.mj_header endRefreshing];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TariffViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TariffViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *data = [_priceTypeList objectAtIndex:section];
    return [[data objectForKey:@"priceList"] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _priceTypeList.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    TariffReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TariffReusableView class]) forIndexPath:indexPath];
    [headerView setTag:indexPath.section];
    NSDictionary *data = [_priceTypeList objectAtIndex:indexPath.section];
    [headerView.title_label setText:[data objectForKey:@"name"]];
    [headerView.icon_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/1/w/200/h/200", [data objectForKey:@"coverImg"]]]
                        placeholderImage:[UIImage imageNamed:@"logo_200"]];
    return headerView;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    double width = (self.view.bounds.size.width - 60)/5;
    return CGSizeMake(width, width + 64);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.bounds.size.width, 50);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"intoCommodity" sender:nil];
}

- (IBAction)intoTariffList:(id)sender {
    UIButton *btn = sender;
    TariffReusableView *headerView = (TariffReusableView *)[btn superview];
    _selectRow = [headerView tag];
    [self performSegueWithIdentifier:@"intoTariffList" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //////这里toVc是拉的那条线的标识符
    if ([segue.identifier isEqualToString:@"intoTariffList"]) {
        TariffListViewController *theVc = segue.destinationViewController;
//        theVc.delegate = self;
        theVc.priceType = [_priceTypeList objectAtIndex:_selectRow];;////传的参数
    }
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
