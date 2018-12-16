//
//  HomeViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic, weak) UIButton *m_currentItem;
@property (weak, nonatomic) IBOutlet UIView *search_view;
@property (weak, nonatomic) IBOutlet UITextField *search_txt;
@property (weak, nonatomic) IBOutlet UIButton *search_btn;
@property (weak, nonatomic) IBOutlet UIButton *nonMembers_btn;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *function_btns;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"智美管理系统";
    _search_view.layer.cornerRadius = 3;
    _nonMembers_btn.layer.cornerRadius = 3;
    _search_btn.layer.shadowColor = [UIColor blackColor].CGColor;
    _search_btn.layer.shadowOffset = CGSizeMake(1, 1);
    _search_btn.layer.shadowOpacity = 0.6;
    _search_btn.layer.shadowRadius = 1.0;
    _search_btn.clipsToBounds = NO;
    // 设置阴影
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 5.0f; // 模糊度
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowOffset = CGSizeMake(0.5, 0.5);
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"在此输入手机号／会员卡号／姓名"
                                                                     attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                                                  NSShadowAttributeName: shadow,
                                                                                  NSFontAttributeName:_search_txt.font}];
    
    for (int i; i < _function_btns.count; i++) {
        UIButton *item = _function_btns[i];
        item.layer.borderColor = RGBCOLOR(224, 193, 136).CGColor;
        item.layer.borderWidth = 1;
    }
    _search_txt.attributedPlaceholder = attrString;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/** 搜索会员*/
- (IBAction)searchMembership:(id)sender {
}

/** 散客*/
- (IBAction)nonMembers:(id)sender {
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
