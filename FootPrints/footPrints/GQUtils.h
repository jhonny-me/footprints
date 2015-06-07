//
//  GQUtils.h
//  footPrints
//
//  Created by jhonny.copper on 15/5/18.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GQMacros.h"


@interface GQUtils : NSObject

+ (void)changeViewHeight: (UIView*)view height: (CGFloat)height;
+ (void)changeViewWidth: (UIView*)view width: (CGFloat)width;
+ (void)moveViewToX: (UIView*)view x: (CGFloat)x;
+ (void)moveViewToY: (UIView*)view y: (CGFloat)y;

+ (void) shareToSinaWithMessage:(NSString *)message Image:(UIImage *)image;
+ (void) showAlert:(NSString*) message;
+ (NSString *) getCurrentTime;

@end
