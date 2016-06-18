//
//  SQKeyboardEmoticonAttachment.swift
//  0605 自定义键盘
//
//  Created by 张思琦 on 16/6/8.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class SQKeyboardEmoticonAttachment: NSTextAttachment {

    // 保存当前附件对应的字符串
    var chs: String?
 
    
    class func attributedStringWithEmoticonModel(emoticon: SQKeyBoardEmoticonModel, font: UIFont) -> NSAttributedString {
        //1 创建一个附件
        let attachment = SQKeyboardEmoticonAttachment()
        //2 为附件赋值
        attachment.image = UIImage(contentsOfFile: emoticon.imagePath ?? "")
        attachment.chs = emoticon.chs
        //3设置附件的bounds
        let height = font.lineHeight
        attachment.bounds = CGRect(x: 0, y: -4, width: height, height: height)
        
        //4根据附件创建一个属性字符串
        return NSAttributedString(attachment: attachment)
    }
    
}
