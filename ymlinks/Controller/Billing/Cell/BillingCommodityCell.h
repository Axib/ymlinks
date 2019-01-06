//
//  BillingCommodityCell.h
//  ymlinks
//
//  Created by nick on 2019/1/1.
//  Copyright © 2019年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BCommodityCellDelegate <NSObject>
- (void)commodityCell:(NSInteger) row flag:(NSInteger) flag;
@end

@interface BillingCommodityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *price_label;
@property (weak, nonatomic) IBOutlet UILabel *times_label;
@property (weak, nonatomic) IBOutlet UILabel *buy_label;
@property (weak, nonatomic) IBOutlet UILabel *term_label;
@property (weak, nonatomic) IBOutlet UITextField *remark_txt;
@property (weak, nonatomic) IBOutlet UITextField *count_text;
@property (weak, nonatomic) IBOutlet UITextField *emp_text;
@property (weak, nonatomic) IBOutlet UIImageView *save_icon;
@property (weak, nonatomic) IBOutlet UIButton *save_btn;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cell_views;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btns;

@property (strong, nonatomic) id <BCommodityCellDelegate> delegate;


@end
