//
//  ViewController.swift
//  0503 FMDB的基本使用
//
//  Created by 张思琦 on 16/5/3.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import FMDB

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SQLiteManager.shareInstance
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

