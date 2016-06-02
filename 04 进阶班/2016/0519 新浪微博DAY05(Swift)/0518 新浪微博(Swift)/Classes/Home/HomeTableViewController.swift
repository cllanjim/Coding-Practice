//
//  HomeTableViewController.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/18.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import QorumLogs
import SVProgressHUD
import SDWebImage

class HomeTableViewController: BaseTableViewController {
    var groupOfViewModle: [StatusViewModel]? {
        didSet{
            //在每次赋值完毕后,重新加载数据
            tableView.reloadData()
        }
    }
    
    var animationDelegate = PopoverAnimationDelegate()
    
    private lazy var rowHeightCache: NSCache = {
        let cache = NSCache()
        cache.countLimit = 30
        return cache
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isUserLogin {
            visitorView.setupVisitorInfo(nil, text: nil)
            return
        }
        setupNavgationBarItem()
        loadMessageFromAll()
        
        tableView.registerClass(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifer())
        tableView.separatorStyle = .None
        
        tableView.estimatedRowHeight = 400
//        tableView.rowHeight = 800
//        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func loadMessageFromAll() {
        NetWorkTools.sharedInstance.loadMessageFromAll { (array, error) in
            //1 安全校验
            if error != nil {
                SVProgressHUD.showErrorWithStatus("获取微博数据失败")
                SVProgressHUD.setDefaultMaskType(.Black)
                return
            }
            //2 遍历数组 将数组中的字典转换为模型
            var groupOfViewModle = [StatusViewModel]()
            for dict in array! {
                let status = Status(dict: dict)
                let viewModel = StatusViewModel(status: status)
                groupOfViewModle.append(viewModel)
            }
            
            //缓存图片到本地后保存数据
            self.cacheImage(groupOfViewModle)
            
            //3 保存数据
            //self.groupOfViewModle = groupOfViewModle
        }
    }
    
    func cacheImage(viewModels: [StatusViewModel]){
        //创建一个组用于监听下载操作
        let group = dispatch_group_create()

        //遍历取出的所有模型
        for viewModel in viewModels {
            guard let pics = viewModel.thumbnail_urls else {
                continue
            }
            
            for url in pics {
                dispatch_group_enter(group)
                
                SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, bool: Bool, url: NSURL!) in
                    
                    dispatch_group_leave(group)
                    
                })
            }
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue()) { 
            self.groupOfViewModle = viewModels

        }
    }
    

    func setupNavgationBarItem() {
        
        //创建左右两边的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName:"navigationbar_friendattention",target: self, action: #selector(HomeTableViewController.leftBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName:"navigationbar_pop", target: self, action: #selector(HomeTableViewController.rightBtnClick))
        
        //创建中间的标题按钮
        let homeTitleButton = HomeTitleButton()
        //读取UserAccount模型中用户名称
        let name = UserAccountViewModel.shareInstance.getScreen_name
        homeTitleButton.setTitle(name, forState: .Normal)
        homeTitleButton.addTarget(self, action: #selector(HomeTableViewController.titleBtnClick(_:)), forControlEvents: .TouchUpInside)
        navigationItem.titleView = homeTitleButton
        
    }
    
    //MARK: - 监听方法
    @objc private func titleBtnClick(btn: HomeTitleButton) {
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
    }
    
    @objc private func rightBtnClick() {
        let sb = UIStoryboard(name: "QRCode", bundle: nil)
        let vc = sb.instantiateInitialViewController()!
        
        presentViewController(vc, animated: true, completion: nil)
    }

}

//数据源方法
extension HomeTableViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (groupOfViewModle?.count ?? 0)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(HomeTableViewCell.identifer(),forIndexPath: indexPath) as! HomeTableViewCell
        
        let viewModle = groupOfViewModle![indexPath.row]
        QL1(indexPath.row)
        cell.viewModel = viewModle
        
        return cell
    }
    
}

//代理方法
extension HomeTableViewController {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //1 取出对应的数据模型
        let viewModel = groupOfViewModle![indexPath.row]
        //2 从缓存中取出高度值
        if let height = rowHeightCache.objectForKey(viewModel.statusModel.id) as? CGFloat {
            QL1("缓存中")
            return height
        }
        
        //3 取出cell
        let cell = tableView.dequeueReusableCellWithIdentifier(HomeTableViewCell.identifer()) as! HomeTableViewCell
        //4 获取当前行行高
        let height = cell.rowHeight(viewModel)
        //5 缓存行高
        rowHeightCache.setObject(height, forKey: viewModel.statusModel.id)
        QL1("计算中")
        
        return height
        
    }
}
