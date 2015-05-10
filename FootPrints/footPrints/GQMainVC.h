//
//  GQMainVC.h
//  footPrints
//
//  Created by jhonny.copper on 15/5/10.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GQMainVC : UITableViewController
{

    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UIPageControl *_pageController;
    
    __weak IBOutlet UIImageView *_fastShareImage;
    __weak IBOutlet UIButton *_fastShareBtn;
    __weak IBOutlet UIButton *_detailShareBtn;
    
    __weak IBOutlet UIImageView *_historyImage;
    __weak IBOutlet UIButton *_historyBtn;
}

@end
