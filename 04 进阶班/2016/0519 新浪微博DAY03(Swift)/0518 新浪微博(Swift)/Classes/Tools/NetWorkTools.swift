//
//  NetWorkTools.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/23.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import AFNetworking
import QorumLogs

class NetWorkTools: AFHTTPSessionManager {

    //MARK: - 创建单例
    static let sharedInstance: NetWorkTools = {
        let url = NSURL(string: "https://api.weibo.com/")
        let instance = NetWorkTools(baseURL: url, sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        //添加可接受的内容类型
        instance.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
        
        return instance
    }()
    
    //MARK: - 授权相关的方法
    /**
     获取AccessToken
     */
    func getAccessTokenWithRequestToken(requestToken: String, finished:(account: UserAccount?, error: NSError?) -> ()) {
        //网络请求路径
        let url = "oauth2/access_token"
        //设置网络请求参数
        let parameters = [
            "client_id": SQ_App_Key,
            "client_secret": SQ_App_Secret,
            "grant_type": "authorization_code",
            "code": requestToken,
            "redirect_uri": SQ_Redirect_uri]
        
        NetWorkTools.sharedInstance.POST(url, parameters: parameters, progress: nil, success: { (task: NSURLSessionDataTask, objc: AnyObject?) in
            //在发送请求成功后保存数据
            let account = UserAccount(dict: objc as! [String : AnyObject])
            //将account放入闭包中传递出去
            finished(account: account, error: nil)
        }) { (task: NSURLSessionDataTask?, error: NSError) in
            QL1("网络请求失败")
            //将error放入闭包中传递出去
            finished(account: nil, error: error)
        }
    }
    
    /**
     获取用户信息
     */
    func getUserInfo(account: UserAccount, finished:(account: UserAccount?, error: NSError?) -> ()) {
        // 断言
        // 断言就是断定前面的条件一定成立, 如果不成立, 那么程序就会崩溃, 并且会在控制台数据后面的message
        assert(account.access_token != nil, "必须授权之后才能调用")
        assert(account.uid != nil, "必须授权之后才能调用")
        
        // 1.设置请求路径
        let url = "2/users/show.json"
        
        // 2.设置请求参数
        let parameters = [
            "access_token": account.access_token! ,
            "uid": account.uid!
        ]
        
        // 3.发送POST请求
        NetWorkTools.sharedInstance.GET(url, parameters: parameters, progress: nil, success: { (task: NSURLSessionDataTask, objc: AnyObject?) in
            //将返回的数据转换为字典
            let dict = objc as! [String: AnyObject]
            //保存用户名和用户头像
            account.screen_name = dict["screen_name"] as? String
            account.avatar_large = dict["avatar_large"] as? String
            //将account放入闭包中传递出去
            finished(account: account, error: nil)
        }) { (task: NSURLSessionDataTask?, error: NSError) in
            QL1("网络请求失败")
            //将error放入闭包中传递出去
            finished(account: nil, error: error)
        }
    }
}
