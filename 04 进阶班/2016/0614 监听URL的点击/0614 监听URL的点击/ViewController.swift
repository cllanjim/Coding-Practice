//
//  ViewController.swift
//  0614 监听URL的点击
//
//  Created by 张思琦 on 16/6/14.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customTextView: SQTextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let str = "@jack12:【动物尖叫合辑】http://t.cn/zYBuKZ8 、@南哥: 老鼠这么尖叫、兔子这么尖叫[吃惊]、@小码哥: 莫名奇#小笼包#妙的笑到最后[挖鼻屎]！"
        customTextView.text = str
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

