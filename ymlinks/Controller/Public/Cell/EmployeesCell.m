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

- (void)setInfo:(NSDictionary *) empInfo ser:(int) ser type:(int) type {
    int index = 0;
    NSString *empName = @"未知";
    if (empInfo) {
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
    [_status_icon setImage:[UIImage imageNamed:(ser >= 0 ? @"img_radio_1_01" : @"img_radio_0_01")]];
    for (UIButton *btn in _btns) {
        [btn setImage:[UIImage imageNamed:@"img_check_0_02"] forState:UIControlStateNormal];
        btn.hidden = ser < 0;
    }
    if (ser < 0 || ser > 2) {
        _serType_label.hidden = true;
        _serType_label.text = @"";
    }
    else {
        _serType_label.hidden = false;
        _serType_label.text = @[@"美发师", @"技师", @"助理"][ser];
    }
    [[_btns objectAtIndex:index] setImage:[UIImage imageNamed:@"img_check_1_02"] forState:UIControlStateNormal];
    [_name_label setText:empName];
    [_name_label ex_widthForText:5];
    CGRect rect = _name_label.frame;
    if (rect.size.width > _info_view.frame.size.width - 240) {
        rect.size.width = _info_view.frame.size.width - 240;
        [_name_label setFrame:rect];
    }
    CGRect rect2 = _serType_label.frame;
    rect2.origin.x = rect.origin.x + rect.size.width + 5;
    [_serType_label setFrame:rect2];
    
    [self chooseServiceLevel:[_btns objectAtIndex:type]];
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
    if (_delegate) {
        [_delegate employeesCell:self.tag type:[sender tag]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
