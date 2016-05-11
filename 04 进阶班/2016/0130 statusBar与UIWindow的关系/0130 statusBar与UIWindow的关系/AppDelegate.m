//
//  AppDelegate.m
//  0130 statusBar与UIWindow的关系
//
//  Created by 张思琦 on 16/1/30.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "AppDelegate.h"
#import "TopWindowViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UIWindow *topWindow;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.topWindow = [[UIWindow alloc] init];
    //statusBarFrame属性
    self.topWindow.frame = application.statusBarFrame;
    //window的level等级
    self.topWindow.windowLevel = UIWindowLevelAlert;
    //window的背景色
    self.topWindow.backgroundColor = [UIColor clearColor];
    //设置window的Hidden属性
    self.topWindow.hidden = NO;
    //设置topWindow的RootViewController
    self.topWindow.rootViewController = [[TopWindowViewController alloc] init];
    
    // Override point for customization after application launch.
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
