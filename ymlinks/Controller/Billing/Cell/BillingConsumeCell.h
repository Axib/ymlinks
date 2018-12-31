//
//  BillingConsumeCell.h
//  ymlinks
//
//  Created by nick on 2018/12/31.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillingConsumeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *staff_view;
@property (weak, nonatomic) IBOutlet UILabel *staff1_lab;
@property (weak, nonatomic) IBOutlet UILabel *staff2_lab;
@property (weak, nonatomic) IBOutlet UILabel *staff3_lab;
@property (weak, nonatomic) IBOutlet UILabel *type_lab;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *payType_lab;
@property (weak, nonatomic) IBOutlet UILabel *staffType1_lab;
@property (weak, nonatomic) IBOutlet UILabel *staffType2_lab;
@property (weak, nonatomic) IBOutlet UILabel *staffType3_lab;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labs;


@end
