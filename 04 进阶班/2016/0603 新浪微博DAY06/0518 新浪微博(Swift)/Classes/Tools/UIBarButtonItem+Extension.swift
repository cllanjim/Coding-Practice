//
//  UIBarButtonItem+Extension.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/19.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    convenience init(imageName: String, target: AnyObject, action: Selector) {
       
        let btn = UIButton(imageName: imageName,backgroundImageName: "")
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        
        self.init(customView: btn)
    }
}
