//
//  ViewController.swift
//  0423 swift中的懒加载
//
//  Created by 张思琦 on 16/4/23.
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

    /*:
     延迟存储属性
     * 延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用lazy来标示一个延迟存储属性
     最常见的延迟存储属性
     * 执行某个方法返回处理好的数据
     * 执行某个闭包返回处理好的数据
     注意
     * 必须将延迟存储属性声明成变量（使用var关键字），因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性。
     * 如果一个被标记为lazy的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次
     */
    
    //执行某个方法处理好的数据
    //定义一个返回值为Array的函数
    func test0() -> Array<String> {
        print("执行了")
        return ["lmj", "lnj", "zs"]
    }
    
    func test1() -> [String] {
        print("执行了")
        return ["lmj", "lnj", "zs"]
    }
    
    lazy var listData0 : Array<String> = self.test0()
    lazy var listData1 : [String] = self.test1()
    lazy var listDate2 : Array<String> = {
        () -> Array<String>
        in
        return ["lmj", "lnj", "zs"]
    }()
    
//    let myArray0 : Array
//    let myArray1 : Array<String>
//    let myArray2 : [String]
    
    //执行某个闭包返回处理好的数据
    //推荐写法
    lazy var listData3 : [String] = {
        return ["zsq","sq"]
    }()
    
    //完整的写法
    lazy var listData4 : [String] = {
        () -> [String]
        in
        return ["zsq","sq"]
    }()
    
    //奇怪的写法
    lazy var listData5 = {
        () -> [String]
        in
        return ["zsq","sq"]
    }()
    

}

