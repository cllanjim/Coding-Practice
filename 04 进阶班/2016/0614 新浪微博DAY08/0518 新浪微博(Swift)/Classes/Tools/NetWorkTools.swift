//
//  NetWorkTools.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/23.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
//import AFNetworking
import Alamofire

//class NetWorkTools: AFHTTPSessionManager {
class NetWorkTools: Alamofire.Manager {

    //MARK: - 创建单例
    static let shareInstance: NetWorkTools = {
//        let url = NSURL(string: "https://api.weibo.com/")
//        let instance = NetWorkTools(baseURL: url, sessionConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())
//        
//        //添加可接受的内容类型
//        instance.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
//        
//        return instance
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        
        return NetWorkTools(configuration: configuration)

    }()

    typealias SQResultCallback = (result: AnyObject?, error: NSError?)->()

    private func request(method: Alamofire.Method, URLString: String, parameters: [String : AnyObject]?, finished: SQResultCallback) {
        
        // 发送请求
        request(method, URLString, parameters: parameters).responseJSON { (response) -> Void in
            if response.result.isFailure {
                // 在企业开发中, 一般网络请求错误, 都不需要显示给用户(变相提示)
                // 但是一定要将网络错误打印出来, 以便于调试
                print(response.result.error)
            }
            
            finished(result: response.result.value, error: response.result.error)
        }
    }

    //MARK: - 授权相关的方法
    /**
     获取AccessToken
     */
//    func getAccessTokenWithRequestToken(requestToken: String, finished:(account: UserAccount?, error: NSError?) -> ()) {
    func getAccessTokenWithRequestToken(requestToken: String, finished:SQResultCallback) {
        //网络请求路径
        let url = "oauth2/access_token"
        //设置网络请求参数
        let parameters = [
            "client_id": SQ_App_Key,
            "client_secret": SQ_App_Secret,
            "grant_type": "authorization_code",
            "code": requestToken,
            "redirect_uri": SQ_Redirect_uri]
        
//        NetWorkTools.sharedInstance.POST(url, parameters: parameters, progress: nil, success: { (task: NSURLSessionDataTask, objc: AnyObject?) in
//            //在发送请求成功后保存数据
//            let account = UserAccount(dict: objc as! [String : AnyObject])
//            //将account放入闭包中传递出去
//            finished(account: account, error: nil)
//        }) { (task: NSURLSessionDataTask?, error: NSError) in
//            QL1("网络请求失败")
//            //将error放入闭包中传递出去
//            finished(account: nil, error: error)
//        }
        
//        request(.POST, SQ_Base_URL + url , parameters: parameters).responseJSON { (response) in
//            if response.result.isSuccess{
//                let account = UserAccount(dict: response.result.value as! [String: AnyObject])
//                finished(account: account, error: nil)
//            }else {
//                finished(account:nil, error: response.result.error)
//            }
//        }
        
        request(.POST, URLString: SQ_Base_URL + url, parameters: parameters, finished: finished)
        

    }
    
    /**
     获取用户信息
     */
//    func getUserInfo(account: UserAccount, finished:(account: UserAccount?, error: NSError?) -> ()) {
    func getUserInfo(account: UserAccount, finished:SQResultCallback) {

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
//        NetWorkTools.sharedInstance.GET(url, parameters: parameters, progress: nil, success: { (task: NSURLSessionDataTask, objc: AnyObject?) in
//            //将返回的数据转换为字典
//            let dict = objc as! [String: AnyObject]
//            //保存用户名和用户头像
//            account.screen_name = dict["screen_name"] as? String
//            account.avatar_large = dict["avatar_large"] as? String
//            //将account放入闭包中传递出去
//            finished(account: account, error: nil)
//        }) { (task: NSURLSessionDataTask?, error: NSError) in
//            QL1("网络请求失败")
//            QL1(error)
//            //将error放入闭包中传递出去
//            finished(account: nil, error: error)
//        }
        
//        request(.GET, SQ_Base_URL + url, parameters: parameters).responseJSON { (response) in
//            if response.result.isSuccess{
//                let dict = response.result.value as! [String: AnyObject]
//                account.screen_name = dict["screen_name"] as? String
//                account.avatar_large = dict["avatar_large"] as? String
//                
//                finished(account: account, error: nil)
//            }else {
//                finished(account:nil, error: response.result.error)
//            }
//        }
        
        request(.GET, URLString: SQ_Base_URL + url, parameters: parameters, finished: finished)
        
    }
    
    
    //MARK: - 获取当前登录用户及其所关注（授权）用户的最新微博
//    func loadMessageFromAll(since_id: Int, max_id: Int, finished: (array: [[String: AnyObject]]?, error: NSError?) -> () ){
    func loadMessageFromAll(since_id: Int, max_id: Int, finished: SQResultCallback ){
    
        assert(UserAccountViewModel.shareInstance.getAccess_token != nil, "必须授权之后才能获取微博数据")
        
        // 1.设置URL
        let path = "2/statuses/home_timeline.json"
        // 2.设置参数
        let parameters: [String: AnyObject] = [
            "access_token": UserAccountViewModel.shareInstance.getAccess_token!,
            "since_id": since_id,
            "max_id": max_id
        ]
        // 3.发送网络请求
//        NetWorkTools.sharedInstance.GET(path, parameters: parameters, progress: nil, success: { (task: NSURLSessionDataTask, objc: AnyObject?) in
//            // 1.将返回值转换为字典
//            guard let dict = objc as? [String: AnyObject] else {
//                finished(array: nil, error: NSError(domain: "com.520it.lnj", code: 1001, userInfo: ["message": "服务器是返回的数据不是字典"]))
//                return
//            }
//            
//            // 2.从字典中取出所有微博数据
//            guard let array = dict["statuses"] as? [[String: AnyObject]] else {
//                finished(array: nil, error: NSError(domain: "com.520it.lnj", code: 1001, userInfo: ["message": "字典中没有statuses这个key"]))
//                return
//            }
//            // 3.返回结果
//            finished(array: array, error: nil)
//            
//        }) { (task: NSURLSessionDataTask?, error: NSError) in
//            // 返回结果
//            finished(array: nil, error: error)
//        }
        
        
//        request(.GET, SQ_Base_URL + path, parameters: parameters).responseJSON { (response) in
//            if response.result.isSuccess{
//                // 1.将返回值转换为字典
//                guard let dict = response.result.value as? [String: AnyObject] else {
//                    finished(array: nil, error: NSError(domain: "com.520it.lnj", code: 1001, userInfo: ["message": "服务器是返回的数据不是字典"]))
//                    return
//                }
//                // 2.从字典中取出所有微博数据
//                guard let array = dict["statuses"] as? [[String: AnyObject]] else {
//                    finished(array: nil, error: NSError(domain: "com.520it.lnj", code: 1001, userInfo: ["message": "字典中没有statuses这个key"]))
//                    return
//                }
//                // 3.返回结果
//                finished(array: array, error: nil)
//                
//            }else {
//                
//                finished(array: nil, error: response.result.error)
//            }
//        }
        
        request(.GET, URLString: SQ_Base_URL + path, parameters: parameters, finished: finished)
        
    }
}

