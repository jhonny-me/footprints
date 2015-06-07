//
//  GQLoginVC.m
//  footPrints
//
//  Created by jhonny.copper on 15/5/20.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import "GQLoginVC.h"
#import "ShareSDK/ShareSDK.h"
#import "PFQuery.h"
#import "GQUtils.h"

@interface GQLoginVC ()

@end

@implementation GQLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadGQLoginVCUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadGQLoginVCUI{

    self.navigationController.navigationBarHidden = YES;
    self.loginBtn.layer.cornerRadius = 13.0f;
    self.loginBtn.layer.borderWidth = 1;
    self.loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
}

#pragma mark - Login Events

- (IBAction)loginBtn_Pressed:(id)sender {
    
    _loginBtn.enabled = NO;
//    WAITING_START(@"登陆中。。")
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo
                      authOptions:nil
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error)
     {
//         WAITING_END()
         
         if (result)
         {
             PFQuery *query = [PFQuery queryWithClassName:@"UserInfo"];
             [query whereKey:@"uid" equalTo:[userInfo uid]];
             [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
              {
                  _loginBtn.enabled = YES;
                  
                  if ([objects count] == 0)
                  {
                      PFObject *newUser = [PFObject objectWithClassName:@"UserInfo"];
                      [newUser setObject:[userInfo uid] forKey:@"uid"];
                      [newUser setObject:[userInfo nickname] forKey:@"name"];
                      [newUser setObject:[userInfo profileImage] forKey:@"icon"];
                      [newUser saveInBackground];
                      UIAlertView *alertView = [[UIAlertView alloc]
                                                initWithTitle:@"Hello"
                                                message:@"欢迎注册"
                                                delegate:nil
                                                cancelButtonTitle:@"知道了"
                                                otherButtonTitles: nil];
                      [alertView show];
                  }
                  else
                  {
                      UIAlertView *alertView = [[UIAlertView alloc]                                 initWithTitle:@"Hello"
                                                                                                          message:@"欢迎回来"
                                                                                                         delegate:nil
                                                                                                cancelButtonTitle:@"知道了"
                                                                                                otherButtonTitles:nil];
                      [alertView show];
                  }
              }];
//            WAITING_END()
            [self performSegueWithIdentifier:@"SegueToMainVC" sender:self];
             
         }
     }];
//    [self performSegueWithIdentifier:@"SegueToMainVC" sender:self];
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
