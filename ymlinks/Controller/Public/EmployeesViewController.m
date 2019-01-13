//
//  EmployeesViewController.m
//  ymlinks
//
//  Created by nick on 2019/1/6.
//  Copyright © 2019年 ym. All rights reserved.
//

#import "EmployeesViewController.h"
#import "EmployeesCell.h"

@interface EmployeesViewController ()<UITableViewDelegate, UITableViewDataSource, EmployeesCellDelegate>

@property (weak, nonatomic) IBOutlet UILabel *title_label;
@property (weak, nonatomic) IBOutlet UITableView *main_table;
@property (weak, nonatomic) IBOutlet UIButton *close_btn;
@property (weak, nonatomic) IBOutlet UIButton *cancel_btn;

@property (strong, nonatomic) NSMutableArray *empList;
@property (strong, nonatomic) NSMutableArray *serList;

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
    
    _serList = [[NSMutableArray alloc] init];
}



#pragma UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EmployeesCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([EmployeesCell class]) forIndexPath:indexPath];
    cell.tag = indexPath.row;
    cell.delegate = self;
    NSDictionary *data = [_empList objectAtIndex:indexPath.row];
    int ser = -1;
    int type = 0;
    for (int i = 0; i < [_serList count]; i++) {
        NSDictionary *item = [_serList objectAtIndex:i];
        if ([[item objectForKey:@"empNo"] isEqual:[data objectForKey:@"empNo"]]) {
            ser = i;
            type = [item objectForKey:@"type"] ? [[item objectForKey:@"type"] intValue] : 0;
            break;
        }
    }
    [cell setInfo:data ser:ser type:type];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:[_empList objectAtIndex:indexPath.row]];
    BOOL finding = NO;
    for (NSDictionary *item in _serList) {
        if ([[item objectForKey:@"empNo"] isEqual:[data objectForKey:@"empNo"]]) {
            [_serList removeObject:item];
            finding = YES;
            break;
        }
    }
    if (!finding) {
        if ([_serList count] == 3) {
            [self showError:@"服务人员不能超过3个！"];
            return;
        }
        [_serList addObject:data];
        [_empList replaceObjectAtIndex:indexPath.row withObject:data];
    }
    [tableView reloadData];
}

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:^{
        if (_delegate) {
            [_delegate chooseEmployees:_serList];
        }
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
        _empList = [[NSMutableArray alloc] init];
        if (result) {
            [_empList addObjectsFromArray:result];
        }
        [_main_table reloadData];
    }
    NSLog(@"%@", result);
}

- (void)net_requestFail:(id)result Tag:(NetworkInterfaceTag)tag {
    [self showError:[NSString stringWithFormat:@"%@", result]];
}

#pragma EmployeesCellDelegate
- (void)employeesCell:(NSInteger)row type:(NSInteger)type {
    NSDictionary *data = [_empList objectAtIndex:row];
    for (int i = 0; i < [_serList count]; i++) {
        NSMutableDictionary *item = [_serList objectAtIndex:i];
        if ([[item objectForKey:@"empNo"] isEqual:[data objectForKey:@"empNo"]]) {
            [item setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
            [_serList replaceObjectAtIndex:i withObject:item];
            break;
        }
    }
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
