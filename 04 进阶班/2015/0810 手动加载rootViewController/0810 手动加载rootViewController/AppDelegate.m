//
//  AppDelegate.m
//  0810 手动加载rootViewController
//
//  Created by 张思琦 on 15/8/13.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.创建UIWindow对象
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.加载xib文件中的viewController
    
   UIStoryboard *myStoryboard = [UIStoryboard storyboardWithName:@"myRootViewController" bundle:nil];
    
    //当storyboard中有多个viewController时,自动加载带有inital标志的viewController
    UIViewController *myController = [myStoryboard instantiateInitialViewController];
    
    //storyboard中有多个viewController时,自动加载带有特定标示符的viewController
    UIViewController *myController1 = [myStoryboard instantiateViewControllerWithIdentifier:@"ID"];
    
    //3.设定UIWindow的根控制器
    self.window.rootViewController = myController1;
    
    //4.设定主窗口并让其可见
    [self.window makeKeyAndVisible];
    
    
    
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
