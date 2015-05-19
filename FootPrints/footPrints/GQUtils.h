//
//  GQUtils.h
//  footPrints
//
//  Created by jhonny.copper on 15/5/18.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SHKActivityIndicator.h"

// Keyboard
#define KEYBOARD_HEIGHT 340


#define WAITING_START(waitingMessage)  \
self.view.userInteractionEnabled=NO; \
[[SHKActivityIndicator currentIndicator] displayActivity: waitingMessage];

#define WAITING_END() \
self.view.userInteractionEnabled=YES; \
[[SHKActivityIndicator currentIndicator] hide];


@interface GQUtils : NSObject

+ (void)changeViewHeight: (UIView*)view height: (CGFloat)height;
+ (void)changeViewWidth: (UIView*)view width: (CGFloat)width;
+ (void)moveViewToX: (UIView*)view x: (CGFloat)x;
+ (void)moveViewToY: (UIView*)view y: (CGFloat)y;

+ (void) showAlert:(NSString*) message;

@end
