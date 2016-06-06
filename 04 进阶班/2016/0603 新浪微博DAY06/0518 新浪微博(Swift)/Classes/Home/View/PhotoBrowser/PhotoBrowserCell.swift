//
//  PhotoBrowserCell.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/6/3.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import SDWebImage

//MARK: - PhotoBrowserCell
class PhotoBrowserCell: UICollectionViewCell {
    
    //MARK: - 属性
    private lazy var scrollview: UIScrollView = {
        let sc = UIScrollView()
        sc.maximumZoomScale = 2.0
        sc.minimumZoomScale = 0.5
        sc.delegate = self
        return sc
    }()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .ScaleAspectFill
        return iv
    }()
    
    private lazy var activity = UIActivityIndicatorView(activityIndicatorStyle:.WhiteLarge)
    
    var url: NSURL? {
        didSet{
            
            activity.startAnimating()
            
            //由于循环利用的原因,需要重置cell
            self.resetCell()
            
            imageView.sd_setImageWithURL(url) { (image: UIImage!, error: NSError!, type: SDImageCacheType, url: NSURL!) in
                
                self.activity.stopAnimating()
                
                //获取图片在当前屏幕下的尺寸
                let size = self.getImageSize(image)
                //设置imageView的尺寸
                self.imageView.frame.size = size
                //设置imageView的位置
                self.setImageViewPosition()
            }
        }
    }
    
    //MARK: - 生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 内部控制方法
    private func setupUI() {
        //添加子控件
        contentView.addSubview(scrollview)
        contentView.addSubview(activity)
        scrollview.addSubview(imageView)
        
        //布局子控件
        scrollview.frame = self.bounds
        activity.center = contentView.center
    }
    
    private func resetCell() {
        imageView.transform = CGAffineTransformIdentity
        imageView.frame.origin = CGPointZero
        scrollview.contentSize = CGSizeZero
        scrollview.contentInset = UIEdgeInsetsZero
        scrollview.contentOffset = CGPointZero
    }
    
    //按照屏幕的尺寸缩放图片
    private func getImageSize(image: UIImage) -> CGSize {
        //获取手机的缩放比例
        let scale = UIScreen.mainScreen().nativeScale
        
        //获取下载图片的真实大小
        let imageWidth = image.size.width * scale
        let imageHeight = image.size.height * scale
        
        //获取按照屏幕比例缩放后的图片大小
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let screenHeight = screenWidth * (imageHeight / imageWidth)
        
        return CGSize(width: screenWidth, height: screenHeight)
    }
    
    //根据UIImageView的尺寸
    private func setImageViewPosition() {
        let screenHeight = UIScreen.mainScreen().bounds.size.height
        let imageViewSize = imageView.frame.size
        
        //判断图片的长度决定摆放位置
        if imageViewSize.height > screenHeight {
            self.scrollview.contentSize = imageViewSize
        }else {
            let offsetY = (screenHeight - imageViewSize.height) * 0.5
            self.scrollview.contentInset = UIEdgeInsets(top: offsetY, left: 0, bottom: offsetY, right: 0)
        }
    }
}

extension PhotoBrowserCell: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenHeight = UIScreen.mainScreen().bounds.height
        
        /*
         被缩放的图片本质上是通过transform缩放图片
         在整个缩放的过程中contentSize的值和frame值是一样的, 会随着图片大小的变化而变化
         而bounds从始至终都不会改变
         */
        // 1.计算边距
        var offsetY = (screenHeight - imageView.frame.height) * 0.5
        var offsetX = (screenWidth - imageView.frame.width) * 0.5
        
        // 2.调整边距
        offsetY = (offsetY < 0) ? 0 : offsetY
        offsetX = (offsetX < 0) ? 0 : offsetX
        
        // 3.设置边距
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: offsetY, right: offsetX)
    }
    
}

