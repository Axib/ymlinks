//
//  LoginViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *bg_view;
@property (weak, nonatomic) IBOutlet UIImageView *bg_image;
@property (weak, nonatomic) IBOutlet UIImageView *log_image;
@property (weak, nonatomic) IBOutlet UIView *login_view;
@property (weak, nonatomic) IBOutlet UIButton *login_btn;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    NSLog(@"12311111");
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)RGBCOLOR(25, 58, 109).CGColor,
                       (id)RGBCOLOR(93, 120, 180).CGColor,
                       (id)RGBCOLOR(5, 12, 49).CGColor, nil];
    [self.bg_view.layer addSublayer:gradient];
    
    self.log_image.layer.cornerRadius = self.log_image.frame.size.width/2.0;
    _login_btn.layer.cornerRadius = 5;
    _login_btn.layer.shadowColor = RGBACOLOR(255, 255, 255, 0.6).CGColor;
    _login_btn.layer.shadowOffset = CGSizeMake(10, 8);

    
    // Do any additional setup after loading the view.
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 1) {
        [_password becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return true;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = _login_view.frame;
        if (textField.tag == 1) {
            [_login_view setFrame:CGRectMake(rect.origin.x, 120, rect.size.width, rect.size.height)];
        }
        else {
            [_login_view setFrame:CGRectMake(rect.origin.x, 100, rect.size.width, rect.size.height)];
        }
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = _login_view.frame;
        [_login_view setFrame:CGRectMake(rect.origin.x, 184, rect.size.width, rect.size.height)];
    }];
}
#pragma mark - 封装弹出对话框方法
// 提示错误信息
- (void)showError:(NSString *)errorMsg {
    // 1.弹框提醒
    // 初始化对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}


- (IBAction)sendLoginRequest:(id)sender {
    if (_userName.text.length <= 0 || _password.text.length <= 0) {
        [self showError:@"请检查用户名和密码是否为空！"];
        return;
    }
    
    NSDictionary *parameDic = @{@"username": self.userName.text,
                                @"password": self.password.text,
                                @"type": @"1",
                                @"userAgent": @"",
                                @"clientIp": @"127.0.0.1"};
    
    [[NetworkManage shareNetworkManage] postJsonRequest:parameDic Tag:NetworkTag_UserLogin Delegate:self];
}

/** 网络请求成功 */
- (void)net_requestSuccess:(id)result Tag:(NetworkInterfaceTag)tag {
    //    [super net_requestSuccess:result Tag:tag];
    if (tag == NetworkTag_UserLogin) {//返回 登录Token 保存
        m_loginInfo = result;
        //        [self saveLoginInfo];
        [self gotoHomePage];
    }
}

/** 前往首页 */
- (void)gotoHomePage {
    [self performSegueWithIdentifier:@"GoHomePage" sender:nil];

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
