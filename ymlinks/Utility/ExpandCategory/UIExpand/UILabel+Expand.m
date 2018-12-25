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


//获取字符串的宽度
- (void)ex_widthForText:(CGFloat) padding{
    CGSize sizeToFit = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    //此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, sizeToFit.width + padding, self.frame.size.height)];
}
//获得字符串的高度
- (void)ex_heightForText:(CGFloat) padding{
    CGSize sizeToFit = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
    //此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, sizeToFit.height + padding)];
}

@end
