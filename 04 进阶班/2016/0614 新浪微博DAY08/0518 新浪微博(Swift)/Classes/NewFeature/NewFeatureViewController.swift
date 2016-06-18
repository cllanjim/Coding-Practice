//
//  NewFeatureViewController.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/25.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import QorumLogs

class NewFeatureViewController: UICollectionViewController {
    
    private let NewFeatureCount = 4

    
    init() {
        //创建布局对象
        let layout = NewfeatureLayout()
        //初始化对象
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.registerClass(NewfeatureCell.self, forCellWithReuseIdentifier: NewfeatureCell.identifer())
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

extension NewFeatureViewController{
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier("newfeatureCell", forIndexPath: indexPath) as! NewfeatureCell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(NewfeatureCell.identifer(), forIndexPath: indexPath) as! NewfeatureCell
        
        cell.tag = indexPath.item
        cell.index = indexPath.item
        
        return cell
    }
}

extension NewFeatureViewController {
    /// 一个cell完全显示时调用
    // 当前方法确实可以监听cell是否完全显示,
    // 但是调用该方法时传入的cell和indexPath都不是当前显示的cell对应的数据
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        // 1.获取当前显示的cell对应的索引
        let path = collectionView.indexPathsForVisibleItems().last!
        
        // 2.显示最后一张图片时,执行button动画
        if path.item == NewFeatureCount - 1 {
            let cell = collectionView.cellForItemAtIndexPath(path) as! NewfeatureCell
            cell.showStartButton()
        }
        //注意：参数中的 cell & indexPath 是之前消失的cell，而不是当前显示的 cell 的
    }
}


class NewfeatureLayout: UICollectionViewFlowLayout {
    //准备布局
    override func prepareLayout() {
        super.prepareLayout()
        //1.设置布局对象属性
        itemSize = UIScreen.mainScreen().bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .Horizontal
        
        //2.设置CollectionView对象属性
        collectionView?.pagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.bounces = false
    }
}

class NewfeatureCell: UICollectionViewCell {
    
    var index: Int = 0 {
        didSet{
            let name = "new_feature_\(index + 1)"
            imageView.image = UIImage(named: name)
            
            startButton.hidden = true
            if index == 3 {
                startButton.hidden = false
            }
        }
    }
    
    
    // MAKR: - 生命周期方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 1.添加子控件
        contentView.addSubview(imageView)
        contentView.addSubview(startButton)
        
        // 2.布局子控件
        imageView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(0)
        }
        startButton.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(-200)
        }
        
        // 3.注册监听
        startButton.addTarget(self, action: #selector(NewfeatureCell.startBtnClick), forControlEvents: .TouchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MAKR: - 内部控制方法
    @objc private func startBtnClick() {
        //在执行完动画后,发出通知,且传递参数true,代表需要跳转到mainViewController
        NSNotificationCenter.defaultCenter().postNotificationName(SQChangeRootViewControllerNotification, object: true)
    }
    
    //按钮的提示动画
    private func showStartButton() {
        startButton.hidden = false
        startButton.userInteractionEnabled = false
        
        startButton.transform = CGAffineTransformMakeScale(0.0, 0.0)
        
        UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 30, options: UIViewAnimationOptions.init(rawValue: 0), animations: {
            self.startButton.transform = CGAffineTransformIdentity
        }) { (_) in
            self.startButton.userInteractionEnabled = true
        }
        
    }
    
    // MAKR: - 懒加载
    private lazy var imageView = UIImageView()
    private lazy var startButton = UIButton(imageName: "", backgroundImageName: "new_feature_button")
    
}