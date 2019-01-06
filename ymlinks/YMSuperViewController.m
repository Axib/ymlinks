//
//  YMSuperViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "YMSuperViewController.h"

typedef void (^ myBlock)(NSString *);

@interface YMSuperViewController ()<UITextViewDelegate>

@property (strong, nonatomic) UITextView * tempText;
@property (strong, nonatomic) UITextView * inputText;
@property (strong, nonatomic) UILabel *placeholderLab;
@property (strong, nonatomic) UIView *inputView;
@property (nonatomic, strong) myBlock tempBlock;
@end

@implementation YMSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    if (self != self.navigationController.viewControllers[0]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_return_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popAction:)];
    }
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_return_back"] style:UIBarButtonItemStyleBordered target:self action:@selector(popAction:)];
    // Do any additional setup after loading the view.
}

#pragma mark - NetworkManageDelegate
/** 将要发送网络请求 */
- (void)net_requestBeginTag:(NetworkInterfaceTag)tag {
    
}

/** 网络请求成功 */
- (void)net_requestSuccess:(id)result Tag:(NetworkInterfaceTag)tag {
    
}

- (void)popAction:(UIBarButtonItem *)barButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)beginFloatInput:(NSString *)text placeholder:(NSString *)placeholder result:(void (^)(NSString *))inputBlock {
    if (!_tempText) {
        _tempText =[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _tempText.hidden = true;
        [self.view addSubview:_tempText];
        
        _inputView = [[UIView alloc] initWithFrame:self.view.bounds];
        UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 100)];
        tempView.backgroundColor = [UIColor whiteColor];
        _inputText = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, tempView.frame.size.width - 20, tempView.frame.size.height - 20)];
        _inputText.backgroundColor = [UIColor clearColor];
        _inputText.delegate = self;
        _inputText.returnKeyType = UIReturnKeyDone;
        _inputText.font = [UIFont systemFontOfSize:16];
        _inputText.layer.borderColor = RGBCOLOR(238, 238, 238).CGColor;
        _inputText.layer.borderWidth = 1;
        _inputText.layer.cornerRadius = 5;
        
        _placeholderLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 18, tempView.frame.size.width - 24, 20)];
        _placeholderLab.userInteractionEnabled = NO;
        _placeholderLab.font = [UIFont systemFontOfSize:16];
        _placeholderLab.textColor = RGBCOLOR(189, 189, 189);
        [tempView addSubview:_placeholderLab];
        [tempView addSubview:_inputText];
        [_inputView addSubview:tempView];
        [_tempText setInputAccessoryView:_inputView];//键盘上加这个视图
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInput)];
        [_inputView addGestureRecognizer:tap];
    }
    _placeholderLab.text = placeholder;
    _placeholderLab.hidden = YES;
    if (text == NULL || [[NSString stringWithFormat:@"%@", text] length] == 0) {
        _placeholderLab.hidden = NO;
        text = @"";
    }
    _inputText.text = [NSString stringWithFormat:@"%@", text];
    [_tempText becomeFirstResponder];
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_inputText becomeFirstResponder];
    });
    _tempBlock = inputBlock;
}

- (void)tapInput {
    _inputText.text = @"";
    [_inputText resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (textView == _inputText) {
        [UIView animateWithDuration:0.1 animations:^{
            _inputView.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
        }];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView == _inputText) {
        UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
        UIView * firstResponder = [keyWindow performSelector:@selector(firstResponder)];
        [firstResponder resignFirstResponder];
        [UIView animateWithDuration:0.1 animations:^{
            _inputView.backgroundColor = RGBACOLOR(0, 0, 0, 0);
        }];
        _tempBlock(_inputText.text);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView == _inputText) {
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            return NO;
        }
        _placeholderLab.hidden = YES;
        if ([text isEqual:@""] && textView.text.length <= 1) {
            _placeholderLab.hidden = NO;
        }
    }
    return YES;
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
