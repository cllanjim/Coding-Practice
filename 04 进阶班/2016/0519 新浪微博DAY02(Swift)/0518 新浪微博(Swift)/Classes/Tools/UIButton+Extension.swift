//
//  UIButton+Extension.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/19.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

extension UIButton {

    convenience init(imageName: String, backgroundImageName: String) {
        self.init()
        
        if imageName != ""{
            // 设置图标
            setImage(UIImage(named: imageName), forState: .Normal)
            setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        }
       
        if backgroundImageName != ""{
            // 设置背景
            setBackgroundImage(UIImage(named: backgroundImageName), forState: .Normal)
            setBackgroundImage(UIImage(named: backgroundImageName + "_highlighted"), forState: .Highlighted)
        }

        // 调整按钮尺寸
        sizeToFit()
    }
    
    
    convenience init(title: String, backgroundImageName: String, color: UIColor){
        self.init()
        
        setTitle(title, forState: .Normal)
        setBackgroundImage(UIImage(named: backgroundImageName), forState: .Normal)
        setTitleColor(color, forState: .Normal)
    }
}
