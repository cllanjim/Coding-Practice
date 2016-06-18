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
            max_id = groupOfViewModle!.last!.statusModel.id - 1
        }
        
        //从本地数据库加载数据
        let array = loadCacheStatus(since_id, max_id: max_id)
        //判断本地数据是否为空
        if array.count != 0 {
            //进入此处,说明本地数据不为空
            let models = dicts2models(since_id, max_id: max_id, array: array)
            finished(array: models, error: nil)
            return
        }
        
        
        NetWorkTools.shareInstance.loadMessageFromAll(since_id, max_id: max_id) { (objc, error) in
            //1 安全校验
            if error != nil || objc == nil {
                SVProgressHUD.showErrorWithStatus("获取微博数据失败")
                SVProgressHUD.setDefaultMaskType(.Black)
                return
            }
            
            // 将服务器的返回值转换为字典
            guard let dict = objc as? [String: AnyObject] else {
                finished(array: nil, error: NSError(domain: "com.520it.lnj", code: 1001, userInfo: ["message": "服务器是返回的数据不是字典"]))
                return
            }
            
            // 从字典中取出所有微博数据
            guard let array = dict["statuses"] as? [[String: AnyObject]] else {
                finished(array: nil, error: NSError(domain: "com.520it.lnj", code: 1001, userInfo: ["message": "字典中没有statuses这个key"]))
                return
            }
            
            //缓存数据
            //将从服务器中返回的字典数组进行处理后缓存到本地数据库
            self.cacheStauses(array)
            
            //处理数据
            //将字典转换为模型,并保存到groupOfViewModel中
            self.dicts2models(since_id, max_id: max_id, array: array)
            
            //缓存配图
            //缓存图片到本地后保存数据
            //此处容易产生循环引用
            self.cacheImage(self.groupOfViewModle!, finished: finished)
            
            
            //2 遍历数组 将数组中的字典转换为模型
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
    
    /**
     缓存微博数据
     
     - parameter list: 需要缓存的微博模型数组
     */
    private func cacheStauses(list: [[String: AnyObject]]){
    
        //将从服务器返回的字典数组进行处理
        //存入数据库的内容包含
        //1 微博ID 主键
        //2 微博内容
        //3 微博的所有者
        
        for dict in list {
            //1 获取微博ID
            let id = dict["id"] as! Int
            //2 获取微博的内容(转换为JSON数据)
            guard let data = try? NSJSONSerialization.dataWithJSONObject(dict, options: .PrettyPrinted) else {
                continue
            }
            //转换为String类型
            let statusText = String(data: data, encoding: NSUTF8StringEncoding)!
            //3 获取用户ID
            let userID = UserAccountViewModel.shareInstance.account!.uid!
            
            
            //编写SQL语句
            let sql = "INSERT INTO T_Status" +
                "(statusId, statusText, userId)" +
                "VALUES" +
            "(?, ?, ?);"
            
            //执行SQL语句
            SQLiteManager.shareInstance.dbQueue.inTransaction({ (db, rollback) in
                do{
                    try db.executeUpdate(sql, values: [id, statusText, userID])
                }catch {
                    // 回滚
                    rollback.memory = true
                }
            })
        }
    }
    
    private func loadCacheStatus(since_id: Int = 0, max_id: Int = 0) -> [[String: AnyObject]] {
    
        //1 获取当前用户的ID
        let userID = UserAccountViewModel.shareInstance.account!.uid!

        
        //2 编写SQL语句
        var sql = "SELECT * FROM T_Status \n" +
            "WHERE \n" +
            "userId IS \(userID) \n"
        if since_id != 0 {
            //说明为下拉刷新
            sql += "AND statusId > \(since_id) \n"
        }else if max_id != 0 {
            //说明为上拉刷新
            sql += "AND statusId <= \(max_id) \n"
        }
        sql += "ORDER BY statusId DESC \n"
        sql += "LIMIT 0, 20;"
        
        
        //3 执行SQL语句
        var array = [[String: AnyObject]]()
        // 注意点: FMDB的inDatabase的block(闭包)不是异步执行的
        SQLiteManager.shareInstance.dbQueue.inDatabase { (db) -> Void in
            // 3.1执行查询语句
            let result = db.executeQuery(sql, withArgumentsInArray: nil)
            print(result)
            // 3.2从结果集中取出数据
            while result.next() {
                // 3.2.1取出微博JSON
                let str = result.stringForColumn("statusText")
                let data = str.dataUsingEncoding(NSUTF8StringEncoding)!
                
                // 3.2.2将JSON转换为字典
                guard let dict = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)  as! [String: AnyObject] else {
                    continue
                }
                array.append(dict)
            }
        }
        // 保持和从网络获取一致, 将获取到的字典数组返回给调用者
        return array
    
    }
    
    
    /**
     清空数据库过期缓存数据
     */
    func clearStatus() {
        //1 获取七天前的时间对象
        let date = NSDate(timeIntervalSinceNow: -(60 * 60 * 24 * 7))
        //2 设置时间格式
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = NSLocale(localeIdentifier: "en")
        //3 获取清楚缓存的截止日期
        let clearDateStr = formatter.stringFromDate(date)

        // 1.编写SQL语句
        let sql = "DELETE FROM T_Status WHERE createDate  <= '\(clearDateStr)';"
        
        // 2.执行SQL语句
        SQLiteManager.shareInstance.dbQueue.inDatabase { (db) -> Void in
            db.executeUpdate(sql, withArgumentsInArray: nil)
        }
        
        
    }
    
    
    
    
    
    // MAKR: - 内部控制方法
    /**
     将字典数组转换为模型数组
     
     - parameter list: 字典数组
     
     - returns: 模型数组
     */
    private func dicts2models(since_id: Int, max_id: Int, array: [[String: AnyObject]]) -> [StatusViewModel] {
    
        //1 创建用于保存模型数组的数组中间量
        var groupOfViewModle = [StatusViewModel]()
        for dict in array {
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
        
        return groupOfViewModle
    }
    

}
