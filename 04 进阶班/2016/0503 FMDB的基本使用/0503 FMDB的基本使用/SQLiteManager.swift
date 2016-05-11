//
//  SQLiteManager.swift
//  0503 FMDB的基本使用
//
//  Created by 张思琦 on 16/5/4.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import FMDB

class SQLiteManager: NSObject {
    //设置SQLiteManager的单例
    static let shareInstance: SQLiteManager = SQLiteManager()
    
    //SQLiteManager控制的数据库
    var db: FMDatabase!
    
    override init() {
        super.init()
        
        //获取文件路径
        guard let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last else{
            print("获取文件路径失败")
            return
        }



        //拼接数据库的文件路径全称
        let filePath = (path as NSString).stringByAppendingPathComponent("FMDBDemo.sqlite")
        
        //创建数据库
        db = FMDatabase(path: filePath)



        //打开数据库
        if db.open() != true {
            //如果打开数据库失败
            print("打开数据库失败")
            return
        }

        //在数据库中创建表
        self.creatTable()
        


        
        
    }
    
    //在数据库中创建表
    func creatTable() -> (){
        // 1.编写SQL语句
        let sql = "CREATE TABLE IF NOT EXISTS T_Student3(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INTEGER);"
        // 2.执行SQL语句
        db.executeUpdate(sql, withArgumentsInArray: nil)
    }
    
}
