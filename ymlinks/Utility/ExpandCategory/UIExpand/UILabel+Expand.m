//
//  UILabel+Expand.m
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "UILabel+Expand.h"

@implementation UILabel (Expand)

+ (instancetype)ex_labelWithFrame:(CGRect)frame Text:(NSString *)text TextColor:(UIColor *)textColor TextAlignment:(NSTextAlignment)textAlignment Font:(UIFont *)font{
    
    UILabel *label      = [[[self class] alloc] initWithFrame:frame];
    label.text          = text;
    label.textColor     = textColor;
    label.textAlignment = textAlignment;
    label.font          = font;
    
    return label;
}

- (void)ex_setLineSpacing:(CGFloat)lineSpacing{
    NSMutableAttributedString *attStr = [self.attributedText mutableCopy];
    
    if (attStr == nil)
        attStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment                = self.textAlignment;
    
    [style setLineSpacing:lineSpacing];
    
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.text.length)];
    
    self.attributedText = attStr;
}
@end
