//
//  AppDelegate.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/18.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import QorumLogs

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        // 打开LOG
//        QorumLogs.enabled = true
        
        //搭建根控制器
        window = UIWindow(frame:UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.redColor()
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        
        // 设置全局外观
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        return true
    }

    /**
     QorumLogs框架的基本使用
     */
    func useOfQorumLogs() -> Void {
        // 打开LOG
        QorumLogs.enabled = true
        // 测试LOG
//        QorumLogs.test()
        // 设置需要显示的等级
//        QorumLogs.minimumLogLevelShown = 4
        // 限定输出文件
        //QorumLogs.onlyShowThisFile(MainViewController)
        
//        QL1("lnj") // debug
//        QL2("lnj")  // info
//        QL3("lnj") // warning
//        QL4("lnj") // error
//        QLPlusLine() // 打印加号作为分割线
//        QLShortLine() // 打印等号作为分割线
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

/**
自定义输出
*/
func SQLog<T>(message: T,
              file: String = #file,
              method: String = #function,
              line: Int = #line
    ) -> Void {
    
    #if SQ_DEBUG
        print("\((file as NSString).lastPathComponent)[\(line),\(method):\(message)]")
    #endif
    }
