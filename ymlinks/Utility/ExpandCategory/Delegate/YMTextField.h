//
//  YMTextField.h
//  ymlinks
//
//  Created by nick on 2018/12/31.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMTextField;
@protocol YMTextFieldDelegate <NSObject>
- (void)ymTextFieldDeleteBackward:(YMTextField *)textField;
@end

@interface YMTextField : UITextField

@property (nonatomic, assign) id <YMTextFieldDelegate> ym_delegate;

@end
