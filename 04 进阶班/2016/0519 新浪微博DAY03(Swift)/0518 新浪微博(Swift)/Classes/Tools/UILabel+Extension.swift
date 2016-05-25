//
//  UILabel+Extension.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/19.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

extension UILabel{

    convenience init(text: String,
                     color: UIColor = UIColor.lightGrayColor(),
                     screenInset: CGFloat = 0) {
        
        self.init()
        self.text = text
        textColor = color
        if screenInset != 0 {
            textAlignment = .Left
        }else {
            numberOfLines = 0
            textAlignment = .Center
        }
    }

}
