//
//  ViewController.swift
//  0613 匹配微博表情文本
//
//  Created by 张思琦 on 16/6/13.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let str = "@jack12:【动物尖叫合辑】#肥猪流#猫头鹰这么尖叫[偷笑]、@南哥: 老鼠这么尖叫、兔子这么尖叫[吃惊]、@小码哥: 莫名奇#小笼包#妙的笑到最后[挖鼻屎]！~ http://t.cn/zYBuKZ8"
        
        guard let detector = try? NSDataDetector(types: NSTextCheckingType.Link.rawValue) else {
            return
        }
        
        let array = detector.matchesInString(str, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
        
        for result in array {
            let temp = (str as NSString).substringWithRange(result.range)
            print(temp)
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func text() {
        let str = "@jack12:【动物尖叫合辑】#肥猪流#猫头鹰这么尖叫[偷笑]、@南哥: 老鼠这么尖叫、兔子这么尖叫[吃惊]、@小码哥: 莫名奇#小笼包#妙的笑到最后[挖鼻屎]！~ http://t.cn/zYBuKZ8"
        
        
        //1 编写规则
        //搜索表情
        let pattern1 = "\\[\\w+\\]"
        //搜索微博ID
        let pattern2 = "@\\w+"
        //搜索话题
        let pattern3 = "#\\w+#"
        //搜索URL
        let pattern4 =  "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?"
        
        let pattern = pattern1 + "|" + pattern2 + "|" + pattern3 + "|" + pattern4
        
        
        //2 创建符合规则的正则表达式
        guard let regex = try? NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions(rawValue: 0)) else {
            return
        }
        
        //3 利用正则表达式取出对应的结果
        let array = regex.matchesInString(str, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
        
        
        //遍历结果集
        for result: NSTextCheckingResult in array {
            let temp = (str as NSString).substringWithRange(result.range)
            print(temp)
        }

        
        
    }
    

}

