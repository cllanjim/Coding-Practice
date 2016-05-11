//
//  ViewController.swift
//  0428 SQL&Swift - DDL语句
//
//  Created by 张思琦 on 16/4/28.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        //利用runtime创建单例
//        let sqliteManager0 :SQLiteManager = SQLiteManager.sharedSQLiteManager()
//        let sqliteManager1 :SQLiteManager = SQLiteManager.sharedSQLiteManager()
//        let sqliteManager2 :SQLiteManager = SQLiteManager.sharedSQLiteManager()
//        let sqliteManager3 :SQLiteManager = SQLiteManager.sharedSQLiteManager()
        //利用static关键字创建单例
        let sqliteManager0 :SQLiteManager = SQLiteManager.shareInstance
//        let sqliteManager1 :SQLiteManager = SQLiteManager.shareInstance
//        let sqliteManager2 :SQLiteManager = SQLiteManager.shareInstance
//        let sqliteManager3 :SQLiteManager = SQLiteManager.shareInstance
        //打印对象
        print(sqliteManager0)
//        print(sqliteManager1)
//        print(sqliteManager2)
//        print(sqliteManager3)

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

