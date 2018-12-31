//
//  WaterDetailViewCell.m
//  ymlinks
//
//  Created by nick on 2018/12/23.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "WaterDetailViewCell.h"

@implementation WaterDetailViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.content_view.layer.borderColor = RGBCOLOR(230, 230, 230).CGColor;
    self.content_view.layer.borderWidth = 1;
    self.paytype_label.layer.cornerRadius = 2;
    self.labs = [[NSMutableArray alloc] init];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfo:(NSDictionary *) info {
    self.name_label.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"projectName"]];
    [self.name_label ex_widthForText: 0];
    [self.paytype_label setFrame:CGRectMake(self.name_label.frame.origin.x + self.name_label.frame.size.width + 5,
                                            self.paytype_label.frame.origin.y,
                                            self.paytype_label.frame.size.width,
                                            self.paytype_label.frame.size.height)];
    self.paytype_label.text = [NSString stringWithFormat:@"%@", [info objectForKey:@"payTypeName"]];
    [self.paytype_label ex_widthForText: 14];
    self.times_label.text = [NSString stringWithFormat:@"¥%@", [info objectForKey:@"amount"]];
    if ([[info objectForKey:@"payType"] isEqualToString:@"COURSE"]) {
        self.times_label.text = [NSString stringWithFormat:@"%@次", [info objectForKey:@"quantity"]];
    }
    NSString *staffInfo = @"未分配员工";
    if ([info objectForKey:@"projectEmps"]) {
        NSArray *emps = [info objectForKey:@"projectEmps"];
        if (emps.count > 0) {
            staffInfo = @"";
            for (int i = 0; i < emps.count; i++) {
                NSDictionary *staff = emps[i];
                staffInfo = [NSString stringWithFormat:@"%@%@%@", staffInfo, (staffInfo.length ? @"、" : @""), [staff objectForKey:@"empName"]];
            }
        }
    }
    self.staff_label.text = staffInfo;

}

@end
