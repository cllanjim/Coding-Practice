//
//  AppDelegate.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/25.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "AppDelegate.h"
#import "SQMainTabBarController.h"
#import "SQNewFeatureController.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.创建UIWindow
    //UIWindow的frame是必须设置的
    //rootController的frame可以不用设置
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    

    
    //1 获取最新的版本信息
    NSDictionary *dict = [NSBundle mainBundle].infoDictionary;
    //字典中的系统版本号key值通过打印字典可以观察到
//    NSLog(@"%@", dict);
    NSString *newVersion = dict[@"CFBundleShortVersionString"];
    
    //2 获取当前的版本信息
    NSString *currentVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentVersion"];
    
    //3 判断系统的版本,选择登陆界面
    //判断字符串相等 要使用isEqualToString方法
    //判断对象相等的方法不要使用 "=="
    if ([currentVersion isEqualToString:newVersion]) {
        //2.创建Window的根控制器
        SQMainTabBarController *mainController = [[SQMainTabBarController alloc] init];
    
        self.window.rootViewController = mainController;
    }else{
        //保存版本信息
        [[NSUserDefaults standardUserDefaults] setObject:newVersion forKey:@"currentVersion"];
        
        //创建新特性界面
        //UICollectionViewController的标准构造方法如下
        //构建该类型的控制器需要一个布局参数
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        UICollectionViewController *collectionVC = [[UICollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
        SQNewFeatureController *newFeature = [[SQNewFeatureController alloc] init];
        self.window.rootViewController = newFeature;
        NSLog(@"进入新特性界面");
    }
    
    
/******************** 用于测试newFeature界面 ****************/
//    SQNewFeatureController *newFeature = [[SQNewFeatureController alloc] init];
//    self.window.rootViewController = newFeature;
//    NSLog(@"进入新特性界面");
    
    
    //3.令Window为key和可见
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
