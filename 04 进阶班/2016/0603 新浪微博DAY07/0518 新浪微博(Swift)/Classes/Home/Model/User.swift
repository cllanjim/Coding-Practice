//
//  User.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/26.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class User: NSObject {

    //MARK: - 设置属性
    // 用户昵称
    var screen_name: String?
    
    // 用户头像地址（中图），50×50像素
    var profile_image_url: String?
    
    // 认证类型 -1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var verified_type: Int = -1
    
    // 会员等级 1~6
    var mbrank: Int = -1
    
    //MARK: - 设置属性
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override var description: String {
        let keys = ["screen_name", "profile_image_url", "verified_type", "mbrank"]
        let dict = dictionaryWithValuesForKeys(keys)
        return "\(dict)"
    }
}
