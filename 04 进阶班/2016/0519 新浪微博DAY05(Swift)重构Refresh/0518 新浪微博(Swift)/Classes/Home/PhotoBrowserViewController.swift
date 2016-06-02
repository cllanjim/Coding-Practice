//
//  PhotoBrowserViewController.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/6/2.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class PhotoBrowserViewController: UIViewController {

    //MARK: - 属性
    var urls: [NSURL]
    
    var index: NSIndexPath
    
    private lazy var collectionView: UICollectionView = {
        //创建collectionView
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: PhototBrowserLayout())
        //注册collectionView中的cell
        collectionView.registerClass(PhotoBrowserCell.self, forCellWithReuseIdentifier: PhotoBrowserCell.identifer())
        //设置数据源和代理
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    //关闭按钮
    private lazy var closeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("关闭", forState: .Normal)
        btn.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        return btn
    }()
    
    //保存按钮
    private lazy var saveButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("保存", forState: .Normal)
        btn.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        return btn
    }()
    
    //MARK: - 构造方法
    init(urls: [NSURL], index: NSIndexPath) {
        self.urls = urls
        self.index = index
        
        super.init(nibName: nil,bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // 该方法会在控件布局完毕之后调用
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.scrollToItemAtIndexPath(index, atScrollPosition: .Left, animated: false)
    }
    
    //MARK: - 内部控制方法
    func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(closeButton)
        view.addSubview(saveButton)
        
        closeButton.addTarget(self, action: #selector(PhotoBrowserViewController.closeBtnClick), forControlEvents: .TouchUpInside)
        saveButton.addTarget(self, action: #selector(PhotoBrowserViewController.saveBtnClick), forControlEvents: .TouchUpInside)
        
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        closeButton.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.left.equalTo(view.snp_left).offset(20)
            make.bottom.equalTo(view.snp_bottom).offset(-20)
        }
        saveButton.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.right.equalTo(view.snp_right).offset(-20)
            make.bottom.equalTo(view.snp_bottom).offset(-20)
        }
    }
    
    @objc private func closeBtnClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @objc private func saveBtnClick() {
        print("Save")
    }
    
}

//MARK: - PhotoBrowserViewController的数据源方法
extension PhotoBrowserViewController: UICollectionViewDataSource{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserCell.identifer(), forIndexPath: indexPath) as! PhotoBrowserCell
        
        cell.url = urls[indexPath.item]
        
        return cell
    }
}

//MARK: - PhotoBrowserViewController的代理方法
extension PhotoBrowserViewController: UICollectionViewDelegate{
    
}

//MARK: - PhototBrowserLayout
class PhototBrowserLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        
        itemSize = UIScreen.mainScreen().bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .Horizontal
        
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.bounces = false
    }
}

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
    
    var url: NSURL? {
        didSet{
            
            //由于循环利用的原因,需要重置cell
            self.resetCell()
            
            imageView.sd_setImageWithURL(url) { (image: UIImage!, error: NSError!, type: SDImageCacheType, url: NSURL!) in
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
        scrollview.addSubview(imageView)
        //布局子控件
        scrollview.frame = self.bounds
    }
    
    private func resetCell() {
        imageView.transform = CGAffineTransformIdentity
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

