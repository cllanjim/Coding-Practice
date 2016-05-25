//
//  PopoverAnimationDelegate.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/20.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class PopoverAnimationDelegate: NSObject {
    var isPresenting = false
}

extension PopoverAnimationDelegate: UIViewControllerTransitioningDelegate{
    
    /// 该代理方法用于返回负责转场的控制器对象
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?{
        
        return PopoverPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    /// 该代理方法用于告诉系统谁来负责控制器如何弹出
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresenting = true
        return self
    }
    /// 该代理方法用于告诉系统谁来负责控制器如何消失
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresenting = false
        return self
    }
}

extension PopoverAnimationDelegate: UIViewControllerAnimatedTransitioning{
    /// 用于返回动画的时长
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return 0.5
    }
    
    /// 该方法用于负责控制器如何弹出和如何消失
    // 只要是自定义转场, 控制器弹出和消失都会调用该方法
    // 需要在该方法中告诉系统控制器如何弹出和如何消失
    
    // 注意点: 但凡告诉系统我们需要自己来控制控制器的弹出和消失
    // 也就是实现了UIViewControllerAnimatedTransitioning的方法之后, 那么系统就不会再控制我们控制器的动画了, 所有的操作都需要我们自己完成
    
    // 系统调用该方法时会传递一个transitionContext参数, 该参数中包含了我们所有需要的值
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        
        if isPresenting{
            //如果要弹出菜单
            animationPresentedController(transitionContext)
        }else{
            //如果要消失菜单
            animationDismissedController(transitionContext)
        }
    }
    
    //弹出菜单的动画
    private func animationPresentedController(transitionContext: UIViewControllerContextTransitioning) {
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        transitionContext.containerView()?.addSubview(toView)
        
        toView.transform = CGAffineTransformMakeScale(1.0, 0)
        toView.layer.anchorPoint = CGPointMake(0.5, 0)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            toView.transform = CGAffineTransformIdentity
            }, completion: { (_) in
                transitionContext.completeTransition(true)
        })
    }
    //消失菜单的动画
    private func animationDismissedController(transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            fromView.transform = CGAffineTransformMakeScale(1.0, 0.0001)
            }, completion: { (_) in
                transitionContext.completeTransition(true)
                fromView.removeFromSuperview()
        })
    }
    
}