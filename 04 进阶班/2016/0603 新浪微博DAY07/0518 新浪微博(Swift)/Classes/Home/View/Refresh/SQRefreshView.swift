//
//  SQRefreshView.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/30.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class SQRefreshView: UIView {

    //箭头的imageView
    @IBOutlet weak var arrowImageView: UIImageView!
    //下拉刷新的label
    @IBOutlet weak var tipLabel: UILabel!
    //加载刷新的view
    @IBOutlet weak var loadingView: UIView!
    //刷新的imageView
    @IBOutlet weak var loadingImageView: UIImageView!
    
    
    class func refreshView() -> SQRefreshView {
        return NSBundle.mainBundle().loadNibNamed("SQRefreshView", owner: nil, options: nil).last as! SQRefreshView
    }
    
    
    //MARK - 外部调用方法
    func rotationArrow(flag: Bool) {
        /*
         CGAffineTransformRotate特点:
         1.就近原则, 那边近就从哪边走
         2.顺时针, 如果距离一样, 就按照顺时针
         */
        var angle: CGFloat = flag ? -0.01 : 0.01
        angle += CGFloat(M_PI)
        
        UIView.animateWithDuration(2.0) {
            self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, angle)
        }
    }
    
    func startLoadingView() {
        //使loadingView显现出来
        loadingView.hidden = false
        //判断loadingImageview是否正在动画,如果正在进行动画就直接退出
        if let _ = loadingImageView.layer.animationForKey("sq") {
            return
        }
        
        //1 创建动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        //2 设置动画属性
        anim.toValue = 2 * M_PI
        anim.duration = 5.0
        anim.repeatCount = MAXFLOAT
        //3 添加动画
        loadingImageView.layer.addAnimation(anim, forKey: "sq")
        
    }
    
    func recoverStartStatus() {
        //使arrowImageView中的状态恢复到起始
        arrowImageView.transform = CGAffineTransformIdentity
        //移除loadingImageView中的动画
        loadingImageView.layer.removeAllAnimations()
        //隐藏loadingView
        loadingView.hidden = true
    }
    

}
