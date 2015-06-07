//
//  GQUtils.m
//  footPrints
//
//  Created by jhonny.copper on 15/5/18.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import "GQUtils.h"
#import "AppDelegate.h"

@implementation GQUtils

#pragma mark - View Position, Size

+ (void)changeViewHeight: (UIView*)view height: (CGFloat)height
{
    CGRect frame = view.frame;
    frame.size.height = height;
    view.frame = frame;
}

+ (void)changeViewWidth: (UIView*)view width: (CGFloat)width
{
    CGRect frame = view.frame;
    frame.size.width = width;
    view.frame = frame;
}

+ (void)moveViewToX: (UIView*)view x: (CGFloat)x
{
    CGRect frame = view.frame;
    frame.origin.x = x;
    view.frame = frame;
}

+ (void)moveViewToY: (UIView*)view y: (CGFloat)y
{
    CGRect frame = view.frame;
    frame.origin.y = y;
    view.frame = frame;
}

#pragma mark - Alert View

+ (void) showAlert:(NSString*) message{

   UIAlertView *view = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [view show];
}

#pragma mark - Share Operation

+ (void) shareToSinaWithMessage:(NSString *)message Image:(UIImage *)image{

    NSString *content = [NSString stringWithString:message];
    if ([content isEqualToString:@""]) {
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        
        content = delegate.defaultMessage;
    }
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK pngImageWithImage:image]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [[SHKActivityIndicator currentIndicator] displayActivity: @"发布中。。"];
    [ShareSDK shareContent:publishContent
                      type:ShareTypeSinaWeibo
               authOptions:nil
              shareOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSPublishContentStateSuccess)
                        {
                            [[SHKActivityIndicator currentIndicator] hide];
                            NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功"));
                            [GQUtils showAlert:@"分享成功"];
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            [[SHKActivityIndicator currentIndicator] hide];                            NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                            [GQUtils showAlert:(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription])];
                        }
                        
                    }];

}

#pragma mark - Load Default Message

+ (void) loadDefaultMessage{

//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"GQDefaultMessageList" ofType:@"plist"];
      NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"GQDefaultMessageList.plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    NSLog(@"%@", data);//直接打印数据。
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    delegate.defaultMessage = [data objectForKey:@"defaultMessage"];
}

+ (void) saveDefaultMessage:(NSString*)message{

    //添加一项内容
    
//    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithObject:message forKey:@"defaultMessage"];
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"GQDefaultMessageList.plist"];
//     NSString *path = [[NSBundle mainBundle] pathForResource:@"GQDefaultMessageList" ofType:@"plist"];
    NSMutableDictionary *applist = [[[NSMutableDictionary alloc]initWithContentsOfFile:path]mutableCopy];
    [applist setValue:message forKey:@"defaultMessage"];
    //写入文件
    [applist writeToFile:path atomically:YES];
    
//    //获取应用程序沙盒的Documents目录
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *plistPath1 = [paths objectAtIndex:0];
//    
//    //得到完整的文件名
//    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"GQDefaultMessageList.plist"];
//    NSLog(@"%@",filename);
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"GQDefaultMessageList" ofType:@"plist"];
//    NSMutableDictionary *usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    //输入写入
//    [data writeToFile:plistPath atomically:YES];
}

#pragma mark - Get Time

+ (NSString *) getCurrentTime{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *destString = [NSString stringWithString:[formatter stringFromDate:[NSDate date]]];
    return destString;
}


@end
