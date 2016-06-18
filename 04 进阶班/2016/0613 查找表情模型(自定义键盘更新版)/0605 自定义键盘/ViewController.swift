//
//  ViewController.swift
//  0605 自定义键盘
//
//  Created by 张思琦 on 16/6/5.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: SQKeyboardEmoticonTextView!
    
    @IBOutlet weak var publish: UIButton!
    
    private lazy var customKeyboardView: SQKeyBoardViewController = SQKeyBoardViewController { [unowned self] (emoticon) in
        self.textView.insertEmoticon(emoticon)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewController(customKeyboardView)
        textView.inputView = customKeyboardView.view
        
        textView.alwaysBounceVertical = true
        textView.keyboardDismissMode = .OnDrag
        
        
        let str = "@jack12:【动物尖叫合辑】#肥猪流#猫头鹰这么尖叫[偷笑]、@南哥: 老鼠这么尖叫、兔子这么尖叫[吃惊]、@小码哥: 莫名奇#小笼包#妙的笑到最后[好爱哦]！~ http://t.cn/zYBuKZ8"

        textView.attributedText = SQKeyBoardEmoticonPackage().attributedStringWithString(str)
        
        
    }

    @IBAction func publishBtnClick(sender: AnyObject) {
        let result = textView.emoticonString()
        print(result)
    }

    

    

    
    
}

