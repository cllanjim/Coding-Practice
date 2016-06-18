//
//  UserAccountViewModel.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/24.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import Foundation
import QorumLogs
import SVProgressHUD

class UserAccountViewModel {
    //创建单例
    static let shareInstance: UserAccountViewModel = UserAccountViewModel()
    
    //用户模型
    var account: UserAccount?
    
    //构造方法
    init() {
        // 1.读取对象
        let account = NSKeyedUnarchiver.unarchiveObjectWithFile(UserAccount.filePath) as? UserAccount
        
        // 2.判断是否过期
        if isExpires  {
            self.account = nil
            return
        }
        
        // 3.保存授权模型
        self.account = account
    }
    
    // 记录授权模型是否过期
    var isExpires: Bool {
        if account?.expires_date?.compare(NSDate()) == NSComparisonResult.OrderedAscending  {
            //过期时间早于当前时间,说明已经过期
            return true
        }
        return false
    }
    
    // 便利获取
    var getAccess_token: String? {
        return account?.access_token
    }
    var getScreen_name: String? {
        return account?.screen_name
    }
    var getAvatar_URL: NSURL? {
        return NSURL(string: account?.avatar_large ?? "")
    }

    // 判断用户是否登录
    func isUserLogon() -> Bool {
        return account != nil
    }
}

//与网络请求相关的
extension UserAccountViewModel {
    //获取RequestToken
    func getAccessTokenWithRequestToken(requestToken: String, finished: (account: UserAccount?, error: NSError?)->()) {
        NetWorkTools.sharedInstance.getAccessTokenWithRequestToken(requestToken, finished: finished)
    }
    
    //获取用户信息
    func getUserInfo(account: UserAccount, finished: (account: UserAccount?, error: NSError?)->()) {
        NetWorkTools.sharedInstance.getUserInfo(account, finished: finished)
    }
    
    //将获取RequestToken和获取用户信息的代码整合到一起
    func saveAccessTokenAndUserInfo(requestToken: String, finished: ()->()) {
         NetWorkTools.sharedInstance.getAccessTokenWithRequestToken(requestToken) { (account, error) in
            // 1.安全校验
            if error != nil || account == nil {
                SVProgressHUD.showErrorWithStatus("授权失败了...")
                SVProgressHUD.setDefaultMaskType(.Black)
                return
            }
            NetWorkTools.sharedInstance.getUserInfo(account!, finished: { (account, error) in
                // 1.安全校验
                if error != nil || account == nil {
                    SVProgressHUD.showErrorWithStatus("授权失败了...")
                    SVProgressHUD.setDefaultMaskType(.Black)
                    return
                }
                
                // 2.保存授权模型
                UserAccount.saveUserAccount(account!)
                UserAccountViewModel.shareInstance.account = account!
                
                finished()
            })
        }
    }
}