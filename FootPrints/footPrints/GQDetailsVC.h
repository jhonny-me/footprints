//
//  GQDetailsVC.h
//  footPrints
//
//  Created by jhonny.copper on 15/5/29.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Infomation.h"

@interface GQDetailsVC : UIViewController
{

    __weak IBOutlet UILabel *_remarkLb;
    __weak IBOutlet UILabel *_dateLb;
    __weak IBOutlet UIScrollView *_scrollView;
}
@property (weak, nonatomic) IBOutlet UIView *detailsView;

@property (weak, nonatomic) Infomation *info;

-(void)dismissWelcomeAlertViewBlock:(void (^)())block;

- (void) setContentWithInfo:(Infomation*) info;

@end
