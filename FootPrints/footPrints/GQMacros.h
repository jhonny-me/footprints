//
//  GQMacros.h
//  footPrints
//
//  Created by jhonny.copper on 15/5/19.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#ifndef footPrints_GQMacros_h
#define footPrints_GQMacros_h

#import "SHKActivityIndicator.h"
#import "ShareSDK/ShareSDK.h"

// Keyboard
#define KEYBOARD_HEIGHT 340

// Color
#define RGBA(r,g,b,a)   [UIColor colorWithRed: (r/255.0f) green: (g/255.0f) blue: (b/255.0f) alpha: a]

//#define DEFAULT_MESSAGE @"我在这里，大家快来快来玩"
//NSString *DEFAULT_MESSAGE = @"我在这里，大家快来快来玩";

#define WAITING_START(waitingMessage)  \
self.view.userInteractionEnabled=NO; \
[[SHKActivityIndicator currentIndicator] displayActivity: waitingMessage];

#define WAITING_END() \
self.view.userInteractionEnabled=YES; \
[[SHKActivityIndicator currentIndicator] hide];


#endif
