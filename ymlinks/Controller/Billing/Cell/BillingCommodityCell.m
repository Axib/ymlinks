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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
