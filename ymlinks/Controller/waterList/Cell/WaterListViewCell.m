//
//  WaterListViewCell.m
//  ymlinks
//
//  Created by nick on 2018/12/23.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "WaterListViewCell.h"

@implementation WaterListViewCell

- (instancetype)init {
    if (self = [super init]) {
        [self.main_table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}


#pragma UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"waterListViewCell_Cell"];
    if (cell == NULL) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"waterListViewCell_Cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = RGBCOLOR(188, 140, 53);
        cell.backgroundColor = [UIColor clearColor];
    }
    NSDictionary *data = self.infoList[indexPath.row];
    cell.textLabel.text = [data objectForKey:@"projectName"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoList ? self.infoList.count : 0;
}
#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 25;
}

@end
