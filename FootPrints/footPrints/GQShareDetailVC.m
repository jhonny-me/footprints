//
//  GQShareDetailVC.m
//  footPrints
//
//  Created by jhonny.copper on 15/5/17.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import "GQShareDetailVC.h"
#import "GQUtils.h"

#import "ELCImagePickerController.h"
#import "CoreData+MagicalRecord.h"
#import "Infomation.h"

@interface GQShareDetailVC ()<UITextViewDelegate,ELCImagePickerControllerDelegate,ELCAssetSelectionDelegate>
{

    NSMutableArray *_imageArray;
}

@end

@implementation GQShareDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self loadGQShareDetailVCData];
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

- (void) loadGQShareDetailVCData{

    _imageArray = [[NSMutableArray alloc]init];
}

- (void) loadGQShareDetailVCUI{
    
    self.navigationItem.title = @"👣";

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

- (IBAction)addImageBtn_Pressed:(id)sender {
    
    // Create the image picker
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] init];
    elcPicker.maximumImagesCount = 3; //Set the maximum number of images to select, defaults to 4
//    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
//    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
//    elcPicker.onOrder = YES; //For multiple image selection, display and return selected order of images
    elcPicker.imagePickerDelegate = self;
    
    //Present modally
    [self presentViewController:elcPicker animated:YES completion:nil];
}

- (IBAction)shareBtn_Pressed:(id)sender {
    
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"backgroud" ofType:@"png"];
    
    [_remarkTextView resignFirstResponder];
    
    NSString *content = [NSString stringWithString:_remarkTextView.text];
    if ([content isEqualToString:@""]) {
        content = DEFAULT_MESSAGE;
    }
    
    //存储数据库
    [self addToDataBaseWithRemark:content];
    
    [GQUtils shareToSinaWithMessage:content Image:self.image];
    
//    //构造分享内容
//    id<ISSContent> publishContent = [ShareSDK content:content
//                                       defaultContent:@"测试一下"
//                                                image:[ShareSDK pngImageWithImage:self.image]
//                                                title:@"ShareSDK"
//                                                  url:@"http://www.mob.com"
//                                          description:@"这是一条测试信息"
//                                            mediaType:SSPublishContentMediaTypeNews];
//    
//    WAITING_START(@"分享中。。。")
//    [ShareSDK shareContent:publishContent
//                      type:ShareTypeSinaWeibo
//               authOptions:nil
//              shareOptions:nil
//             statusBarTips:YES
//                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                        if (state == SSPublishContentStateSuccess)
//                        {
//                            WAITING_END()
//                            NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功"));
//                            [GQUtils showAlert:@"分享成功"];
//                        }
//                        else if (state == SSPublishContentStateFail)
//                        {
//                            WAITING_END()
//                            NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
//                            [GQUtils showAlert:(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription])];
//                        }
//                        
//                    }];
    
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

#pragma mark - Private Methods

- (void) addToDataBaseWithRemark:(NSString *)remark{

    Infomation *info = [Infomation MR_createEntity];
    info.remark = remark;

    info.date   = [GQUtils getCurrentTime];
    
    // set photoArray
    NSMutableArray *photoArray = [NSMutableArray arrayWithArray:_imageArray];

    [photoArray insertObject:self.image atIndex:0];
    info.photoArray = [photoArray mutableCopy];
    // save changes
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

#pragma mark - Image Selection

- (void)selectedAssets:(NSArray *)assets{

    NSLog(@"%@",assets);
}

- (BOOL)shouldSelectAsset:(ELCAsset *)asset previousCount:(NSUInteger)previousCount{

    return YES;
}

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info{
    
    // 给image重新赋值前先清空
    for (int i =101; i< 104; i++) {
        UIImageView *view = (UIImageView *)[self.view viewWithTag:i];
        view.image = nil;
    }
    
    [_imageArray removeAllObjects];
    
    // 赋值
    for (int i =101; i<info.count + 101; i++) {
        UIImageView *view = (UIImageView *)[self.view viewWithTag:i];
        view.image = [info[i-101] objectForKey:@"UIImagePickerControllerOriginalImage"];
        [_imageArray addObject:view.image];
    }

    [picker dismissViewControllerAnimated:YES completion:nil];
}

/**
 * Called when image selection was cancelled, by tapping the 'Cancel' BarButtonItem.
 */
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker{

    [picker dismissViewControllerAnimated:YES completion:nil];
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
