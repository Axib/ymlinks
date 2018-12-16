//
//  UITextField+Expand.m
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "UITextField+Expand.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
@implementation UITextField (Expand)

+ (instancetype)ex_textFieldWithFrame:(CGRect)frame KeyboardType:(UIKeyboardType)keyboardType Placeholder:(NSString *)placeholder TextAlignment:(NSTextAlignment)textAlignment Delegate:(id<UITextFieldDelegate>)delegate{
    
    UITextField *textField      = [[[self class] alloc] initWithFrame:frame];
    textField.keyboardType      = keyboardType;
    textField.placeholder       = placeholder;
    textField.font              = [UIFont systemFontOfSize:14];
    textField.textAlignment     = textAlignment;
    textField.textColor         = RGBCOLOR(40, 40, 40);
    textField.delegate          = delegate;
    textField.clearButtonMode   = UITextFieldViewModeWhileEditing;
    
    return textField;
}

+ (instancetype)ex_defaultSearchTextFieldWithFrame:(CGRect)frame
                                       Placeholder:(NSString *)placeholder
                                          Delegate:(id<UITextFieldDelegate>)delegate
                                            Target:(id)target Action:(SEL)action {
    
    UITextField *textField = [[self class] ex_textFieldWithFrame:frame
                                                    KeyboardType:UIKeyboardTypeDefault
                                                     Placeholder:placeholder
                                                   TextAlignment:NSTextAlignmentLeft Delegate:delegate];
    
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField ex_setBorderWidth:15.f IsLeft:true];
    
    UIButton *searchBtn = [UIButton ex_buttonWithFrame:CGRectMake(0, 0, 60, 42)
                                                NorImg:[UIImage imageNamed:@"Icon_Search"] selImg:nil
                                                Target:target Action:action];
    
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"Button_LightBlue"] forState:UIControlStateNormal];
    
    [textField setRightView:searchBtn];
    [textField setRightViewMode:UITextFieldViewModeAlways];
    [textField ex_setLayerCornerRadius:5.f AndBorderColor:nil];
    
    return textField;
}

- (void)ex_setLeftViewWithImg:(UIImage *)img{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.contentMode  = UIViewContentModeCenter;
    imgView.frame        = CGRectMake(0, 0, 35, CGRectGetHeight(self.frame));
    
    self.leftView        = imgView;
    self.leftViewMode    = UITextFieldViewModeAlways;
}

- (void)ex_setLeftViewWithText:(NSString *)text{
    UILabel *label    = [[UILabel alloc] init];
    label.text        = text;
    label.textColor   = RGBCOLOR(40, 40, 40);
    label.font        = [UIFont systemFontOfSize:14];
    
    [label sizeToFit];
    self.leftView     = label;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)ex_setBorderWidth:(CGFloat)width IsLeft:(BOOL)isLeft{
    UIView *view   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    
    if (isLeft) {
        self.leftView     = view;
        self.leftViewMode = UITextFieldViewModeAlways;
    }else{
        self.rightView      = view;
        self.rightViewMode  = UITextFieldViewModeAlways;
    }
}

- (void)ex_setRightViewWithImg:(UIImage *)img{
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.contentMode  = UIViewContentModeCenter;
    imgView.frame        = CGRectMake(0, 0, 30, CGRectGetHeight(self.frame));
    
    self.rightView       = imgView;
    self.rightViewMode   = UITextFieldViewModeAlways;
}

- (void)ex_setRightViewWithText:(NSString *)text{
    UILabel *label    = [[UILabel alloc] init];
    label.text        = text;
    label.textColor   = RGBCOLOR(40, 40, 40);
    label.font        = [UIFont systemFontOfSize:14];
    
    [label sizeToFit];
    self.rightView     = label;
    self.rightViewMode = UITextFieldViewModeAlways;
}

- (void)ex_setPlaceholderColor:(UIColor *)color {
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)ex_setPlaceholderFont:(UIFont *)font {
    [self setValue:font forKeyPath:@"_placeholderLabel.font"];
}



- (BOOL)ex_canOnlyEnterAnIntegerWithReplacementString:(NSString *)string InRange:(NSRange)range {
    if ([string isEqualToString:@""])
        return true;
    
    return [NSString ex_isPureInt:string];
}

- (void)ex_setLayerCornerRadius:(CGFloat)radius AndBorderColor:(UIColor *)borderColor{
    self.layer.borderWidth   = 1.f;
    self.layer.borderColor   = [borderColor CGColor];
    self.layer.cornerRadius  = radius;
    self.layer.masksToBounds = true;
}

@end
