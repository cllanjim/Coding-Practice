//
//  NSObject+Extension.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/29.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import Foundation

extension NSObject{
    class func identifer() -> String {
        return NSStringFromClass(self)
    }
}