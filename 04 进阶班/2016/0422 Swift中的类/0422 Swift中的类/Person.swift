//
//  Person.swift
//  0422 Swift中的类
//
//  Created by 张思琦 on 16/4/23.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class Person: NSObject {

    /*:
     存储属性和实例变量
     * Objective-C 为类实例存储值和引用值提供两种方法。除了属性之外，还可以使用实例变量作为属性值的后端存储
     * Swift 编程语言中把这些理论统一用属性来实现, 这就避免了不同场景下访问方式的困扰
     * Swift 中的属性没有对应的实例变量，属性的后端存储也无法直接访问
     */
    
    //实际上没有这种写法啦!!!
//    var _name : String = ""
//    var name : String {
//        set{
//            print("set" + newValue)
//            _name = newValue
//        }
//        get{
//            print("get" + _name)
//            return _name
//        }
//    }
    
    /*:
     存储属性
     * 具备存储功能, 和OC中普通属性一样
     */
    
    // 定义 "对象"属性可以使用?
    var name: String?
    
    // 定义 "基本数据类型" 最好赋初始值
    // Swift中基本数据类型设置为? , super.init()不会分配存储空间
    // 所以利用KVC赋值会报属性找不到
//    var age: Int?
    var age: Int = 0
    
    
    /*:
     计算属性
     * 计算属性不具备存储功能
     * 相当于OC中的readOnly (不完全一样)
     
     最常见的计算属性
     * 只有get没有set(只读计算属性)
     * 重写了set但没有给自身赋值也是计算属性
     
     注意
     * 必须使用var关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。
     * let关键字只用来声明常量属性，表示初始化后再也无法修改的值
     */
    
    //只有get没有set(只读计算属性)
    var score : Int {
        get{
            return 99
        }
    }
    
    //重写了set但没有给自身赋值也是计算属性
    var a : Int = -1
    var b : Int {
        set{
            a = newValue > 59 ? 60 : a
        }
        get{
            return a
        }
    }
    
    
    /*:
     属性观察器
     * 属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器
     * 类似于OC中的setter
     * 可以为除了`延迟存储属性`之外的其他存储属性添加属性观察器
     
     willSet
     * 在新的值被设置之前调用
     * willSet观察器会将新的属性值作为常量参数传入
     * 传入的参数默认名称newValue
     
     didSet
     * 在新的值被设置之后立即调用
     * didSet观察器会将旧的属性值作为参数传入
     * 传入参数默认参数名oldValue
     
     注意
     * 如果在一个属性的didSet观察器里为它赋值，这个值会替换之前设置的值
     */
    
    var myScore: Double = 0.0{
        willSet{
            print(score)
            // score被修改之前调用
            // 调用时会传入一个隐藏参数, newValue , 外界赋值的最新值
            print("即将设置新的值 \(newValue)")
        }
        didSet{ // 相当于OC中重写setter方法
            print(score)
            // score被修改之后调用
            // 调用时会传入一个隐藏参数, oldValue, score以前的值
            print("新值以及替代旧值 \(oldValue)")
        }
    }
    
    /*:
     构造函数
     * 构造过程是使用类、结构体或枚举类型的实例之前的准备过程
     * 与 Objective-C 中的构造器不同，Swift 的构造器无需返回值，
     * 它的主要任务是保证新实例在第一次使用前完成正确的初始化
     
     * Swift要求所有属性都必须在构造之前完成初始化
     * 如果说属性的值每次创建都是相同的, 那么可以使用默认值初始化
     * 如果说属性的值每次创建都不同, 那么可以使用构造方法初始化
     * 如果没办法保证在构造方法中初始化属性, 可以将属性变为可选类型
        例如字符串类型属性不进行初始化的话,在super.init()中会报错
     * 当提供了多个构造方法, 必须保证调用每一个构造方法都能够初始化所有的属性
     */
    override init() {
        // 如果属性每次都值都相同, 推荐使用默认属性
        self.name = ""
        self.age = 0
    }
    
    // 自定义构造方法 , 必须是init开头
    // 一旦自定义了init方法, 但是没有重写init方法, 默认的init方法就会失效
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    init(dict: [String: NSObject]) {
        // 注意: 在Swift的`构造方法`中使用KVC, 必须先调用super.init()
        // 目的是保证对象创建成功
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    
}



