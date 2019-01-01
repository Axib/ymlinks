//
//  BillingGoodsCell.h
//  ymlinks
//
//  Created by nick on 2019/1/1.
//  Copyright © 2019年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillingGoodsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *price_label;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cell_views;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btns;

@end
