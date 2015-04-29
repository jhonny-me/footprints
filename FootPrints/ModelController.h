//
//  ModelController.h
//  FootPrints
//
//  Created by Mac OS X  on 15/4/29.
//  Copyright (c) 2015年 jhonny.copper. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end

