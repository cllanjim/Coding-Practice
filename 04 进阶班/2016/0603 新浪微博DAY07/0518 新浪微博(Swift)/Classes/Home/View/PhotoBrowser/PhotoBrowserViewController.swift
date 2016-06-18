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


