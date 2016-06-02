//
//  UIColor+Extension.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/29.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

extension UIColor{
    
    class func randomColor() -> UIColor {
        let red = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        let green = CGFloat( arc4random_uniform(255))/CGFloat(255.0)
        let blue = CGFloat(arc4random_uniform(255))/CGFloat(255.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}