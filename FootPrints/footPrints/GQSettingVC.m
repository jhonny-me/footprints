//
//  GQSettingVC.m
//  footPrints
//
//  Created by jhonny.copper on 15/6/7.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import "GQSettingVC.h"
#import "AppDelegate.h"
#import "GQUtils.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GQSettingVC ()<UITextFieldDelegate>
{
    NSString *_nickName;
    UIImage *_profileImage;
}

@end

@implementation GQSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _nickName = [[NSString alloc]init];
    _profileImage = [[UIImage alloc]init];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadGQSettingVCData];
    [self loadGQSettingVCUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadGQSettingVCData{

    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo //平台类型
                      authOptions:nil //授权选项
                           result:^(BOOL result, id userInfo,  id error) { //返回回调
                               if (result)
                               {
                                   NSLog(@"uid = %@",[userInfo uid]);
                                   NSLog(@"name = %@",[userInfo nickname]);
                                   NSLog(@"icon = %@",[userInfo profileImage]);
                                   
                                    [_headerImageView sd_setImageWithURL:(NSURL*)[userInfo profileImage] placeholderImage:[UIImage imageNamed:@"user"]];
                                   
                                   _nickNameLb.text = [userInfo nickname];
                               }
                               else
                               {
                                   NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                               }
                               
                           }];
}

- (void) loadGQSettingVCUI{
    
    _headerImageView.layer.cornerRadius = 30.0f;
    _headerImageView.layer.masksToBounds = YES;

    _nickNameLb.center = _headerImageView.center;
    _nickNameLb.frame = CGRectMake(_nickNameLb.frame.origin.x, _nickNameLb.frame.origin.y + 50, _nickNameLb.frame.size.width, _nickNameLb.frame.size.height);
    
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    _defaultRemarkTF.placeholder = delegate.defaultMessage;
    
    _defaultRemarkTF.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (![_defaultRemarkTF.text isEqualToString:@""]) {
        
        [GQUtils saveDefaultMessage:_defaultRemarkTF.text];
        [GQUtils showAlert:@"修改成功"];
        _defaultRemarkTF.placeholder = _defaultRemarkTF.text;
        _defaultRemarkTF.text = @"";
    }
    [_defaultRemarkTF resignFirstResponder];
    return YES;
}


#pragma mark - Button Events
- (IBAction)logOutBtn_Pressed:(id)sender {
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController.viewControllers objectAtIndex:0];
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
