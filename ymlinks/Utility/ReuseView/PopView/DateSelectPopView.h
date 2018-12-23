//
//  DateSelectPopView.h
//  ymlinks
//
//  Created by nick on 2018/12/23.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "BasicPopView.h"

typedef void(^DateSelectFinish)(NSDate *date);
@interface DateSelectPopView : BasicPopView

@property (nonatomic, strong) NSDate *m_date;

- (instancetype)initWithFinishSelect:(DateSelectFinish)finishBlock;

@end
