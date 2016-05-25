//
//  HomeTitleButton.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/19.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class HomeTitleButton: UIButton {

    //因为是纯代码搭建,一定会调用该方法
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: .Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: .Selected)
        sizeToFit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.bounds.size.width
        
    }
    
    
    override func setTitle(title: String?, forState state: UIControlState) {
        guard var newTitle = title else{
             return super.setTitle(title, forState: state)
        }
        
        newTitle += "  "
        
        super.setTitle(newTitle, forState: state)
    }

}
