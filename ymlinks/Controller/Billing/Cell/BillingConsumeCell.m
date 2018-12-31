//
//  BillingConsumeCell.m
//  ymlinks
//
//  Created by nick on 2018/12/31.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "BillingConsumeCell.h"

@implementation BillingConsumeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [Public setBorderWithView:self.layer
                          top:true
                         left:false
                       bottom:false
                        right:false
                  borderColor:RGBCOLOR(221,221,221)
                  borderWidth:1];
    [Public setBorderWithView:self.staff_view.layer
                          top:false
                         left:false
                       bottom:true
                        right:false
                  borderColor:RGBCOLOR(221,221,221)
                  borderWidth:1];
    [Public setBorderWithView:self.staff1_lab.layer
                          top:false
                         left:false
                       bottom:false
                        right:true
                  borderColor:RGBCOLOR(221,221,221)
                  borderWidth:1];
    [Public setBorderWithView:self.staff2_lab.layer
                          top:false
                         left:false
                       bottom:false
                        right:true
                  borderColor:RGBCOLOR(221,221,221)
                  borderWidth:1];
    
    for (UILabel *item in _labs) {
        item.layer.cornerRadius = 2;
        item.layer.masksToBounds = YES;
    }
    
    _type_lab.layer.borderColor = [UIColor redColor].CGColor;
    _type_lab.layer.borderWidth = 1;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
