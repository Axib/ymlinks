//
//  EmployeesCell.m
//  ymlinks
//
//  Created by nick on 2019/1/6.
//  Copyright © 2019年 ym. All rights reserved.
//

#import "EmployeesCell.h"

@implementation EmployeesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.content_view.layer.borderColor = RGBCOLOR(230, 230, 230).CGColor;
    self.content_view.layer.borderWidth = 1;
    // Initialization code
}

- (void)setInfo:(NSDictionary *) empInfo {
    BOOL choice = false;
    int index = 0;
    NSString *empName = @"未知";
    if (empInfo) {
        if ([empInfo objectForKey:@"choice"]) {
            choice = [[empInfo objectForKey:@"choice"] boolValue];
        }
        if ([empInfo objectForKey:@"serviceLevel"]) {
            index = [[empInfo objectForKey:@"serviceLevel"] intValue];
        }
        if ([empInfo objectForKey:@"empNo"]) {
            empName = [NSString stringWithFormat:@"%@", [empInfo objectForKey:@"empNo"]];
        }
        if ([empInfo objectForKey:@"realname"]) {
            empName = [NSString stringWithFormat:@"%@-%@", empName, [empInfo objectForKey:@"realname"]];
        }
    }
    for (UIButton *btn in _btns) {
        [btn setImage:[UIImage imageNamed:@"img_check_0_02"] forState:UIControlStateNormal];
        btn.hidden = choice;
    }
    [[_btns objectAtIndex:index] setImage:[UIImage imageNamed:@"img_check_1_02"] forState:UIControlStateNormal];
    [_name_label setText:empName];
}

- (IBAction)chooseServiceLevel:(id)sender {
    for (UIButton *btn in _btns) {
        if (btn == sender) {
            [btn setImage:[UIImage imageNamed:@"img_check_1_02"] forState:UIControlStateNormal];
        }
        else {
            [btn setImage:[UIImage imageNamed:@"img_check_0_02"] forState:UIControlStateNormal];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
