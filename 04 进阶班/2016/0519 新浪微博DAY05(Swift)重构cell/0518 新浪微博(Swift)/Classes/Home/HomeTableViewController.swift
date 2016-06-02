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
    //var groupOfViewModle: [StatusViewModel]?
    var listMoldel = StatusListModel.shareInstance
//    {
//        didSet{
//            //在每次赋值完毕后,重新加载数据
//            tableView.reloadData()
//        }
//    }
    
    var animationDelegate = PopoverAnimationDelegate()
    
    var pullUpFlag = false

    
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

        tableView.registerClass(HomeTableViewNormalCell.self, forCellReuseIdentifier: HomeTableViewNormalCell.identifer())
        tableView.registerClass(HomeTableViewForwarCell.self, forCellReuseIdentifier: HomeTableViewForwarCell.identifer())
        
        setupNavgationBarItem()
        loadMessageFromAll()
        

        
        tableView.separatorStyle = .None
        
        self.refreshControl = SQRefreshControl(frame: CGRectZero)
        self.refreshControl?.addTarget(self, action: #selector(HomeTableViewController.loadMessageFromAll), forControlEvents: .ValueChanged)
        //只有激活下拉刷新控件的刷新状态时才会调用指定方法
        
        self.refreshControl?.beginRefreshing()
    }
    

    
    
    
    
    func loadMessageFromAll() {
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
    
//        func loadMessageFromAll() {
//
//        //取出groupOfViewModle中第一个元素的id
//        //如果为第一次加载,由于没有数据,取出的数据为0,
//        var since_id: Int = groupOfViewModle?.first?.statusModel.id ?? 0
//        var max_id: Int = 0
//        
//        if pullUpFlag {
//            since_id = 0
//            max_id = groupOfViewModle?.last?.statusModel.id ?? 0
//        }
//        
//        
//        NetWorkTools.sharedInstance.loadMessageFromAll(since_id, max_id: max_id) { (array, error) in
//            //1 安全校验
//            if error != nil {
//                SVProgressHUD.showErrorWithStatus("获取微博数据失败")
//                SVProgressHUD.setDefaultMaskType(.Black)
//                return
//            }
//            //2 遍历数组 将数组中的字典转换为模型
//            var groupOfViewModle = [StatusViewModel]()
//            for dict in array! {
//                let status = Status(dict: dict)
//                let viewModel = StatusViewModel(status: status)
//                groupOfViewModle.append(viewModel)
//            }
//            
//            //保存数据
//            if since_id != 0 {
//                // 下拉刷新
//                self.groupOfViewModle = groupOfViewModle + self.groupOfViewModle!
//            }else if max_id != 0{
//                //上拉加载
//                self.groupOfViewModle = self.groupOfViewModle! + groupOfViewModle
//            }else {
//                self.groupOfViewModle = groupOfViewModle
//            }
//            
//            self.showTipView(groupOfViewModle.count)
//
//            //缓存图片到本地后保存数据
//            self.cacheImage(groupOfViewModle)
//            
//        }
//    }
//    
//    func cacheImage(viewModels: [StatusViewModel]){
//        //创建一个组用于监听下载操作
//        let group = dispatch_group_create()
//
//        //遍历取出的所有模型
//        for viewModel in viewModels {
//            guard let pics = viewModel.thumbnail_urls else {
//                continue
//            }
//            
//            for url in pics {
//                dispatch_group_enter(group)
//                SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, bool: Bool, url: NSURL!) in
//                    
//                    dispatch_group_leave(group)
//                    
//                })
//            }
//        }
//        
//        dispatch_group_notify(group, dispatch_get_main_queue()) { 
//            //self.groupOfViewModle = viewModels
//            
//            //下载完所有数据后,停止刷新
//            self.refreshControl?.endRefreshing()   
//            //刷新UI
//            self.tableView.reloadData()
//        }
//    }
    

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
    
    
    // MAKR: - 懒加载
    private lazy var tipLabel: UILabel = {
        let lb = UILabel(text: "没有刷新到微博数据", color: UIColor.whiteColor(), screenInset: 0)
        lb.backgroundColor = UIColor.orangeColor()
        return lb
    }()
    
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
    
//    @objc private func doSomething(){
//        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(HomeTableViewController.text), userInfo: nil, repeats: false)
//
//        print("Hello World")
//    }
//    
//    func text() {
//        refreshControl?.endRefreshing()
//    }
    

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
            loadMessageFromAll()
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
