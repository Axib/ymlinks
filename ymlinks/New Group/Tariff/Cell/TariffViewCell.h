//
//  TariffViewCell.h
//  ymlinks
//
//  Created by nick on 2018/12/19.
//  Copyright © 2018年 ym. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TariffViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *picture_img;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *price_label;

@end
