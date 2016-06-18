//
//  PopoverPresentationController.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/20.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    
    private lazy var coverButton = UIButton()
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
    
        //presentedViewController 被弹出的控制器
        //presentingViewController 发起弹出的控制器
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        // 1.添加蒙版
        coverButton.backgroundColor = UIColor(white: 0.7, alpha: 0.5)
        coverButton.frame = containerView!.bounds
        coverButton.addTarget(self, action: #selector(PopoverPresentationController.coverBtnClick), forControlEvents: .TouchUpInside)
        containerView?.addSubview(coverButton)
        
    }
    
    // MAKR: - 内部控制方法
    @objc private func coverBtnClick() {
        // 关闭modal控制器
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView()?.frame = CGRect(x: 100, y: 56, width: 200, height: 200)
    }
    
    
    
}
