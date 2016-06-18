//
//  SQLiteManager.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/6/17.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import FMDB

class SQLiteManager {
    
    //创建单例
    static let shareInstance: SQLiteManager = SQLiteManager()
    //创建数据库线程
    var dbQueue: FMDatabaseQueue

    private init() {
        //获取缓存文件夹的路径
        let path = "status.sqlite".cacheDir()
        //创建数据库对象
        dbQueue = FMDatabaseQueue(path:path)
        //创建表
        creatTable()
    }

    private func creatTable() {
        //1编写SQL语句
        let sql = "CREATE TABLE IF NOT EXISTS T_Status( \n" +
            "statusId INTEGER PRIMARY KEY, \n" +
            "statusText TEXT, \n" +
            "userId INTEGER,\n" +
            "createDate TEXT NOT NULL DEFAULT (datetime('now', 'localtime')) \n" +
        "); \n"
        
        //2执行SQL语句
        dbQueue.inDatabase { (db) in
            db.executeUpdate(sql, withArgumentsInArray: nil)
        }
    }

}
