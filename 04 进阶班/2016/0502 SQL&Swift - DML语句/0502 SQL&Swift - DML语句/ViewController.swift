//
//  ViewController.swift
//  0502 SQL&Swift - DML语句
//
//  Created by 张思琦 on 16/5/2.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        //let person = Person(name:"zsq",age: 28)
        
//        //开启事务
//        SQLiteManager.sharedInstance.beginTransaction()
//        let start = CFAbsoluteTimeGetCurrent()
//        for i in 0..<10000{
//            let person = Person(name: "wcf +\(i)",age: 60)
//            person.insertPerson()
//        }
//        let end = CFAbsoluteTimeGetCurrent()
//        //提交事务
//        SQLiteManager.sharedInstance.commitTransaction()
//
//        print("耗时 \(end - start) 秒")
        Person.loadPerson()
        
        //
        SQLiteManager.sharedInstance.queueExec { (manager) in
            let sql = "INSERT INTO T_Person (name, age) VALUES ('lnj', 30);"
            manager.execSQL(sql)
        }
    }

}

