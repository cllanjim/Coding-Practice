//
//  HomeTableViewController.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/18.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class HomeTableViewController: BaseTableViewController {

    var listMoldel = StatusListModel.shareInstance
    
    var animationDelegate = PopoverAnimationDelegate()
    
    var pullUpFlag = false

    // MAKR: - 懒加载
    private lazy var rowHeightCache: NSCache = {
        let cache = NSCache()
        cache.countLimit = 30
        return cache
    }()
    
    private lazy var tipLabel: UILabel = {
        let lb = UILabel(text: "没有刷新到微博数据", color: UIColor.whiteColor(), screenInset: 0)
        lb.backgroundColor = UIColor.orangeColor()
        return lb
    }()
    
    //MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isUserLogin {
            visitorView.setupVisitorInfo(nil, text: nil)
            return
        }

        tableView.registerClass(HomeTableViewNormalCell.self, forCellReuseIdentifier: HomeTableViewNormalCell.identifer())
        tableView.registerClass(HomeTableViewForwarCell.self, forCellReuseIdentifier: HomeTableViewForwarCell.identifer())
        tableView.separatorStyle = .None
        
        self.refreshControl = SQRefreshControl(frame: CGRectZero)
        //只有激活下拉刷新控件的刷新状态时才会调用指定方法
        self.refreshControl?.addTarget(self, action: #selector(HomeTableViewController.loadMessageAndCacheImage), forControlEvents: .ValueChanged)
        //主动调用beginRefreshing不会调用指定方法
        self.refreshControl?.beginRefreshing()
        
        setupNavgationBarItem()
        
        loadMessageAndCacheImage()
        
        //接受通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeTableViewController.showPictureView(_:)), name: SQShowBrowserNotification, object: nil)
        
    }
    
    //在析构器中移除监听者
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: - 内部调用方法
    func showPictureView(notice: NSNotification) {
        //1 取出通知中的userInfo
        guard let userInfo = notice.userInfo else {
            return
        }
        
        //取出userInfo中的所有大图地址
        guard let urls = userInfo["urls"] as? [NSURL] else {
            return
        }
        //取出userInfo中的图片序号
        guard let index = userInfo["indexPath"] as? NSIndexPath else{
            return
        }
        
        //弹出对应的控制器
        let vc = PhotoBrowserViewController(urls: urls, index: index)
        presentViewController(vc, animated: true, completion: nil)
        
    }
    
    
    func loadMessageAndCacheImage() {
        listMoldel.loadMessageFromAll(pullUpFlag) { (array, error) in
            // 1.关闭刷新
            self.refreshControl?.endRefreshing()
            
            // 2.安全校验
            if error != nil {
                SVProgressHUD.showErrorWithStatus("获取微博数据失败")
                SVProgressHUD.setDefaultMaskType(.Black)
                return
            }
            
            // 3.显示刷新提醒
            self.showTipView(array!.count)
            
            // 4.刷新表格
            self.tableView.reloadData()
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
        navigationController?.navigationBar.insertSubview(tipLabel, atIndex: 0)
        
        //设置该控件的起始位置偏移出navigationBar
        let width = UIScreen.mainScreen().bounds.width
        tipLabel.frame = CGRect(origin: CGPoint(x: 0, y: -2 * 44), size: CGSize(width: width, height: 44))
    }
    
    private func showTipView(count: Int) {
        // 1.设置标题
        tipLabel.text = (count == 0) ? "没有刷新到微博数据" : "刷新到\(count)条微博"
        
        // 2.显示动画
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.tipLabel.transform = CGAffineTransformMakeTranslation(0, 3 * 44)
        }) { (_) -> Void in
            UIView.animateWithDuration(1.0, delay: 2.0, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                self.tipLabel.transform = CGAffineTransformIdentity
                }, completion: nil)
        }
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
        return (listMoldel.groupOfViewModle?.count ?? 0)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let viewModle = listMoldel.groupOfViewModle![indexPath.row]
        
        let identifier = HomeTableViewCell.identiferWithViewModel(viewModle)
        
         let cell = tableView.dequeueReusableCellWithIdentifier(identifier,forIndexPath: indexPath) as! HomeTableViewCell
        
        cell.viewModel = viewModle
        
        // 4.判断是否是最后一条微博
        if indexPath.row == (listMoldel.groupOfViewModle!.count - 1) {
            pullUpFlag = true
            loadMessageAndCacheImage()
        }
        
        return cell
    }
    
}

//代理方法
extension HomeTableViewController {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //1 取出对应的数据模型
        let viewModel = listMoldel.groupOfViewModle![indexPath.row]
        let identifier = HomeTableViewCell.identiferWithViewModel(viewModel)

        //2 从缓存中取出高度值
        if let height = rowHeightCache.objectForKey(viewModel.statusModel.id) as? CGFloat {
            return height
        }
        
        //3 取出cell
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! HomeTableViewCell
        //4 获取当前行行高
        let height = cell.rowHeight(viewModel)
        //5 缓存行高
        rowHeightCache.setObject(height, forKey: viewModel.statusModel.id)
        
        return height
    }
}
