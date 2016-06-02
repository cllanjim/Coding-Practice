//
//  Picture.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/27.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class Picture: NSObject {
    // 配图字符串地址
    var thumbnail_pic: String?
    
    init(dict: [String: AnyObject]){
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override var description: String {
        let keys = ["thumbnail_pic"]
        let dict = dictionaryWithValuesForKeys(keys)
        return "\(dict)"
    }
    
}
