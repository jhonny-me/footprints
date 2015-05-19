//
//  GQShareDetailVC.m
//  footPrints
//
//  Created by jhonny.copper on 15/5/17.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import "GQShareDetailVC.h"
#import "GQUtils.h"
#import "ShareSDK/ShareSDK.h"

@interface GQShareDetailVC ()<UITextViewDelegate>

@end

@implementation GQShareDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self loadGQShareDetailVCUI];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(returnKey_Pressed:)];
    [self.view addGestureRecognizer:tapGesture];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load Operations

- (void) loadGQShareDetailVCData{}

- (void) loadGQShareDetailVCUI{

    _scrollView.contentSize = CGSizeMake(320, 660);
    
    _locationImageView.image = self.image;
    
    _remarkTextView.delegate = self;
}


#pragma mark - TextView Delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    _hintLb.hidden = YES;

    _scrollView.contentOffset = CGPointMake(0, KEYBOARD_HEIGHT);
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{

    if ([_remarkTextView.text isEqualToString:@""]) {
        _hintLb.hidden = NO;
    }
    [_remarkTextView resignFirstResponder];
    _scrollView.contentOffset = CGPointMake(0, 90);
}

#pragma mark - Button Events

- (IBAction)changeLocationBtn_Pressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)returnKey_Pressed:(id)sender{

    [_remarkTextView resignFirstResponder];
}

- (IBAction)shareBtn_Pressed:(id)sender {
    
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"backgroud" ofType:@"png"];
    
    NSString *content = [NSString stringWithString:_remarkTextView.text];
    if ([content isEqualToString:@""]) {
        content = @"我在这里，大家快来快来玩";
    }
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK pngImageWithImage:self.image]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK shareContent:publishContent
                      type:ShareTypeSinaWeibo
               authOptions:nil
              shareOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功"));
                            [GQUtils showAlert:@"分享成功"];
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                            [GQUtils showAlert:(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription])];
                        }
                        
                    }];
    
//    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeSinaWeibo, nil];
//    [ShareSDK oneKeyShareContent:publishContent//内容对象
//                       shareList:shareList//平台类型列表
//                     authOptions:nil//授权选项
//                   statusBarTips:YES
//                          result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {//返回事件
//                              
//                              if (state == SSPublishContentStateSuccess)
//                              {
//                                  NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
//                                  [GQUtils showAlert:@"分享成功"];
//                              }
//                              else if (state == SSPublishContentStateFail)
//                              {
//                                  NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
//                                  [GQUtils showAlert:(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription])];
//                              }
//                          }];
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
