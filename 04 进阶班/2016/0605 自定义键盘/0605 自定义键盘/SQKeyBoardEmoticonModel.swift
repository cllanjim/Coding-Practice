//
//  SQKeyBoardEmoticonModel.swift
//  0605 自定义键盘
//
//  Created by 张思琦 on 16/6/5.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class SQKeyBoardEmoticonModel: NSObject {

    // 当前表情对应的文件夹名称
    var id: String?
    
    // 当前表情对应的字符串
    var chs: String?
    
    // 当前表情对应的图片
    var png: String?
    
    // 生成当前表情图片的绝对路径
    var imagePath: String? {
        
        //1 获取当前表情所在的文件夹名称
        guard let dirName = id else {
            return nil
        }
        //2 生成当前表情所在的文件夹路径
        guard let path: NSString = NSBundle.mainBundle().pathForResource(dirName, ofType: nil, inDirectory: "Emoticons.bundle") else {
            return nil
        }
        //返回拼接后的字符串
        return path.stringByAppendingPathComponent(png ?? "")
    }
    
    // Emoji表情对应的字符串
    var code: String?
    
    // Emoji表情处理之后的字符串
    var emojiStr: String? {
        // 1.创建一个扫描器
        let scanner = NSScanner(string: code ?? "")
        // 2.利用扫描器从字符串中扫描出十六进制数
        var result: UInt32 = 0
        scanner.scanHexInt(&result)
        // 3.利用扫描出来的结果创建一个字符/字符串
        let ch = Character(UnicodeScalar(result))
        // 4.显示字符/ 字符串
        return "\(ch)"
    }
    
    //  记录是否是删除表情
    var isRemoveButton = false
    
    // 记录当前表情使用的次数
    var count: Int = 0
    
    
    init(isRemoveButton: Bool) {
        self.isRemoveButton = isRemoveButton
    }
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
