//
//  TariffViewCell.m
//  ymlinks
//
//  Created by nick on 2018/12/19.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "TariffViewCell.h"

@implementation TariffViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        
        CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.width);
        //    rect.size.height = 160;
        //商品图
        self.picture_img = [UIImageView ex_imageViewWithFrame:rect Image:[UIImage imageNamed:@"icon_bg_01"] ContentMode:UIViewContentModeCenter];
        self.picture_img.userInteractionEnabled = false;
        self.picture_img.contentMode  = UIViewContentModeScaleAspectFill;
        self.picture_img.layer.masksToBounds = true;
        [self.contentView addSubview:self.picture_img];
        
        //商品名称
        CGRect lblRect = CGRectMake(5, frame.size.width + 5, frame.size.width - 10, 30);
        self.name_label = [UILabel ex_labelWithFrame:lblRect Text:@"商品名称" TextColor:[UIColor whiteColor] TextAlignment:NSTextAlignmentLeft Font:[UIFont systemFontOfSize:16]];
        [self.contentView addSubview:self.name_label];
    }
    return self;
}

@end
