//
//  SearchMberViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/18.
//  Copyright © 2018年 ym. All rights reserved.
//
//  检索会员

#import "SearchMberViewController.h"

@interface SearchMberViewController ()
@property (weak, nonatomic) IBOutlet UIView *create_view;
@property (weak, nonatomic) IBOutlet UIView *content_view;
@property (weak, nonatomic) IBOutlet UIButton *next_btn;

@end

@implementation SearchMberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"档案";
    // Do any additional setup after loading the view.
}
- (IBAction)searchOrCreate:(id)sender {
    UISegmentedControl *seg = sender;
    [UIView animateWithDuration:0.1 animations:^{
        _create_view.hidden = seg.selectedSegmentIndex == 0;
        CGRect rect = _content_view.frame;
        rect.size.height = seg.selectedSegmentIndex == 0 ? 180 : 405;
        [_content_view setFrame:rect];
    }];
}

- (IBAction)nextStep:(id)sender {
    [self performSegueWithIdentifier:@"intoMemberDetail" sender:nil];
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
