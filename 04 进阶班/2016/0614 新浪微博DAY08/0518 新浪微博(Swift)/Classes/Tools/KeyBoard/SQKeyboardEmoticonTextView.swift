//
//  SQKeyboardEmoticonTextView.swift
//  0605 自定义键盘
//
//  Created by 张思琦 on 16/6/8.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class SQKeyboardEmoticonTextView: UITextView {
    /**
     插入表情
     
     - parameter emoticon: 需要插入的表情模型
     */
    func insertEmoticon(emoticon: SQKeyBoardEmoticonModel) {
        // 0.判断是否是删除按钮
        if emoticon.isRemoveButton {
            deleteBackward()
            return
        }
        
        // 1.判断是否是emoji表情
        if let temp = emoticon.emojiStr where temp != "\0" {
            // 1.1获取当前光标所在的位置
            let selectRange = selectedTextRange!
            // 1.2利用表情字符串替换光标所在位置
            replaceRange(selectRange, withText: temp)
            return
        }
        
        // 2.判断是否是图片表情
        if let imagePath = emoticon.imagePath {
            //0 根据现有的内容生成一个属性字符串
            let attributedStrM = NSMutableAttributedString(attributedString: attributedText)
            //1 创建图片附件
            let attachMent = SQKeyboardEmoticonAttachment()
            attachMent.image = UIImage(contentsOfFile: imagePath)
            attachMent.chs = emoticon.chs
            //获取文字的一般高度
            let height = font!.lineHeight
            attachMent.bounds = CGRect(x: 0, y: -4, width: height, height: height)
            //2 根据附件创建一个属性字符串
            let attributedStrFromAttachment = NSAttributedString(attachment: attachMent)
            //3 将创建的属性字符串插入到光标所在位置
            let range = selectedRange
            attributedStrM.replaceCharactersInRange(range, withAttributedString: attributedStrFromAttachment)
            //4 重新设置文字的大小
            attributedStrM.addAttribute(NSFontAttributeName, value: font!, range: NSMakeRange(range.location, 1))
            //5 重新设置textView的属性字符串
            attributedText = attributedStrM
            //6 还原光标所在的位置
            selectedRange = NSMakeRange(range.location + 1, 0)
        }
    }

    
    
    /**
     获取属性字符串对应的文本字符串
     
     - returns: 文本字符串
     */
    func emoticonString() -> String {
        //用于保存将要发送的字符串
        var attributedStrM = ""
        //遍历当前textView中的字符串内容
        attributedText.enumerateAttributesInRange(NSMakeRange(0, attributedText.length), options: NSAttributedStringEnumerationOptions(rawValue: 0)) { (dict, range, _) in
            
            //判断是否是图片表情
            if dict["NSAttachment"] != nil {
                //1.取出当前表情字符串的附件模型
                let attachment = dict["NSAttachment"] as! SQKeyboardEmoticonAttachment
                //2.取出附件模型中字符串
                attributedStrM += attachment.chs ?? ""
            }else {
                // 取出当前遍历的字符串
                let str: NSString = self.attributedText.string
                // 添加遍历的字符串到输出字符串中
                attributedStrM += str.substringWithRange(range)
            }
        }
        return attributedStrM
    }
}
