//
//  SQLiteManager.swift
//  0428 SQL&Swift - DDL语句
//
//  Created by 张思琦 on 16/4/28.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class SQLiteManager: NSObject {

    //利用Runtime创建单例
    /*!
     * @typedef dispatch_once_t
     *
     * @abstract
     * A predicate for use with dispatch_once(). It must be initialized to zero.
     * Note: static and global variables default to zero.
     */
//    static var onceToken: dispatch_once_t = 0
//    static var _instance: SQLiteManager?
//    
//    class func sharedSQLiteManager() -> SQLiteManager{
//        dispatch_once(&onceToken) { 
//            _instance = SQLiteManager()
//        }
//        return _instance!
//    }
    
    //swift中创建单例的方法
    static let shareInstance : SQLiteManager = SQLiteManager()
    
    // 0.定义变量用于保存被打开的数据库
    var db: COpaquePointer = nil
    
    //重写init方法
    override init() {
        super.init()
        
        //获取数据库文件的路径
        //此处NSSearchPathForDirectoriesInDomains返回的是可选类型
        guard let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last else{
            return
        }
        
        //拼接文件的路径名
        let filePath = (path as NSString).stringByAppendingPathComponent("demo.sqlite")
     
        //将路径名转换为C语言字符串
        guard let cFilePath = filePath.cStringUsingEncoding(NSUTF8StringEncoding)
        else{
            return
        }
        
        //1.创建数据库文件
        /*
         SQLITE_API int SQLITE_STDCALL sqlite3_open(
         const char *filename,   /* Database filename (UTF-8) */
         sqlite3 **ppDb          /* OUT: SQLite db handle */
         );
         第一个参数: 需要打开的数据库文件的路径
         第二个参数: 用于保存被打开的数据库
         特点: 如果指定的文件路径没有对应的数据库文件, 就会自动创建一个新的
         如果指定的文件路径有对应的数据库文件, 就会直接打开
         */
        if sqlite3_open(cFilePath, &db) != SQLITE_OK{
            print("创建失败")
            return
        }
     
        //2.创建数据库中的表
        self.createTable()
    }
    
    func createTable(){
        //1.编写SQL语句
        let sql = "CREATE TABLE IF NOT EXISTS T_Student3(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INTEGER);"
        
        guard let cSql = sql.cStringUsingEncoding(NSUTF8StringEncoding)
        else{
            return
        }
        
        //2.执行SQL语句
        /*
         int sqlite3_exec(
         sqlite3*,                                  /* An open database */
         const char *sql,                           /* SQL to be evaluated */
         int (*callback)(void*,int,char**,char**),  /* Callback function */
         void *,                                    /* 1st argument to callback */
         char **errmsg                              /* Error msg written here */
         );
         第一个参数: 一个已经打开的数据库
         第二个参数: 需要执行的SQL语句
         第三个参数: 执行SQL之后的回调函数
         第四个参数: 回调函数的第一个参数
         第五个参数: 保存错误的指针
         */
        if sqlite3_exec(db, cSql, nil, nil, nil) != SQLITE_OK{
            print("创建表格失败")
            return
        }
        
        print("创建表格成功")
    }
    
    
    
    
}
