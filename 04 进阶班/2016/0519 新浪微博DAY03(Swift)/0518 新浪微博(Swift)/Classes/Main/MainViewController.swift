//
//  MainViewController.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/18.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import QorumLogs

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.添加子控制器
        self.addChildViewControllers()
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //1.添加加号按钮
        setupComposeButton()
    }
    
    // MARK: - 懒加载
    private lazy var composeButton: UIButton = UIButton(imageName: "tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
}


//MARK: - 设置UI
extension MainViewController {
    /**
     设置加号按钮
     */
    private func setupComposeButton() {
        //向TabBar中添加+号按钮
        tabBar.addSubview(composeButton)
        
        let count = childViewControllers.count
         //让按钮宽一点点，能够解决手指触摸的容错问题
        let w = tabBar.bounds.width / CGFloat(count)
        composeButton.frame = CGRectInset(tabBar.bounds, 2 * w, 0)
        
        composeButton.addTarget(self, action: #selector(MainViewController.composeBtnOnClick), forControlEvents: .TouchUpInside)
    }
    
    /**
     加号按钮响应的方法
     */
    @objc private func composeBtnOnClick() {
    
    }
    
    /**
     添加所有子控制器
     */
    private func addChildViewControllers(){
        //模拟加载服务器返回的数据
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)!
        let data = NSData(contentsOfFile: path)!
        
        //判断数据是否为空
        guard let objc = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) else {
            //如果服务器没有返回数据,就创建括号内的控制器
            self.addChildViewControllerUse("HomeTableViewController", title: "主页", imageName: "tabbar_home")
            self.addChildViewControllerUse("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
            self.addChildViewControllerUse("NullViewController", title: nil, imageName: nil)
            self.addChildViewControllerUse("DiscoverTableViewController", title: "发现", imageName: "tabbar_discover")
            self.addChildViewControllerUse("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
            return
        }
        
        //如果不为空,就获取服务器的相关信息并加载新的控制器
        guard let array = objc as? [ [String: AnyObject] ] else {

            return
        }
        
        for dict in array {
            addChildViewControllerUse(dict["vcName"] as? String, title: dict["title"] as? String, imageName: dict["imageName"] as? String)
        }
        
    }
    
    /**
     利用对象名称初始化子控制器
     
     - parameter childController: 需要初始化控制器的名称
     - parameter title:           子控制器名称
     - parameter imageName:       子控制器的图片名称
     */
    private func addChildViewControllerUse(childControllerName: String?, title: String?, imageName: String?) {
        
        //获取动态空间的名称
        guard let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as? String else{
            return
        }
        
        //获取需要初始化对象的全称
        guard let cls: AnyClass = NSClassFromString(nameSpace + "." + (childControllerName ?? "")) else {
            return
        }
        
        //将cls转换为UITableViewController
        guard let clsType = cls as? UIViewController.Type else{
            return
        }
        //创建控制器
        let childController = clsType.init()
        
        //设置子控制器的相关属性
        childController.title = title
        //服务器返回的数据中,可能存在对应的键,但对应的值是""(与nil不同),
        if let name = imageName where name != ""{
            childController.tabBarItem.image = UIImage(named: name)
            childController.tabBarItem.selectedImage = UIImage(named: name + "_highlighted")
        }
        
        //将子控制器添加到navigationController中
        let nav = UINavigationController(rootViewController:childController)
        //将navigationController添加到tabBar中
        self.addChildViewController(nav)
    }
    
    
}

