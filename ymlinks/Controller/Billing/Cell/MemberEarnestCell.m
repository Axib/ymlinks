//
//  MemberEarnestCell.m
//  ymlinks
//
//  Created by nick on 2019/1/2.
//  Copyright © 2019年 ym. All rights reserved.
//

#import "MemberEarnestCell.h"

@implementation MemberEarnestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _typeList = @[@"未知", @"存入", @"取现", @"消费抵扣", @"充值抵扣"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
