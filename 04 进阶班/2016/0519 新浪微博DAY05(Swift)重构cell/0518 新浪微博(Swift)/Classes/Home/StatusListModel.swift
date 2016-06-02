//
//  StatusListModel.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/30.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import SVProgressHUD
import SDWebImage

class StatusListModel{
    // 单例
    static let shareInstance = StatusListModel()
    
    // 如果自定义一个单例类, 不想别人通过默认的方法创建, 那么可以重写默认的构造方法, 并且加上private
    private init() {
        
    }
    
    // 保存所有微博数据
    var groupOfViewModle: [StatusViewModel]?
    
    func loadMessageFromAll(pullUpFlag: Bool, finished:(array: [StatusViewModel]?, error: NSError?) -> ()) {
        
        var since_id: Int = groupOfViewModle?.first?.statusModel.id ?? 0
        var max_id: Int = 0
        
        if pullUpFlag {
            since_id = 0
            max_id = groupOfViewModle?.last?.statusModel.id ?? 0
        }
        
        NetWorkTools.sharedInstance.loadMessageFromAll(since_id, max_id: max_id) { (array, error) in
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
            
            //保存数据
            if since_id != 0 {
                // 下拉刷新
                self.groupOfViewModle = groupOfViewModle + self.groupOfViewModle!
            }else if max_id != 0{
                //上拉加载
                self.groupOfViewModle = self.groupOfViewModle! + groupOfViewModle
            }else {
                self.groupOfViewModle = groupOfViewModle
            }
            
            //缓存图片到本地后保存数据
            self.cacheImage(groupOfViewModle, finished: finished)
            
        }
    }
    
    func cacheImage(viewModels: [StatusViewModel], finished:(array: [StatusViewModel]?, error: NSError?) -> ()){
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
            finished(array: viewModels, error: nil)
        }
    }
}
