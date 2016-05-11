//
//  AppDelegate.m
//  0817 UITableBarController的基本使用
//
//  Created by 张思琦 on 15/8/17.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.创建UIWindow
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    //2.设置UIWindow的根控制器
    //创建UITabBarController
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    //创建UIViewController
    UIViewController *controller00 = [[UIViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    UIViewController *controller01 = [[UIViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    UIViewController *controller02 = [[UIViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    //将controller00添加到tabBarController
    [tabBarController addChildViewController:controller00];
    [tabBarController addChildViewController:controller01];
    [tabBarController addChildViewController:controller02];

    //设置Controller的相关参数
    
    //背景颜色
    controller00.view.backgroundColor = [UIColor lightGrayColor];
    controller01.view.backgroundColor = [UIColor yellowColor];
    controller02.view.backgroundColor = [UIColor greenColor];
    
    //标题
    controller00.tabBarItem.title = @"xixi";
    controller01.tabBarItem.title = @"siqi";
    controller02.tabBarItem.title = @"huba";
    
    //按钮图片
    UIImage *image00 = [UIImage imageNamed:@"icon_01"];
    controller00.tabBarItem.image = [image00 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image01 = [UIImage imageNamed:@"icon_00"];
    controller01.tabBarItem.image = [image01 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *image02 = [UIImage imageNamed:@"icon_10"];
    controller02.tabBarItem.image = [image02 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //按钮的提醒数字
    //当有图片时,显示在右上角
    //没有图片时,显示在左上角
    //使用系统自带的图像时,不显示数字



    //init按钮样式
    UITabBarItem *bar00 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:0];
    controller00.tabBarItem = bar00;
    UITabBarItem *bar01 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:0];
    controller01.tabBarItem = bar01;
    UITabBarItem *bar02 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0];
    controller02.tabBarItem = bar02;
    
    controller00.tabBarItem.badgeValue = @"22";
    controller01.tabBarItem.badgeValue = @"22";
    controller02.tabBarItem.badgeValue = @"22";
    //令UITabBarController为UIWindow的根控制器
    self.window.rootViewController = tabBarController;
    
    
    //3.令UIWindow可见并成为Application的主窗口
    [self.window makeKeyAndVisible];
    
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
