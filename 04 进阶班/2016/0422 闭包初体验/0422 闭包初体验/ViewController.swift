//
//  ViewController.swift
//  0422 闭包初体验
//
//  Created by 张思琦 on 16/4/22.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
         闭包
         * 闭包是自包含的函数代码块，可以在代码中被传递和使用。Swift 中的闭包与 C 和 Objective-C 中的代码块（blocks）以及其他一些编程语言中的匿名函数比较相似
         * 闭包可以捕获和存储其所在上下文中任意常量和变量的引用。这就是所谓的闭合并包裹着这些常量和变量，俗称闭包
         * 闭包的使用和block一样, 用于保存一段代码, 用作回调, 用作执行耗时操作
         * 闭包格式: in关键字的目的是便于区分返回值和执行语句
         {
         (形参列表) -> 返回值类型
         in
         执行语句
         }
         */
        
        //定义一个参数为闭包的函数
        //注意dispatch_async(queue: dispatch_queue_t, block: dispatch_block_t)的第二个参数虽然写的是block,但实际上是一个闭包,因为没有^标识符
        func loadData0(finished: () -> ()) -> Void{
            dispatch_async(dispatch_get_global_queue(0, 0)) {
                print("子线程进行耗时操作,\(NSThread.currentThread())")
                
                dispatch_async(dispatch_get_main_queue(), {
                    print("主线程更新UI \(NSThread.currentThread())")
                    finished()
                })
            }
        }
        
        loadData0({
            ()->()
            in
            print("执行完毕")
        })
        
        
        //定义参数为NSString和闭包的函数
        func loadData1(name: String ,finished: (info:String) -> ()) -> Void{
            dispatch_async(dispatch_get_global_queue(0, 0)) {
                print("子线程进行耗时操作,\(NSThread.currentThread())")
                
                dispatch_async(dispatch_get_main_queue(), {
                    print("主线程更新UI \(NSThread.currentThread())")
                    finished(info: name)
                })
            }
        }
        
        loadData1("zsq") { (info) in
            print(info)
        }
        
        
        //闭包的常规写法
        loadData0 ({
            ()->()
            in
            print("Hello,World")
        })
        
        // 闭包的其它写法
        // 1.如果闭包是函数的最后一个参数, 那么可以把闭包写在调用函数的()后面
        // 这种写法, 我们称之为 "尾随闭包"
        loadData1("zsq"){
            (info)->()
            in
            print(info)
        }
        
        // 2.如果函数只接收一个参数, 并且这个参数是闭包, 那么调用函数的()可以省略
        // 这种写法, 我们称之为 "尾随闭包"
        loadData0{
            ()->()
            in
            print("Hello,World")
        }
        

        
        //如果闭包没有参数,没有返回值.in和in之前的内容可以省略
        loadData0({
            print("Hello,World")
        })
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    
}

