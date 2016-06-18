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
        /**************** 方法二 ****************/
        //1 获取当前表情所在的文件夹名称
        guard let dirName = id else {
            return nil
        }

        //2 获取图片名称
        guard let pictureName = png else {
            return nil
        }

        //3 获取文件夹和图片的相对路径
        let path = dirName + "/" +  pictureName
        //print(path)

        //4 生成当前表情所在的绝对路径
        var filePath = NSBundle.mainBundle().pathForResource("emoticons.plist", ofType: nil, inDirectory: "Emoticons.bundle")
        filePath = (filePath! as NSString).stringByDeletingLastPathComponent
        filePath = (filePath! as NSString).stringByAppendingPathComponent(path)
        
        //print(filePath)

        
        return filePath
        
        /**************** 方法一 ****************/
        //        //1 获取当前表情所在的文件夹名称
        //        guard let dirName = id else {
        //            return nil
        //        }
        //
        //        //2 获取文件夹所在路径
        //        guard let path: NSString = NSBundle.mainBundle().pathForResource(dirName, ofType: nil, inDirectory: "Emoticons.bundle") else {
        //            return nil
        //        }
        //        //3 返回拼接后的字符串
        //        return path.stringByAppendingPathComponent(png ?? "")
        /**************************************/
        
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
