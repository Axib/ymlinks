//
//  WaterDetailViewCell.h
//  ymlinks
//
//  Created by nick on 2018/12/23.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterDetailViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *content_view;
@property (weak, nonatomic) IBOutlet UIView *info_view;
@property (weak, nonatomic) IBOutlet UILabel *staff_label;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *times_label;

- (void)setInfo:(NSDictionary *) info;

@end
