//
//  AppDelegate.m
//  footPrints
//
//  Created by jhonny.copper on 15/5/10.
//  Copyright (c) 2015年 jhonny. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreLocation/CLLocationManager.h"
#import "ShareSDK/ShareSDK.h"
#import "WeiboSDK.h"

@interface AppDelegate ()<CLLocationManagerDelegate>
{

    CLLocationManager *_locationManager;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // location Operation
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
    [_locationManager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
    _locationManager.delegate = self;
    
    [_locationManager startUpdatingLocation];

    [ShareSDK registerApp:@"777951ec95b3"];
    
    [ShareSDK connectSinaWeiboWithAppKey:@"1275159907" appSecret:@"5468a0ef6fb237cbf29e78d7dc21103a" redirectUri:@"http://open.weibo.com/apps/1275159907/privilege/oauth"];
    
    [ShareSDK connectSinaWeiboWithAppKey:@"1275159907" appSecret:@"5468a0ef6fb237cbf29e78d7dc21103a" redirectUri:@"http://open.weibo.com/apps/1275159907/privilege/oauth" weiboSDKCls:[WeiboSDK class]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
