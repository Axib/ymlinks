//
//  DateSelectPopView.m
//  ymlinks
//
//  Created by nick on 2018/12/23.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "DateSelectPopView.h"

@interface DateSelectPopView ()

@property (nonatomic, copy) DateSelectFinish m_dateSelectFinish;

@property (nonatomic, strong) UIDatePicker *m_datePicker;

@end

@implementation DateSelectPopView

- (UIDatePicker *)m_datePicker {
    if (_m_datePicker == nil)
        _m_datePicker = [[UIDatePicker alloc] init];
    
    return _m_datePicker;
}

- (void)setM_date:(NSDate *)m_date {
    [self.m_datePicker setDate:m_date animated:false];
}

- (NSDate *)m_date {
    return self.m_datePicker.date;
}

- (instancetype)initWithFinishSelect:(DateSelectFinish)finishBlock {
    if (self = [super init])
        self.m_dateSelectFinish = finishBlock;
    
    return self;
}

- (void)initView {
    
    if ([self.subviews count] != 0) return;
    
    self.m_clearBcColor  = true;
    self.backgroundColor = [UIColor clearColor];
    [self ex_setRadius:5.f Masks:true];
    
    self.frame = CGRectMake(mainScreen_Width/2.f - 175, mainScreen_Height/2.f - 200, 350, 300);
    
    if (ISIOS8) {
        UIVisualEffectView *effView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        
        [self addSubview:effView];
        
        [effView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo (UIEdgeInsetsZero);
        }];
    }
    
    self.m_datePicker.backgroundColor = RGBACOLOR(255, 255, 255, 0.7);
    self.m_datePicker.datePickerMode  = UIDatePickerModeDate;
    
    [self addSubview:self.m_datePicker];
    
    [self.m_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo (0.f);
        make.height.mas_equalTo (245.f);
    }];
    
    UIView *bottomView         = [[UIView alloc] init];
    bottomView.backgroundColor = RGBACOLOR(255, 255, 255, 0.7);
    
    [self addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (self.m_datePicker.mas_bottom);
        make.left.right.bottom.mas_equalTo (0.f);
    }];
    
    [bottomView ex_addLineWithFrame:CGRectMake(0, 0, self.m_width, 1) BackgroundColor:COLOR_ALPHAGRAY_BORDER];
    
    UIButton *saveBtn = [UIButton ex_buttonWithFrame:CGRectNull Title:@"确定" BcImg:nil Radius:0 Target:self Action:@selector(saveBtnClicked)];
    [saveBtn setTitleColor:COLOR_BLACK_TEXT forState:UIControlStateNormal];
    saveBtn.titleLabel.font = M_FONT_BOLD(16);
    
    [bottomView addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo (UIEdgeInsetsZero);
    }];
    
    [bottomView addSubview:saveBtn];
}

#pragma mark - Action
- (void)saveBtnClicked {
    
    if (self.m_dateSelectFinish)
        self.m_dateSelectFinish (self.m_datePicker.date);
    else
        ZNLog(@"没有实现回调Block");
    
    [self close];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
