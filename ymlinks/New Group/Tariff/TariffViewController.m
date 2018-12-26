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

@interface TariffViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *tariff_collection;
@property (weak, nonatomic) IBOutlet UIView *bg_view;

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
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.tariff_collection setCollectionViewLayout:flowLayout];
    
    WEAKSELF;
    MJRefreshStateHeader *header = [[MJRefreshStateHeader alloc] init];
    header.stateLabel.textColor = [UIColor whiteColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    header.refreshingBlock = ^{
        [weakSelf getPriceList];
    };
    self.tariff_collection.mj_header = header;

    // Do any additional setup after loading the view.
}

- (void)getPriceList {
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
    return 5 + section;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    TariffReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([TariffReusableView class]) forIndexPath:indexPath];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
