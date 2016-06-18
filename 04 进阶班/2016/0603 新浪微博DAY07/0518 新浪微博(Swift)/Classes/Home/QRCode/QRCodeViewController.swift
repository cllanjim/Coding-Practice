//
//  QRCodeViewController.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/20.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    //底部工具条
    @IBOutlet weak var customTabBar: UITabBar!
    //容器视图高度约束
    @IBOutlet weak var containerViewHeightCons: NSLayoutConstraint!
    //冲击波视图的顶部约束
    @IBOutlet weak var scanLineTopCons: NSLayoutConstraint!
    //冲击波视图
    @IBOutlet weak var scanLineView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        customTabBar.selectedItem = customTabBar.items?.first
        customTabBar.delegate = self

        setupQRCode()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
    }
    
    //MARK: - 动画
    func startAnimation() {
        //1.清空动画
        scanLineView.layer.removeAllAnimations()
        //2.设置动画起始位置
        scanLineTopCons.constant = -containerViewHeightCons.constant
        view.layoutIfNeeded()
        //3.开始动画
        UIView.animateWithDuration(1.5) { 
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanLineTopCons.constant = self.containerViewHeightCons.constant
            self.view.layoutIfNeeded()
        }
        
        
    }
    
    //MARK: - 监听方法
    @IBAction func photoBtnClick(sender: AnyObject) {
        //判断是否能够打开相片库
        if !UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum){
            return
        }
        //创建图片浏览器
        let picker = UIImagePickerController()
        picker.sourceType = .SavedPhotosAlbum
        picker.delegate = self
        
        presentViewController(picker, animated: true, completion: nil)
        
        
    }
    
    @IBAction func closeBtnClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    //MARK: - 懒加载
    //输入设备
    private lazy var inputDevice: AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        return try? AVCaptureDeviceInput(device: device)
    }()
    //输出设备
    private lazy var outputDevice: AVCaptureMetadataOutput = {
        //1创建输出对象
        let metadataOutput = AVCaptureMetadataOutput()
        //2获取容器视图的frame
        let containerFrame = self.containerView.frame
        let screenFrame = UIScreen.mainScreen().bounds
        
        //3计算x,y,宽,高比例
        let x = containerFrame.origin.y / screenFrame.size.height
        let y = containerFrame.origin.x / screenFrame.size.width
        let width = containerFrame.size.height / screenFrame.size.height
        let height = containerFrame.size.width / screenFrame.size.width
        
        //4设置解析数据感兴趣的区域
        metadataOutput.rectOfInterest = CGRect(x: x, y: y, width: width, height: height)
        
        //5返回输出对象
        return metadataOutput

    }()
    
    //会话对象
    private lazy var session = AVCaptureSession()
    
    //预览图层
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        return layer
    }()
    
    //添加专门用于保存描绘二维码边框的图层
    private lazy var containerLayer = CALayer()
}

//MARK: - 与图片识别相关
extension QRCodeViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //1取出图像数据
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        guard let ciImage = CIImage(image:image) else {
            return
        }
        
        //2创建探测器
        //设置分辨率
        let dict = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: dict)
        
        //3利用探测器探测结果
        let feature = detector.featuresInImage(ciImage)
        
        //4取出结果
        for result in feature{
            print((result as! CIQRCodeFeature).messageString)
        }

        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }
}


//MARK: - 与二维码扫描相关的方法
extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate{
    
    private func setupQRCode() {
        //1.判断输入是否能够添加到会话中
        if !session.canAddInput(inputDevice){
            return
        }
        //2.判断输出是否能够添加到会话中
        if !session.canAddOutput(outputDevice){
            return
        }
        //3.添加输入和输出到会话中
        session.addInput(inputDevice)
        session.addOutput(outputDevice)
        //4.设置输出对象能够解析的数据类型
        outputDevice.metadataObjectTypes = outputDevice.availableMetadataObjectTypes
        //5.设置代理监听解析后的数据
        outputDevice.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())

        
        //添加专门用于绘制二维码边框的图层
        containerLayer.frame = view.bounds
        containerLayer.backgroundColor = UIColor.clearColor().CGColor
        view.layer.insertSublayer(containerLayer, atIndex: 0)
        
        //6.设置预览界面
        //预览界面必须在绘制界面的下面
        previewLayer.frame = view.bounds
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        
        //7.开始扫描二维码
        session.startRunning()
    }
    
    // MAKR: - AVCaptureMetadataOutputObjectsDelegate
    /**
     当解析到扫描到的数据时就会调用
     所有扫描到的数据都存在在metadataObjects
     */
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        //1清空containerLayer中的线段
        cleaerContainerLayer()
        
        //2给二维码描边
        for objc in metadataObjects {
            drawCorners(objc)
        }
    }
    
    
    /**
     绘制描边
     
     - parameter objc: 扫描到的结果对象
     */
    private func drawCorners(objc: AnyObject?){
        
        
        //1.将metadataObjects中保存的数据进行转换
        let metadataObject = previewLayer.transformedMetadataObjectForMetadataObject(objc as! AVMetadataObject)
        
        //2.取出转换后的corner数据
        let cornersArray = (metadataObject as! AVMetadataMachineReadableCodeObject).corners
        print(cornersArray)
        
        // 3.生成绘制路径
        guard let path = createPath(cornersArray) else {
            print("失败?")
            return
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 3
        shapeLayer.strokeColor = UIColor.orangeColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.path = path.CGPath
        
        containerLayer.addSublayer(shapeLayer)
        
    }
    
    
    /**
     生成需要绘制路径
     
     - parameter corners: 坐标字典数组
     */
    private func createPath(corners: [AnyObject]?) -> UIBezierPath? {
        
        guard let cornersArray = corners where (cornersArray.count != 0) else {
            print("失败!")
            return nil
        }
        
        //3.遍历字典数据,将字典数据中的内容转换为CGPoint
        var index = 0
        var point = CGPointZero
        //取出字典中的数据
        CGPointMakeWithDictionaryRepresentation((cornersArray[index] as! CFDictionary), &point)
        index += 1
        
        let path = UIBezierPath()
        path.moveToPoint(point)
        
        while index < cornersArray.count {
            CGPointMakeWithDictionaryRepresentation((cornersArray[index] as! CFDictionary), &point)
            path.addLineToPoint(point)
            index += 1
        }
        path.closePath()
        
        return path
    }
    
    /**
     清空描边线段
     */
    private func cleaerContainerLayer() {
        // 清空以前的线段
        if let subLayers = containerLayer.sublayers {
            for layer in subLayers {
                layer.removeFromSuperlayer()
            }
        }
    }
}


extension QRCodeViewController: UITabBarDelegate {

    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if item.tag == 0 {
            containerViewHeightCons.constant = 300
        }else{
            containerViewHeightCons.constant = 150
        }
        
        // 重新开始动画
        startAnimation()
    }
    
}