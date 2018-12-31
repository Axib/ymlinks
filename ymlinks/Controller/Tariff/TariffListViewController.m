//
//  TariffListViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/30.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "TariffListViewController.h"
#import "TariffViewCell.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface TariffListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *tariff_collection;
@property (weak, nonatomic) IBOutlet UIView *bg_view;
@property (nonatomic, strong) NSMutableArray *priceList;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) double cellWidth;

@end

@implementation TariffListViewController

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
    
    _cellWidth = (self.view.bounds.size.width - 60)/5;
    
    WEAKSELF;
    MJRefreshStateHeader *header = [[MJRefreshStateHeader alloc] init];
    header.stateLabel.textColor = [UIColor whiteColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    header.refreshingBlock = ^{
        weakSelf.page = 1;
        [weakSelf getPriceList];
    };
    self.tariff_collection.mj_header = header;
    
    MJRefreshAutoStateFooter *footer = [[MJRefreshAutoStateFooter alloc] init];
    footer.stateLabel.textColor = [UIColor whiteColor];
    footer.refreshingBlock = ^{
        if (_priceList.count > 0) {
            weakSelf.page += 1;
        }
        [weakSelf getPriceList];
    };
    _tariff_collection.mj_footer = footer;
//    _tariff_collection.mj_footer.auth
        
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.tariff_collection.mj_header beginRefreshing];
    });
    // Do any additional setup after loading the view.
}

- (void)getPriceList {
    //价目表
    NSDictionary *parameDic = @{@"page": [NSNumber numberWithInteger:_page],
                                @"catId":[_priceType objectForKey:@"id"]};
    [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetPriceList Delegate:self];
}

/** 网络请求成功 */
- (void)net_requestSuccess:(id)result Tag:(NetworkInterfaceTag)tag {
    [super net_requestSuccess:result Tag:tag];
    if (tag == NetworkTag_GetPriceList) {//价目列表
        if (_page == 1) {
            _priceList = [[NSMutableArray alloc] init];
        }
        if (!result || result) {
            NSArray *tempArry = result;
            if (tempArry.count > 0) {
                [_priceList addObjectsFromArray:result];
            }
            else if (_page != 1) {
                _page--;
            }
        }
        else if (_page != 1) {
            _page--;
        }
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
        [_tariff_collection.mj_footer endRefreshing];
    });
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TariffViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TariffViewCell class]) forIndexPath:indexPath];
    NSDictionary *data = [_priceList objectAtIndex:indexPath.row];
    [cell.name_label setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"name"]]];
    [cell.picture_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/1/w/%i/h/%i", [data objectForKey:@"coverImg"], (int)_cellWidth, (int)_cellWidth]]
                             placeholderImage:[UIImage imageNamed:@"logo_200"]];
     [cell.price_label setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"discountPrice"]]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_priceList count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_cellWidth, _cellWidth + 64);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    int rowCount = ((int)[_priceList count]/5 + ([_priceList count]%5 > 0 ? 1 : 0));
    float footerHeight = collectionView.frame.size.height - ((_cellWidth + 64) * rowCount) - 64;
    footerHeight = footerHeight < 0 ? 0 : footerHeight;
    return CGSizeMake(0, footerHeight);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"jumpCommodity" sender:nil];
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
