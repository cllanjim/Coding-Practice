//
//  AppDelegate.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/5.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "AppDelegate.h"
#import "SQTabBarController.h"
#import "SQTopWindow.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@property (nonatomic, strong) SQTopWindow *topWindow;

@property (nonatomic, assign) NSInteger lastSelectedIndex;

@end

@implementation AppDelegate
#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

    if (tabBarController.selectedIndex == self.lastSelectedIndex) {
        //如果点击的tabBar与原先的tabBar相同,就发出重复点击的通知
        
        [[NSNotificationCenter defaultCenter] postNotificationName:SQTabBarButtonDidRepeatClickNotification object:nil];
    }
    //更新lastSelectedIndex的值
    self.lastSelectedIndex = tabBarController.selectedIndex;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //1.创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.设置window的rootViewController并创建UITabViewController
    SQTabBarController *tabBarController = [[SQTabBarController alloc] init];
    tabBarController.delegate = self;
    self.window.rootViewController = tabBarController;
    
    //3.令window可见
    [self.window makeKeyAndVisible];
    
    //self.topWindow = [[SQTopWindow alloc] init];
    [SQTopWindow show];

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
