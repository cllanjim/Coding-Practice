//
//  ViewController.swift
//  0422 Swift中的类
//
//  Created by 张思琦 on 16/4/22.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //奇怪的东西
        let zsq:Person = Person()
        zsq.name = "zsq"
        print(zsq.name)
        
        //存储属性----对象属性
        zsq.myName = "sq"
        
        if let string0 = zsq.myName {
            print("存储属性----对象属性" + string0)
        }
        //存储属性----基本类型
        let string1 : String = String(format: "计算属性----重写get方法 %d", zsq.age)
        print(string1)
        
        //计算属性----重写get方法
        let string2 : String = String(format: "计算属性----重写get方法 %d", zsq.score)
        print(string2)
        //计算属性----重写set方法
        zsq.b = 80
        print(zsq.b)
        print(zsq.a)

       
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

