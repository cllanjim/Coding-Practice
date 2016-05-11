//
//  AppDelegate.m
//  1223 OC调用JS
//
//  Created by 张思琦 on 15/12/23.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end




@implementation AppDelegate


void UncaughtExceptionHandler(NSException *expection){
    
    NSLog(@"我捕获到了异常,请查看");
    //在函数里无法使用self关键字
    [[UIApplication sharedApplication].delegate performSelector:@selector(showErrorInfo)];
    
    
}

- (void)showErrorInfo{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"这是一个警告" message:@"程序就要退出了,不好意思啊!" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"推吧!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定你妹啊!");
        exit(1);
    }];
    [alert addAction:action];
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    UIViewController *vc = window.rootViewController;
    [vc presentViewController:alert animated:YES completion:^{
        NSLog(@"成功");
        
    }];
    
    //注意点:当抛出异常后会使主线程关闭,进而导致无法运行后续的代码
    //所以为了让代码正常运行,就需要手动增加一个RunLoop
    
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
    
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //向NSSetUncaughtExceptionHandler函数中传入一个NSUncaughtExceptionHandler类型的对象
//    NSSetUncaughtExceptionHandler(NSUncaughtExceptionHandler * _Nullable)
    //利用typedef自定义函数NSUncaughtExceptionHandler
//    typedef void NSUncaughtExceptionHandler(NSException *exception);
    NSSetUncaughtExceptionHandler(UncaughtExceptionHandler);
    
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
