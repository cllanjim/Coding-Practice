//
//  UIButton+Extension.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/19.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

extension UIButton {

    convenience init(imageName: String?, backgroundImageName: String?) {
        self.init()
        
        if let name = imageName where name != "" {
            // 设置图标
            setImage(UIImage(named: name), forState: .Normal)
            setImage(UIImage(named: name + "_highlighted"), forState: .Highlighted)
        }
       
        if let name = backgroundImageName where name != ""{
            // 设置背景
            setBackgroundImage(UIImage(named: name), forState: .Normal)
            setBackgroundImage(UIImage(named: name + "_highlighted"), forState: .Highlighted)
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
    
    convenience init(title: String, imageName: String, backgroundImageName: String, color: UIColor = UIColor.darkGrayColor(), font: UIFont = UIFont.systemFontOfSize(15)) {
        
        self.init(imageName: imageName, backgroundImageName: backgroundImageName)
        
        titleLabel?.font = font
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        setTitle(title, forState: .Normal)
        setTitleColor(color, forState: .Normal)
    }
    
}
