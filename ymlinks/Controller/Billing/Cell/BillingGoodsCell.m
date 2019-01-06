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
    
    UITapGestureRecognizer *tap;
    int tag = 0;
    for (UIView *view in _cell_views) {
        view.tag = tag;
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCellView:)];
        [view addGestureRecognizer:tap];
        tag++;
    }
}

- (void)tapCellView:(UITapGestureRecognizer *) tap {
    if (_delegate) {
        [_delegate goodsCell:self.tag flag:tap.view.tag];
    }
}
- (IBAction)cancelChoose:(id)sender {
    if (_delegate) {
        [_delegate goodsCell:self.tag flag:-1];
    }
}
- (IBAction)sureChoose:(id)sender {
    if (_delegate) {
        [_delegate goodsCell:self.tag flag:-2];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
