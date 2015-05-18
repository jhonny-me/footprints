//
//  GQUtils.m
//  footPrints
//
//  Created by jhonny.copper on 15/5/18.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import "GQUtils.h"

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


@end
