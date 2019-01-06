//
//  TransactionHistoryCell.h
//  ymlinks
//
//  Created by nick on 2019/1/1.
//  Copyright © 2019年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionHistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *date_label;
@property (weak, nonatomic) IBOutlet UILabel *type_label;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *price_label;
@property (weak, nonatomic) IBOutlet UIImageView *autograph_img;
@property (weak, nonatomic) IBOutlet UILabel *remark_label;
@end
