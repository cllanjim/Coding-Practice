//
//  ViewController.swift
//  0422 闭包的循环引用
//
//  Created by 张思琦 on 16/4/22.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Swift中定义属性, 必须在构造方法中初始化, 否则就必须加上?
    // 注意: 以下写法代表闭包的返回值可以为nil
    // var finished: ()->()?
    var finished: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*:
         闭包循环强引用
         block
         * 闭包和block很像, 都是提前准备好代码, 在需要时执行
         * block会对外部变量进行强引用, 保证执行代码时变量还在
         * block中用到self一定要非常小心
         闭包
         * 闭包也一样, 会对外部变量进行强引用, 保证执行代码时变量还在
         * 如果您将闭包赋值给一个类实例的属性，并且该闭包通过访问该实例或其成员而捕获了该实例，您将创建一个在闭包和该实例间的循环强引用
         * Swift开发中能不写self就不写self, 一看到self就想到闭包
         */
    
        loadData({
            () -> ()
            in
            //使用下面的语句会产生循环引用
            self.view.backgroundColor = UIColor.redColor()
            print("如果循环引用就见不到'我滚了'这句话")
        })
        
        /*
         弱引用
         OC
         * __weak typeof(self) weakSelf = self
         * __unsafe_unretained typeof(self) weakSelf = self;
         Swift
         * Swift中同样提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题：弱引用（weak reference）和无主引用（unowned reference）
         * weak var weakSelf = self
         * unowned var weakSelf = self
         
         应用场景:
         * 对于生命周期中会变为nil的实例使用弱引用(weak)
         * 对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用(unowned)
         
         注意:
         * weak和unowned只能修饰对象类型, 因为只有对象类型才有引用计数
        */
        
        //解决方法----wake
        weak var weakSelf = self
        loadData({
            ()->()
            in
            weakSelf!.view.backgroundColor = UIColor.redColor()
            print("如果循环引用就见不到'我滚了'这句话")
        })
        
        //解决方案二----unowned
        unowned let unownedSelf = self
        loadData({
            ()->()
            in
            unownedSelf.view.backgroundColor = UIColor.redColor()
            print("如果循环引用就见不到'我滚了'这句话")
        })
        
        
        /*
        捕获列表
            * Swift 提供了一种优雅的方法来解决闭包导致的循环强引用，称之为闭包捕获列表（closuer capture list）
            * 调用时在闭包的参数列表前通过[]说明捕获列表
                * 例如: loadData { [weak self] () -> () in}
        注意
            * 和OC一样, 如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误
        */
        loadData({[unowned self]
            ()->()
            in
            self.view.backgroundColor = UIColor.redColor()
        })
        
        let demo:()->() = {[unowned self]
            ()->()
            in
            self.view.backgroundColor = UIColor.redColor()
        }
        
        loadData(demo)
    }
    
    //定义了一个参数是闭包的函数
    func loadData( finished:()->() ) -> Void{
        print("Hello,World")
        //保存闭包到finished属性中
        self.finished = finished
        finished()
    }

    
    /*:
     析构函数
     * 析构器只适用于类类型，当一个类的实例被释放之前，析构器会被立即调用
     * 类似于OC中的dealloc方法
     * 析构器是在实例释放发生前被自动调用。你不能主动调用析构器
     * 一般情况下, 当使用自己的资源时, 在析构函数中进行一些额外的清理
     * 例如，如果创建了一个自定义的类来打开一个文件，并写入一些数据，你可能需要在类实例被释放之前手动去关闭该文件
     */
    deinit{
        print("我滚了")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

