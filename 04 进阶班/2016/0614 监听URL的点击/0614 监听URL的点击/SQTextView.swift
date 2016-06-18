//
//  SQTextView.swift
//  0614 监听URL的点击
//
//  Created by 张思琦 on 16/6/14.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class SQTextView: UITextView {

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        print("Hi")
        
        //1 获取手指点的坐标
        //获取touch对象
        let touch = (touches as NSSet).anyObject()
        //获取touch在屏幕上的位置
        guard let point = touch?.locationInView(touch?.view) else {
            return
        }
        
        //2 获取URL的frame
        //默认已经获取到URL的范围
        let range = NSMakeRange(16, 19)
        //赋值给selectedRange属性
        selectedRange = range
        // 注意: 只要我们设置了selectedRange, 系统内部就会用selectedRange的值来设置selectedTextRange
        // 我们没有办法直接创建一个UITextRange
        let textRange = selectedTextRange
        
        //获取URL在TextView中的frame
        let arrayOfFrame = selectionRectsForRange(textRange!)
        print(arrayOfFrame)
        //复原选择区域
        selectedRange = NSMakeRange(0, 0)
        
        for area in arrayOfFrame {
            //获得URL的Rect
            let temp = area as! UITextSelectionRect
            print("Hello")
            //判断触摸点是否在Rect中
            if temp.rect.contains(point){
                //如果触摸点在Rect中,就在此区域内添加代码,达到监听URL的效果
                //此处代码将在原有URL位置添加一个图层
                let otherView = UIView()
                otherView.backgroundColor = UIColor.redColor()
                otherView.frame = temp.rect
                insertSubview(otherView, atIndex: 0)
            }
        }
    }
}
