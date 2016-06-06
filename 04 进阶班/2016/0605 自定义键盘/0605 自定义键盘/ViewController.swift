//
//  ViewController.swift
//  0605 自定义键盘
//
//  Created by 张思琦 on 16/6/5.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    private lazy var customKeyboardView: SQKeyBoardViewController = SQKeyBoardViewController()
    
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


}

