//
//  HomeViewController.m
//  ymlinks
//
//  Created by nick on 2018/12/16.
//  Copyright © 2018年 ym. All rights reserved.
//

#import "HomeViewController.h"
#import "YMTextField.h"
#import "HomeViewCell.h"
#import "BillingViewController.h"

@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UITextFieldDelegate>

@property (nonatomic, weak) UIButton *m_currentItem;
@property (weak, nonatomic) IBOutlet UIView *search_bg;
@property (weak, nonatomic) IBOutlet UIView *search_view;
@property (weak, nonatomic) IBOutlet UITextField *search_txt;
@property (weak, nonatomic) IBOutlet UIButton *search_btn;
@property (weak, nonatomic) IBOutlet UIButton *nonMembers_btn;
@property (weak, nonatomic) IBOutlet UIView *content_view;
@property (weak, nonatomic) IBOutlet UICollectionView *member_collection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *function_btns;
@property (strong, nonatomic) NSArray *memberList;
@property (assign, nonatomic) float search_y;
@property (assign, nonatomic) BOOL searching;
@property (strong, nonnull) NSDictionary *chosenMemberCard;

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
    
    for (int i = 0; i < _function_btns.count; i++) {
        UIButton *item = _function_btns[i];
        item.layer.borderColor = RGBCOLOR(224, 193, 136).CGColor;
        item.layer.borderWidth = 1;
    }
    _search_txt.attributedPlaceholder = attrString;
    _memberList = [[NSArray alloc] init];
    _content_view.layer.cornerRadius = 5;
    _content_view.layer.masksToBounds = true;
    // Do any additional setup after loading the view.
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //搜索
    [self searchMembership:NULL];
    return true;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _search_txt) {
        CGRect rect = _search_bg.frame;
        if (_search_y == 0) {
            _search_y = rect.origin.y;
        }
        if (rect.origin.y != 74) {
            [UIView animateWithDuration:0.2 animations:^{
                [_search_bg setFrame:CGRectMake(rect.origin.x, 74, rect.size.width, rect.size.height)];
            } completion:^(BOOL finished) {
                _content_view.hidden = false;
                [UIView animateWithDuration:0.2 animations:^{
                    CGRect rect = _search_view.frame;
                    [_search_view setFrame:CGRectMake(rect.origin.x, rect.origin.y, _search_bg.frame.size.width, rect.size.height)];
                    _nonMembers_btn.alpha = 0;
                }];
            }];
        }
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _search_txt) {
        CGRect rect = _search_bg.frame;
        if (_search_txt.text.length == 0 && _memberList.count == 0 && !_searching) {
            _content_view.hidden = true;
            [UIView animateWithDuration:0.2 animations:^{
                [_search_bg setFrame:CGRectMake(rect.origin.x, _search_y, rect.size.width, rect.size.height)];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    CGRect rect = _search_view.frame;
                    [_search_view setFrame:CGRectMake(rect.origin.x, rect.origin.y, _search_bg.frame.size.width - 140, rect.size.height)];
                    _nonMembers_btn.alpha = 1;
                }];
            }];
        }
        _searching = false;
    }
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = @[RGBCOLOR(133,183,69), RGBCOLOR(255,115,115), RGBCOLOR(229,187,109)][indexPath.row%3];
    NSDictionary *data = [_memberList objectAtIndex:indexPath.row];
    cell.cardType_lab.text = [NSString stringWithFormat:@"%@", ([data objectForKey:@"type"] ? [[data objectForKey:@"type"] objectForKey:@"name"] : @"无类别")];
    NSString *realName = [data objectForKey:@"holderName"];
    realName = realName ? realName : [data objectForKey:@"realname"];
    realName = realName ? realName : @"匿名";
    cell.info_label.text = [NSString stringWithFormat:@"%@ %@", realName, [data objectForKey:@"mobile"]];
    cell.cardNo_label.text = [NSString stringWithFormat:@"No.%@", [data objectForKey:@"cardNo"]];
    cell.layer.cornerRadius = 3;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _memberList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    double width = (collectionView.bounds.size.width - 50)/4;
    return CGSizeMake(width, 130);
}

#pragma UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_search_txt.resignFirstResponder) {
        [_search_txt resignFirstResponder];
    }
    _chosenMemberCard = [_memberList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"intoBilling" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //////这里toVc是拉的那条线的标识符
    if ([segue.identifier isEqualToString:@"intoBilling"]) {
        BillingViewController *theVc = segue.destinationViewController;
        theVc.memberCard = _chosenMemberCard;////传的参数
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/** 搜索会员*/
- (IBAction)searchMembership:(id)sender {
    [self textFieldDidBeginEditing:_search_txt];
    NSDictionary *parameDic = @{@"keyword": _search_txt.text,
                                @"status": @"1"};
    
    [[NetworkManage shareNetworkManage] getRequest:parameDic Tag:NetworkTag_SearchMemberCardByKeyword Delegate:self];
    _searching = true;
    [_search_txt resignFirstResponder];
}

/** 散客*/
- (IBAction)nonMembers:(id)sender {
    _chosenMemberCard = NULL;
    [self performSegueWithIdentifier:@"intoBilling" sender:nil];
}

/** 网络请求成功 */
- (void)net_requestSuccess:(id)result Tag:(NetworkInterfaceTag)tag {
    //    [super net_requestSuccess:result Tag:tag];
    if (tag == NetworkTag_SearchMemberCardByKeyword) {//返回 登录Token 保存
        _memberList = result;
        [_member_collection reloadData];
    }
    NSLog(@"%@", result);
    _searching = false;
}

- (void)net_requestFail:(id)result Tag:(NetworkInterfaceTag)tag {
    [self showError:[NSString stringWithFormat:@"%@", result]];
    _searching = false;
}
- (IBAction)closeSearchMember:(id)sender {
    _memberList = @[];
    [_member_collection reloadData];
    _search_txt.text = @"";
    if (_search_txt.resignFirstResponder) {
        [_search_txt resignFirstResponder];
    }
    else {
        [self textFieldDidEndEditing:_search_txt];
    }
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
