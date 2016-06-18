//
//  ViewController.swift
//  0611 图片浏览器
//
//  Created by 张思琦 on 16/6/11.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var photoVC: PhotoCollectionViewController = PhotoCollectionViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addChildViewController(photoVC)
        view.addSubview(photoVC.view)
        
        photoVC.view.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

