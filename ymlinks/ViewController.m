//
//  ViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/11.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *bg_view;
@property (weak, nonatomic) IBOutlet UIImageView *bg_image;
@property (weak, nonatomic) IBOutlet UIImageView *log_image;
@property (weak, nonatomic) IBOutlet UIButton *login_btn;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor colorWithRed:25/255 green:58/255.0 blue:109/255.0 alpha:1.0].CGColor,
                       (id)[UIColor colorWithRed:93/255 green:120/255.0 blue:180/255.0 alpha:1.0].CGColor,
                       (id)[UIColor colorWithRed:5/255 green:12/255.0 blue:49/255.0 alpha:1.0].CGColor, nil];
    [self.bg_view.layer addSublayer:gradient];
    
    self.log_image.layer.cornerRadius = self.log_image.frame.size.width/2.0;
    _login_btn.layer.cornerRadius = 5;
    _login_btn.layer.shadowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6].CGColor;
    _login_btn.layer.shadowOffset = CGSizeMake(10, 8);
    // Do any additional setup after loading the view, typically from a nib.
}

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
    if (textField.tag == 1) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
