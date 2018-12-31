//
//  YMTextField.m
//  ymlinks
//
//  Created by nick on 2018/12/31.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "YMTextField.h"

@implementation YMTextField

- (void)deleteBackward {
    [super deleteBackward];
    if ([self.ym_delegate respondsToSelector:@selector(ymTextFieldDeleteBackward:)]) {
        [self.ym_delegate ymTextFieldDeleteBackward:self];
    }
}

@end
