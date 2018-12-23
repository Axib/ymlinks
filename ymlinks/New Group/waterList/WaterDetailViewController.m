//
//  WaterDetailViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/23.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "WaterDetailViewController.h"
#import "WaterDetailViewCell.h"

@interface WaterDetailViewController ()<UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UILabel *date_label;
@property (weak, nonatomic) IBOutlet UITableView *main_table;
@property(nonatomic, strong) UITapGestureRecognizer *click;
@property (weak, nonatomic) IBOutlet UIButton *close_btn;
@property (weak, nonatomic) IBOutlet UIButton *cancel_btn;

@end

@implementation WaterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _close_btn.layer.cornerRadius = _cancel_btn.layer.cornerRadius = 3;
    if (self.infoDic) {
        self.title_label.text = [NSString stringWithFormat:@"%@ %@", [self.infoDic objectForKey:@"smallNo"], [self.infoDic objectForKey:@"cardNo"]];
        self.date_label.text = [NSString stringWithFormat:@"%@", [self.infoDic objectForKey:@"createDate"]];
    }
}
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:NULL];
}
- (IBAction)cancelAction:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"作废提示"
                                                        message:@"确定作废改单据吗？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"作废", nil];
    
    [alertView show];
}

#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSLog(@"是");
    }
    NSLog(@"%i", buttonIndex);
}

#pragma UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WaterDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WaterDetailViewCell class]) forIndexPath:indexPath];
    [cell setInfo:([self.infoDic objectForKey:@"projectInfos"][indexPath.row])];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.infoDic && [self.infoDic objectForKey:@"projectInfos"]) ? ((NSArray *)[self.infoDic objectForKey:@"projectInfos"]).count : 0;
}
#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