// MAKR: - 发送微博
extension NetWorkTools {
    
//    func sendStatus(text: String, finished: (dict: [String: AnyObject]?, error: NSError?)->()) {
    func sendStatus(text: String, finished: SQResultCallback) {
        // 1.准备路径
        let path = "2/statuses/update.json"
        // 2.准备参数
        let parameters = [
            "access_token": UserAccountViewModel.shareInstance.getAccess_token!,
            "status": text
        ]
        // 3.发送请求
        //        POST(path, parameters: parameters, progress: nil, success: { (task: NSURLSessionDataTask, objc: AnyObject?) in
        //            finished(dict: objc as? [String : AnyObject], error: nil)
        //        }) { (task: NSURLSessionDataTask?, error: NSError) in
        //            finished(dict: nil, error: error)
        //        }
        
//        request(.POST, SQ_Base_URL + path, parameters: parameters).responseJSON { (response) -> Void in
//            if response.result.isSuccess {
//                finished(dict: response.result.value as? [String : AnyObject], error: nil)
//            }else {
//                finished(dict: nil, error: response.result.error)
//            }
//        }
        request(.POST, URLString: SQ_Base_URL + path, parameters: parameters, finished: finished)
        
        
    }
    
    
    func sendStatus(text: String, image: UIImage,  finished: (dict: [String: AnyObject]?, error: NSError?)->()) {
        // 1.准备路径
        let path = "2/statuses/upload.json"
        // 2.准备参数
        let parameters = [
            "access_token": UserAccountViewModel.shareInstance.getAccess_token!,
            "status": text
        ]
        // 3.发送请求
        //        POST(path, parameters: parameters, constructingBodyWithBlock: { (fromData: AFMultipartFormData) in
        //
        //            let data = UIImagePNGRepresentation(image)!
        //            fromData.appendPartWithFileData(data, name: "pic", fileName: "abc", mimeType: "application/octet-stream")
        //
        //            }, progress: nil, success: { (task: NSURLSessionDataTask, objc: AnyObject?) in
        //
        //                finished(dict: objc as? [String : AnyObject], error: nil)
        //        }) { (task: NSURLSessionDataTask?, error: NSError) in
        //
        //            finished(dict: nil, error: error)
        //        }
        upload(
            .POST,
            SQ_Base_URL + path,
            multipartFormData: { (formData) -> Void in
                
                // 1.删除图片
                let data = UIImagePNGRepresentation(image)!
                formData.appendBodyPart(data: data, name: "pic", fileName: "xxoo.png", mimeType: "application/octet-stream")
                
                // 2.设置参数
                for (key, value) in parameters {
                    let valueData = value.dataUsingEncoding(NSUTF8StringEncoding)!
                    formData.appendBodyPart(data: valueData, name: key)
                }
                
        }) { (encodingResult) -> Void in
            switch encodingResult {
            case .Success(let upload, _, _):
                upload.responseJSON { response in
                    // 判断是否上传成功
                    if response.result.isSuccess {
                        finished(dict: response.result.value as? [String : AnyObject], error: nil)
                    }else {
                        finished(dict: nil, error: response.result.error)
                    }
                }
            case .Failure(let encodingError):
                print(encodingError)
            }
        }
    }
}
