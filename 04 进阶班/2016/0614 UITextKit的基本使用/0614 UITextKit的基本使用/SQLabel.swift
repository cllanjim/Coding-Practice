//
//  SQLabel.swift
//  0614 UITextKit的基本使用
//
//  Created by 张思琦 on 16/6/14.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class SQLabel: UILabel {
    //属性
    //用于存储需要显示的内容
    private lazy var storage = NSTextStorage()
    //用于存储需要显示内容的布局方式
    private lazy var layoutManager = NSLayoutManager()
    //用于存储需要显示内容的范围
    private lazy var container = NSTextContainer()

    override var text: String? {
        didSet{
            //设置内容
            storage.setAttributedString(NSAttributedString(string: text ?? ""))

            //匹配URL
            matchesAndHighlightedURL()
            
            //设置字体大小
            storage.addAttribute(NSFontAttributeName, value: self.font,range: NSMakeRange(0,text!.characters.count ))
            
            setNeedsDisplay()
        }
    }
    
    override func drawTextInRect(rect: CGRect) {
        
        layoutManager.drawGlyphsForGlyphRange(NSMakeRange(0, storage.string.characters.count), atPoint: CGPointZero)
    }
    
    
    //MARK: - 声明周期方法
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        storage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(container)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //设置显示范围
        container.size = bounds.size
    }
    
    
    private func matchesAndHighlightedURL() {
        // 1.创建一个探测器
        guard let detector = try? NSDataDetector(types: NSTextCheckingType.Link.rawValue) else {
            return
        }
        
        // 2.利用正则对象取出结果
        let array = detector.matchesInString(storage.string, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, storage.string.characters.count))
        
        // 3.遍历结果集数组, 取出结果
        for result in array {
            // 3.1取出匹配的URL
            let temp = (storage.string as NSString).substringWithRange(result.range)
            // 3.2根据取出结果创建一个熟悉字符串
            let attrStr = NSMutableAttributedString(string: temp)
            // 3.3设置熟悉字符串的颜色
            attrStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, temp.characters.count))
            // 3.4利用新生产的熟悉字符串替换以前的普通字符串
            storage.replaceCharactersInRange(result.range, withAttributedString: attrStr)
        }
    }
    
}
