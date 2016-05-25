//
//  BaseTableVC.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/19.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    var isUserLogin = true
    var visitorView: VisitorView!
    override func loadView() {
        if isUserLogin {
            super.loadView()
        }else{
            visitorView = VisitorView()
            //visitorView.delegate = self
            visitorView.registerButton.addTarget(self, action: #selector(BaseTableViewController.registerButtonOnClick), forControlEvents: .TouchUpInside)
            visitorView.loginButton.addTarget(self, action: #selector(BaseTableViewController.loginButtonOnClick), forControlEvents: .TouchUpInside)
            view = visitorView
            
            //初始化导航条
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(BaseTableViewController.registerButtonOnClick))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(BaseTableViewController.loginButtonOnClick))
        }
    }
    
    // MAKR: - 内部控制方法
    @objc private func registerButtonOnClick() {
        print("")
        
    }
    @objc private func loginButtonOnClick() {
        print("")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
