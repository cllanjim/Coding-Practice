//
//  String+Extension.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/24.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

extension String {
    /**
     快速拼接一个缓存目录的路径
     
     - returns: 拼接好的路径
     */
    func cacheDir() -> String {
        // 1.获取系统路径
        let path = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).last!
        
        // 2.拼接路径
        return (path as NSString).stringByAppendingPathComponent(self)
    }
    
    /**
     快速拼接一个文档目录的路径
     
     - returns: 拼接好的路径
     */
    func docDir() -> String {
        // 1.获取系统路径
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last!
        
        // 2.拼接路径
        return (path as NSString).stringByAppendingPathComponent(self)
    }
    
    /**
     快速拼接一个临时目录的路径
     
     - returns: 拼接好的路径
     */
    func tmpDir() -> String {
        // 1.获取系统路径
        let path = NSTemporaryDirectory()
        
        // 2.拼接路径
        return (path as NSString).stringByAppendingPathComponent(self)
    }
    
}
