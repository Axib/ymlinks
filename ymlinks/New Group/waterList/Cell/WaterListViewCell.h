//
//  WaterListViewCell.h
//  ymlinks
//
//  Created by nick on 2018/12/23.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterListViewCell : UICollectionViewCell<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *cardno_label;
@property (weak, nonatomic) IBOutlet UILabel *billno_label;
@property (weak, nonatomic) IBOutlet UILabel *time_label;
@property (weak, nonatomic) IBOutlet UITableView *main_table;
@property (nonatomic, strong) NSArray *infoList;


@end
