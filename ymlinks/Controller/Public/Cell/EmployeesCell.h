//
//  EmployeesCell.h
//  ymlinks
//
//  Created by nick on 2019/1/6.
//  Copyright © 2019年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmployeesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *content_view;
@property (weak, nonatomic) IBOutlet UIView *info_view;
@property (weak, nonatomic) IBOutlet UIImageView *status_icon;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *serType_label;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btns;


@property (assign, nonatomic) BOOL choice;

- (void)setInfo:(NSDictionary *) empInfo;

@end
