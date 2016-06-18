//
//  ViewController.swift
//  0613 正则表达式的基本使用
//
//  Created by 张思琦 on 16/6/13.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*
         判断字符串中没有没QQ
         1.必须全部都是数字
         2.不能以0开头
         3.必须是5~15
         */
        let str = "abc12345def"
        let result = searchQQ(str)
        print(result)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func searchQQ(str: String) -> Bool {
        //1.编写规则
        // []匹配一位
        // {}重复多次
        let pattern = "[1-9][0-9]{4-14}"
    
        //2.利用规则创建正则表达式对象
        guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions(rawValue: 0)) else {
            return false
        }
        
        //3.利用正则表达式对象匹配数据
        /*
         利用正则表达式匹配数据的四种方法
         
         返回匹配规则的字符串的个数
         public func numberOfMatchesInString(string: String, options: NSMatchingOptions, range: NSRange) -> Int
         
         返回第一个匹配规则的子串的范围
         public func rangeOfFirstMatchInString(string: String, options: NSMatchingOptions, range: NSRange) -> NSRange
         
         返回第一个匹配规则的子串的结果集(包含范围)
         public func firstMatchInString(string: String, options: NSMatchingOptions, range: NSRange) -> NSTextCheckingResult?
         
         返回所有匹配规则的子串的结果集数组
         public func matchesInString(string: String, options: NSMatchingOptions, range: NSRange) -> [NSTextCheckingResult]
         */
        
        
        let number = regex.numberOfMatchesInString(str, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
        
        return (number > 0)
    
    }

}

