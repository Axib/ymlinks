//
//  MemberEarnestCell.h
//  ymlinks
//
//  Created by nick on 2019/1/2.
//  Copyright © 2019年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberEarnestCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *type_label;
@property (weak, nonatomic) IBOutlet UILabel *date_label;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *amount_label;
@property (weak, nonatomic) IBOutlet UILabel *payType_label;
@property (weak, nonatomic) IBOutlet UILabel *empName_label;
@property (strong, nonatomic) NSArray *typeList;
@end
