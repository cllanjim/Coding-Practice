//
//  Student.swift
//  0503 FMDB的基本使用
//
//  Created by 张思琦 on 16/5/4.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class Student: NSObject {
    //定义属性
    var name: String
    var age : Int
    
    //init不是函数,是什么玩意啊?
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    //添加学生数据
    func insertStudent() -> (){
        let sql = "INSERT INTO T_Student3(name, age)VALUES(?, ?);"
        SQLiteManager.shareInstance.db.executeUpdate(sql, withArgumentsInArray: [self.name, self.age])
    }
    
    //查询学生数据
    func loadAllStudent() -> (){
        //1 编写SQL语句
        let sql = "SELECT * FROM T_Student3;"

        //2 执行SQL语句
        let result = SQLiteManager.shareInstance.db.executeQuery(sql, withArgumentsInArray: nil)
        
        //3 处理查询的结果
        while result.next() {
            let id = result.intForColumn("id")
            let name = result.stringForColumn("name")
            let age = result.intForColumn("age")
            print("id = \(id), name = \(name), age = \(age)")
        }
        
        SQLiteManager.shareInstance.db.close()
    }


    
}
