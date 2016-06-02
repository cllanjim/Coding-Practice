//
//  QRCodeCardViewController.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/22.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class QRCodeCardViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //1创建滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        //2还原滤镜
        filter?.setDefaults()
        
        //3设置数据
        let data = "七叔".dataUsingEncoding(NSUTF8StringEncoding)
        filter?.setValue(data, forKey: "inputMessage")
        
        //4从滤镜中取出数据
        guard var ciImage = filter?.outputImage else {
            return
        }
        
        //5设置图片清晰度
        let transform = CGAffineTransformMakeScale(10, 10)
        ciImage = ciImage.imageByApplyingTransform(transform)
        
        //6设置图片
        let image = UIImage(CIImage: ciImage)
        imageView.image = image
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
