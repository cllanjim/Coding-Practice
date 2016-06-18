//
//  PhotoBrowserAnimateDelegate.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/6/3.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

protocol PhotoBrowserDelegate : NSObjectProtocol {
    // 获取一个和被点击cell一模一样的UIImageView
    func photoBrowserAnimationImage(path: NSIndexPath) -> UIImageView
    // 获取被点击cell相对于keywindow的frame
    func photoBrowserAnimationFromRect(path: NSIndexPath) -> CGRect
    // 获取被点击cell中的图片, 将来在图片浏览器中显示的尺寸
    func photoBrowserAnimationToRect(path: NSIndexPath) -> CGRect

}

class PhotoBrowserAnimateDelegate: NSObject {
    //用于记录是否弹出
    private var isPresented = false
    //代理者
    weak var delegate: PhotoBrowserDelegate?
    //当前被点击的cell序号
    var index: NSIndexPath?
}

extension PhotoBrowserAnimateDelegate: UIViewControllerTransitioningDelegate {
    /**
     该代理方法用于返回负责转场的控制器对象
     
     - parameter presented:  被弹出的视图控制器
     - parameter presenting: 将presented弹出的视图控制器
     - parameter source:     发起转场动画的视图控制器
     
     - returns: 返回负责转场的控制器对象
     */
    func presentationControllerForPresentedViewController(
        presented: UIViewController,presentingViewController presenting: UIViewController,sourceViewController source: UIViewController)->UIPresentationController? {
         
        return UIPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    //方法的返回值负责管理控制器的弹出
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    //方法的返回值负责管理控制器的消失
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}


extension PhotoBrowserAnimateDelegate: UIViewControllerAnimatedTransitioning {

    /// 用于返回动画的时长, 默认用不上
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.0
    }
    
    // 该方法用于负责控制器如何弹出和如何消失
    // 只要是自定义转场, 控制器弹出和消失都会调用该方法
    // 需要在该方法中告诉系统控制器如何弹出和如何消失
    
    // 注意点: 但凡告诉系统我们需要自己来控制控制器的弹出和消失
    // 也就是实现了UIViewControllerAnimatedTransitioning的方法之后, 那么系统就不会再控制我们控制器的动画了, 所有的操作都需要我们自己完成
    
    // 系统调用该方法时会传递一个transitionContext参数, 该参数中包含了我们所有需要的值
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        
        // 1.判断当前是弹出还是消失
        if isPresented {
            // 弹出
            animatePresentedController(transitionContext)
        }else {
            // 消失
            animateDismissedController(transitionContext)
        }
        
    }
    
    // 弹出动画
    private func animatePresentedController(transitionContext: UIViewControllerContextTransitioning) {
        
        assert(index != nil, "必须知道当前点击cell的索引才可以执行动画")
        assert(delegate != nil, "必须有代理对象才能执行动画")
        
        //1.新建一个ImageView, 设置ImageView的内容和被点击cell的内容一致
        let imageView = delegate!.photoBrowserAnimationImage(index!)
        
        //2.设置新建的ImageView的frame和被点击cell的frame一致
        let fromRect = delegate!.photoBrowserAnimationFromRect(index!)
        imageView.frame = fromRect
        
        //3.将新建的UIImageView添加到容器视图上
        transitionContext.containerView()?.addSubview(imageView)
        
        
        //5.让新建的ImageView执行动画, 将图片放大到和屏幕一样宽
        let toRect = delegate!.photoBrowserAnimationToRect(index!)
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            imageView.frame = toRect
        }) { (_) -> Void in
            
            //        1.删除新建的ImageView, 添加图片浏览器到容器视图上
            imageView.removeFromSuperview()
            //        2.拿到图片浏览器
            guard let toView = transitionContext.viewForKey(UITransitionContextToViewKey) else {
                return
            }
            transitionContext.containerView()?.addSubview(toView)
            // 3.告诉系统动画执行完毕
            transitionContext.completeTransition(true)
            
        }
    }
    
    // 隐藏动画
    private func animateDismissedController(transitionContext: UIViewControllerContextTransitioning) {
        
        
        
        // 3.告诉系统动画执行完毕
        transitionContext.completeTransition(true)
    }
    

}
