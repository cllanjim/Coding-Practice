//
//  SQLiteManager.swift
//  0502 SQL&Swift - DML语句
//
//  Created by 张思琦 on 16/5/2.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class SQLiteManager: NSObject {
    //创建单例
    static let sharedInstance = SQLiteManager()
    
    private var db : COpaquePointer = nil
    
    override init() {
        super.init()
        
        //0.获取保存数据库文件的路径
        guard let path = NSSearchPathForDirectoriesInDomains(.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last else{
            return
        }
        //1.拼接数据库文件名称
        let filePath = (path as NSString).stringByAppendingPathComponent("demo2.sqlite")
        
        //2.将文件路径转换为C字符串
        guard let cFilePath = filePath.cStringUsingEncoding(NSUTF8StringEncoding) else{
            print("转换路径名失败")
            return
        }
        
        //3.创建数据库
        if sqlite3_open(cFilePath, &db) != SQLITE_OK{
            print("打开数据库失败")
        }
        
        //4.向数据库中添加表
        if self.creatTable() == true{
            print("添加表成功")
        }else{
            print("添加表失败")
        }
        
    }

    /*
     串行队列 - SQLite 本质上就是一个文件，如果多个线程同时对数据库进行读写
     会造成数据混乱，可以使用一个串行队列，顺序调度任务，就不会出现数据混乱的问题
     注意：`串行队列`不能嵌套，一旦嵌套，同样会出现互相等待的情况，造成死锁！
     */
    private let dbQueue = dispatch_queue_create("forSQLite", DISPATCH_QUEUE_SERIAL)
    //创建函数,保证相应的操作在
    func queueExec(action:(manager: SQLiteManager)->())->(){
        dispatch_async(dbQueue) { 
            ()->()
            in
            print(NSThread.currentThread())
            //执行闭包
            action(manager: self)
        }
    }
    
    /**
     开启事务
     */
    func beginTransaction()
    {
        let sql = "BEGIN TRANSACTION;"
        execSQL(sql)
    }
    /**
     提交事务
     */
    func commitTransaction()
    {
        let sql = "COMMIT TRANSACTION;"
        execSQL(sql)
    }
    /**
     回滚事务
     */
    func rollbackTransaction()
    {
        let sql = "ROLLBACK TRANSACTION;"
        execSQL(sql)
    }
    
    //创建表
    func creatTable() -> Bool{
        //1.编写sql语句
        let sql = "CREATE TABLE IF NOT EXISTS T_Student3(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age INTEGER);"
        //2.执行sql语句
        return self.execSQL(sql)
        
    }
    
    //执行sql语句
    func execSQL(sql:String) -> Bool{
        guard let cSQL = sql.cStringUsingEncoding(NSUTF8StringEncoding) else{
            print("转换SQL语句失败")
            return false
        }
        
        if sqlite3_exec(db, cSQL, nil, nil, nil) != SQLITE_OK{
            print("执行SQL语句失败")
            return false
        }
        
        print("执行SQL语句成功")
        return true
    }
    
    
    //执行SQL语句,并绑定参数
    let SQLITE_TRANSIENT = unsafeBitCast(-1, sqlite3_destructor_type.self)
    func execSQL(SQL sql:String, Arguments args:CVarArgType...) -> Bool{
        //将SQL语句转换为C字符串
        guard let cSQL = sql.cStringUsingEncoding(NSUTF8StringEncoding) else{
            print("SQL语句转换失败")
            return false
        }
        
        //设置数据库操作的句柄
        var stmt: COpaquePointer = nil
    
        //对SQL语句进行预编译
        if sqlite3_prepare_v2(db, cSQL, -1, &stmt, nil) != SQLITE_OK{
            print("SQL语句预编译失败")
            return false
        }
        
        //设置循环角标
        var index: Int32 = 1
        //循环args中的参数进行绑定
        for arg in args{
            // 2.1判断当前遍历到的值对应的数据类型
            if arg is Int {
                let temp = Int32(arg as! Int)
                sqlite3_bind_int(stmt, index, temp)
                /*
                 第一个参数: 预编译时的stmt对象
                 第二个参数: 告诉系统需要将参数绑定到哪个位置
                        注意: 该索引从1开始
                 第三个参数: 告诉系统需要绑定的值
                 */
            }else if arg is Double {
                let temp = arg as! Double
                sqlite3_bind_double(stmt, index, temp)
            }else if arg is String {
                let temp = arg as! String
                guard let cTemp = temp.cStringUsingEncoding(NSUTF8StringEncoding) else {
                    continue
                }

                sqlite3_bind_text(stmt, index, cTemp, -1, SQLITE_TRANSIENT)
                /*
                 第一个参数: 预编译时的stmt对象
                 第二个参数: 告诉系统需要将参数绑定到哪个位置
                 第三个参数: 告诉系统需要绑定的值
                 
                 第五个参数: 告诉系统如何处理传入的字符串
                 如果传递SQLITE_STATIC 代表告诉系统不需要任何处理, 如果字符串在使用之前销毁了, 那么使用的就是乱码
                 如果传递SQLITE_TRANSIENT, 代表告诉系统需要对字符串进行copy, 该方法内部会管它它的生命周期, 当使用完成之后会自动释放
                 
                 注意: Swift中没有宏定义
                 #define SQLITE_STATIC      ((sqlite3_destructor_type)0)
                 #define SQLITE_TRANSIENT   ((sqlite3_destructor_type)-1)
                 */
            
            }else {
                print("二进制")
            }
            
            index += 1
        }
        
        // 执行SQL语句
        if sqlite3_step(stmt) != SQLITE_DONE {
            return false
        }
        
        // 关闭stmt
        sqlite3_finalize(stmt)
        
        return true
        
    }
    
    
    
    //执行sql语句,返回一个记录集合
    func execQuery(sql:String) -> [[String: AnyObject]]?{
    
        // 将 sql 转换成 C 语言的字符串
        let cSQL = sql.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        //设置数据库的操作句柄
        var stmt: COpaquePointer = nil
        //设置用于保存返回数据的数组
        var recordSet = [[String: AnyObject]]()

        if sqlite3_prepare_v2(db, cSQL, -1, &stmt, nil) == SQLITE_OK{
            print("准备就绪")
            // 查询 SELECT 的结果 step 单步执行
            // SQLITE_ROW 表示 step 有结果
            while sqlite3_step(stmt) == SQLITE_ROW {
                //获取每一行的数据信息
                let record = self.loadRecord(stmt)
                //将字典数据放到字典数组中
                recordSet.append(record)
            }
            //释放句柄
           sqlite3_finalize(stmt)
        }
        //循环完毕后返回字典数组
        return recordSet
    }
    
    //获取某一行的全部信息
    func loadRecord(stmt:COpaquePointer) -> [String: AnyObject] {
        //获得表的总列数
        let count = sqlite3_column_count(stmt)
        
        //创建字典用于保存表中的信息
        var record = [String: AnyObject]()
        
        //遍历表中的数据
        for col in 0..<count{
            //获得表中第col列的名称
            let cName = sqlite3_column_name(stmt, col)
            guard let name = String(CString: cName,encoding: NSUTF8StringEncoding) else{
                print("获取列名称失败")
                continue
            }
            
            //获得表中第col列的类型
            let type = sqlite3_column_type(stmt, col)
            print("name = \(name), type = \(type)")
            
            //根据type的类型,获得相应的查询内容
            switch type {
            case SQLITE_INTEGER:
                let intNumber = sqlite3_column_int64(stmt, col)
                record[name] = Int(intNumber)
            case SQLITE_FLOAT:
                let floatNumber = sqlite3_column_double(stmt, col)
                record[name] = Float(floatNumber)
            case SQLITE_TEXT:
                let cText = UnsafePointer<CChar>(sqlite3_column_text(stmt, col))
                let text = String(CString:cText, encoding: NSUTF8StringEncoding)
                record[name] = text
            case SQLITE_NULL:
                record[name] = NSNull()
            default:
                //SQLITE_BLOB是二进制数据,在数据库中一般不存储二进制数据
                print("不支持的类型")
            }
        }
        return record
    }
    
    
}
