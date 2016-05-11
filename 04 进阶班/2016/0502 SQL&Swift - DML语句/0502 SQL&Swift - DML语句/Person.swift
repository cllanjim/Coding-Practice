//
//  Person.swift
//  0502 SQL&Swift - DML语句
//
//  Created by 张思琦 on 16/5/2.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    var name: String?
    var age: Int = 0
    
    override init() {
        super.init()
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    
    func insertPerson() -> () {
        //获取SQLiteManager单例
        let manager = SQLiteManager.sharedInstance
        //编写SQL语句
        //let sql = "INSERT INTO T_Student3(name, age)VALUES('\(name)', '\(age)');"
        let sql = "INSERT INTO T_Student3(name, age)VALUES(?, ?);"
        //执行sql语句
        manager.execSQL(SQL:sql, Arguments: "wcf",60)
    }
    
    //使sqlite3_exec插入数据
    func insertPerson1() -> () {
        //获取SQLiteManager单例
        let manager = SQLiteManager.sharedInstance
        //编写SQL语句
        let sql = "INSERT INTO T_Student3(name, age)VALUES('\(name)', '\(age)');"
        //执行sql语句
        manager.execSQL(sql)
    }
    
    //使用参数绑定插入数据
    func insertPerson2() -> () {
        //获取SQLiteManager单例
        let manager = SQLiteManager.sharedInstance
        //编写SQL语句

        let sql = "INSERT INTO T_Student3(name, age)VALUES(?, ?);"
        //执行sql语句
        manager.execSQL(SQL:sql, Arguments: "wcf",60)
    }
    
    class func loadPerson() -> [Person]?{
        //1.编写SQL语句
        let sql = "SELECT * FROM T_Student3;"
        //2.执行查询语句并返回结果
        guard let array = SQLiteManager.sharedInstance.execQuery(sql) else{
            print("获取数据失败")
            return nil
        }
        //将字典数据转换为模型数据
        var models = [Person]()
        
        for dict in array {
            let stu = Person(name: "", age: 0)
            stu.name = dict["name"] as! String?
            stu.age = dict["age"] as! Int
            models.append(stu)
        }
        return models
    }
    
}
