//
//  EmployeesViewController.m
//  ymlinks
//
//  Created by nick on 2019/1/6.
//  Copyright © 2019年 ym. All rights reserved.
//

#import "EmployeesViewController.h"
#import "EmployeesCell.h"

@interface EmployeesViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UITableView *main_table;
@property (weak, nonatomic) IBOutlet UIButton *close_btn;
@property (weak, nonatomic) IBOutlet UIButton *cancel_btn;

@property (strong, nonatomic) NSArray *empList;

@end

@implementation EmployeesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _close_btn.layer.cornerRadius = _cancel_btn.layer.cornerRadius = 3;
    
    //获取服务员工
    NSDictionary *parameDic = @{@"type": @"1",
                  @"status": @"1",
                  @"chainId": [m_loginInfo objectForKey:@"chainId"],
                  @"compId": [m_loginInfo objectForKey:@"compId"]};
    [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_GetServiceEmp Delegate:self];
}



#pragma UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EmployeesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EmployeesCell class]) forIndexPath:indexPath];
    [cell setInfo:[_empList objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_empList count];
}
#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:^{
//        if (_delegate && !sender) {
//            [_delegate waterRefresh];
//        }
    }];
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:^{
    }];
}

/** 网络请求成功 */
- (void)net_requestSuccess:(id)result Tag:(NetworkInterfaceTag)tag {
    [super net_requestSuccess:result Tag:tag];
    if (tag == NetworkTag_GetServiceEmp) {
        //获取服务人数
        _empList = result;
        [_main_table reloadData];
    }
    NSLog(@"%@", result);
}

- (void)net_requestFail:(id)result Tag:(NetworkInterfaceTag)tag {
    [self showError:[NSString stringWithFormat:@"%@", result]];
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
