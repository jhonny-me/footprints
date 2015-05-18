//
//  GQShareDetailVC.h
//  footPrints
//
//  Created by jhonny.copper on 15/5/17.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GQShareDetailVC :UIViewController
{

    __weak IBOutlet UIImageView *_locationImageView;
    __weak IBOutlet UIView *_photoView;
    __weak IBOutlet UITextView *_remarkTextView;
    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UILabel *_hintLb;
}


@property (strong, nonatomic) UIImage *image;


@end
