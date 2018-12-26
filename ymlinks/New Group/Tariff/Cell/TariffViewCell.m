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
        //    rect.size.height = 160;
        //商品图
        self.picture_img.layer.masksToBounds = true;
        
        self.layer.cornerRadius = 5;
    }
    return self;
}

@end
