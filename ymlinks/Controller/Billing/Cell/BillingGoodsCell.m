//
//  BillingGoodsCell.m
//  ymlinks
//
//  Created by nick on 2019/1/1.
//  Copyright © 2019年 ym. All rights reserved.
//

#import "BillingGoodsCell.h"

@implementation BillingGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    for (UIButton *item in _btns) {
        item.layer.cornerRadius = 2;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
