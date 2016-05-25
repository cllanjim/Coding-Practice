//
//  HomeTableViewController.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/18.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import QorumLogs

class HomeTableViewController: BaseTableViewController {

    var animationDelegate = PopoverAnimationDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isUserLogin {
            visitorView.setupVisitorInfo(nil, text: nil)
            return
        }
        setupNavgationBarItem()
        
    }

    func setupNavgationBarItem() {
        
        //创建左右两边的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName:"navigationbar_friendattention",target: self, action: #selector(HomeTableViewController.leftBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName:"navigationbar_pop", target: self, action: #selector(HomeTableViewController.rightBtnClick))
        
        //创建中间的标题按钮
        let homeTitleButton = HomeTitleButton()
        homeTitleButton.setTitle("SketchK-七叔", forState: .Normal)
        homeTitleButton.addTarget(self, action: #selector(HomeTableViewController.titleBtnClick(_:)), forControlEvents: .TouchUpInside)
        navigationItem.titleView = homeTitleButton
        
    }
    
    //MARK: - 监听方法
    @objc private func titleBtnClick(btn: HomeTitleButton) {
        QL1(#function)
        //1 更改箭头方向
        btn.selected = !btn.selected
        //2.创建菜单控制器
        let sb = UIStoryboard(name: "Popover", bundle: nil)
        let vc = sb.instantiateInitialViewController()!
        //3.设置转场代理
        vc.transitioningDelegate = animationDelegate
        vc.modalPresentationStyle = .Custom
        //4.弹出界面
        presentViewController(vc, animated: true, completion: nil)
    }
    
    @objc private func leftBtnClick() {
        QL1(#function)
    }
    
    @objc private func rightBtnClick() {
        QL1(#function)
        let sb = UIStoryboard(name: "QRCode", bundle: nil)
        let vc = sb.instantiateInitialViewController()!
        
        presentViewController(vc, animated: true, completion: nil)
    }

}

