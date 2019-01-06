//
//  BillingCommodityCell.m
//  ymlinks
//
//  Created by nick on 2019/1/1.
//  Copyright © 2019年 ym. All rights reserved.
//

#import "BillingCommodityCell.h"

@implementation BillingCommodityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    /**
     改拉线条，解决拉伸问题
     for (UIView *item in _cell_views) {
        [Public setBorderWithView:item.layer top:NO left:NO bottom:true right:NO borderColor:RGBCOLOR(238, 238, 238) borderWidth:1];
    }*/
    
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
        [_delegate commodityCell:self.tag flag:tap.view.tag];
    }
}
- (IBAction)cancelChoose:(id)sender {
    if (_delegate) {
        [_delegate commodityCell:self.tag flag:-1];
    }
}
- (IBAction)sureChoose:(id)sender {
    if (_delegate) {
        [_delegate commodityCell:self.tag flag:-2];
    }
}
- (IBAction)saveRemark:(id)sender {
    if (_delegate) {
        [_delegate commodityCell:self.tag flag:-3];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)save_btn:(id)sender {
}
@end
