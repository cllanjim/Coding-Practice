//
//  Status.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/26.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class Status: NSObject {
    //MARK: - 设置属性
    // 微博创建时间
    var created_at: String?
    // 微博ID
    var id: Int = -1
    // 微博信息内容
    var text: String?
    // 微博来源
    var source: String?
    // 用户属性
    var user: User?
    // 当前微博所有配图
    var pic_urls: [Picture]?
    
    //MARK: - 构造方法
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        //do nothing?
    }
    
    override var description: String {
        let keys = ["created_at", "id", "text", "source"]
        let dict = dictionaryWithValuesForKeys(keys)
        return "\(dict)"
    }
    
    //MARK: - 拦截操作
    // KVC的setValuesForKeysWithDictionary方法内部其实是调用以下方式实现赋值
    // 注意点: KVC默认的实现是将取到的值直接赋值给对应的属性, 如果想自定义一些操作可以重写以下方法, 拦截对应的key, 做自定义操作
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "user" {
            user = User(dict: value as! [String: AnyObject])
            return
        }else if key == "pic_urls" {
            var models = [Picture]()
            for dict in (value as! [[String: AnyObject]]){
                models.append(Picture(dict: dict))
            }
            pic_urls = models
            return
        }
        super.setValue(value, forKey: key)
    }
    
}
