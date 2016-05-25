//
//  UserAccount.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/23.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import QorumLogs

class UserAccount: NSObject, NSCoding {
    //MARK: - 属性
    // 用于调用access_token，保存授权后的access token。
    var access_token: String?
    // 当前授权用户的UID。
    var uid: String?
    // access_token的生命周期，单位是秒数。
    var expires_in: Int = -1 {
        didSet{
            let float_expires_in = Double(expires_in)
            expires_date = NSDate(timeIntervalSinceNow: float_expires_in)
        }
    }
    // token的过期日期
    var expires_date: NSDate?
    // 用户昵称
    var screen_name: String?
    // 用户头像URL字符串
    var avatar_large: String?
    
    static var filePath: String = "account.plist".cacheDir()

    
    //MARK: - 构造方法
    init(dict: [String: AnyObject]) {
        super.init()
        //利用KVC创建模型
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        //do nothing?
    }
    
    //MARK: - 归档和解归档相关方法
    //从文件里读取模型时调用
    required init?(coder aDecoder: NSCoder) {
        super.init()
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as! Int
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
        screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        
    }
    //向文件里写入模型时调用
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token,forKey: "access_token")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        
    }
    
    //MARK: - 重写输出语句
    override var description: String{
        let keys = ["access_token", "expires_in", "uid", "expires_date", "screen_name", "avatar_large"]
        let dict = dictionaryWithValuesForKeys(keys)
        return "\(dict)"
    }
    
    //MARK: - 内部控制方法
    /**
     写入对象
     - returns: 是否写入成功
     */
    class func saveUserAccount(userAccount: UserAccount) -> Bool {
//        //1获取沙盒中的cache路径
//        let path = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last!
//        //2.拼接路径
//        let filePath = (path as NSString).stringByAppendingPathComponent("account.plist")
        
        //3.写入对象数据
        return NSKeyedArchiver.archiveRootObject(userAccount, toFile: UserAccount.filePath)
    }
    
    /**
     读取写入的对象
     - returns: 读取到的对象
     */
//    class func loadUserAccount() -> UserAccount? {
////        // 1.获取系统路径
////        let path = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last!
////        // 2.拼接路径
////        let filePath = (path as NSString).stringByAppendingPathComponent("account.plist")
//        
//        // 3.读取对象
//        //如果有文件就返回对象,没文件为nil
//        //account为可选类型
//        
//        let account = NSKeyedUnarchiver.unarchiveObjectWithFile(UserAccount.filePath) as? UserAccount
//        
//        // 判断令牌是否过期
//        if account?.expires_date?.compare(NSDate()) == NSComparisonResult.OrderedAscending{
//            //过期时间早于当前时间 就说明令牌已经失效
//            QL1("AccessToken已经过期啦")
//            return nil
//        }
//    
//        return account
//    }
    
//    /**
//     判断当前是否已经登录
//     
//     - returns: 是否已经登录
//     */
//    class func userLogon() -> Bool {
//        return loadUserAccount() != nil
//    }
    
}
