//
//  SQProgressView.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/6/3.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class SQProgressView: UIView {

    //MARK: - 属性
    var progress: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func drawRect(rect: CGRect) {
        //如果进度大于1 就不进行绘制
        if progress >= 1 {
            return
        }
        
        //绘制圆形
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        let radius = min(rect.width * 0.5, rect.height * 0.5)
        let start = -CGFloat(M_PI_2)
        let end = CGFloat(2 * M_PI) * progress + start
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: start, endAngle: end, clockwise: true)
        
        path.addLineToPoint(center)
        path.closePath()
        
        UIColor(white: 0.6, alpha: 0.5).setFill()
        path.fill()
        
        
        
    }
    
}
