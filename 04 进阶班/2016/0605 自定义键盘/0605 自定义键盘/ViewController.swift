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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func publishBtnClick(sender: AnyObject) {
        let result = textView.emoticonString()
        print(result)
    }

}

