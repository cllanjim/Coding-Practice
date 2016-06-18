//
//  AppDelegate.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/18.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import QorumLogs
import AFNetworking

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        QorumLogs.enabled = true
        
        //AFN的相关设置
//        //设置缓存大小
//        let cache = NSURLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)
//        NSURLCache.setSharedURLCache(cache)
//        //设置读取数据时,是否显示加载状态
//        AFNetworkActivityIndicatorManager.sharedManager().enabled = true
        
        //搭建根控制器
        window = UIWindow(frame:UIScreen.mainScreen().bounds)
        window?.rootViewController = defaultViewController()
        window?.makeKeyAndVisible()
        
        // 设置全局外观
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        //注册并监听通知
        NSNotificationCenter.defaultCenter().addObserverForName(SQChangeRootViewControllerNotification, object: nil, queue: nil) { (notification: NSNotification) in
            // 1.取出发送通知的对象
            let flag: Bool = notification.object as! Bool
            
            // 2.判断是否是欢迎/新特性界面
            self.window?.rootViewController = flag ? MainViewController() : WelcomeViewController()
        }
        
        return true
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // 检查是否需要清空缓存
        StatusListModel.shareInstance.clearStatus()
    }
    
}

extension AppDelegate {
    private func isNewVersion() -> Bool {
        //1.加载当前软件的版本号
        let newVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        //2.加载以前的软件版本号
        let currentVersion = NSUserDefaults.standardUserDefaults().stringForKey("currentVersion")
        
        NSUserDefaults.standardUserDefaults().setObject(newVersion, forKey: "currentVersion")
        
        return newVersion > currentVersion
    }
    
    private func defaultViewController() -> UIViewController{
        if UserAccountViewModel.shareInstance.isUserLogon(){
            //如果用户登录就进入该括号
            //如果是新版本 NewFeatureViewController()
            //如果不是新版本 WelcomeViewController()
            return isNewVersion() ? NewFeatureViewController() : WelcomeViewController()
        }
        
        return MainViewController()
        
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
