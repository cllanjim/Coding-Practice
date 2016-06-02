//
//  HomeCellPictureCollectionView.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/29.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCellPictureCollectionView: UICollectionView {
    
    //模型数据
    var viewModel: StatusViewModel? {
        didSet{
            
        let (_, itemSize) = calculateSize()

            //判断item的size是否为0
            if itemSize != CGSizeZero{
                let layout = collectionViewLayout as! UICollectionViewFlowLayout
                layout.itemSize = itemSize
                layout.minimumInteritemSpacing = 10
                layout.minimumLineSpacing = 10
            }
            // 刷新表格
            reloadData()
        }
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        registerClass(HomePictureCell.self, forCellWithReuseIdentifier: HomePictureCell.identifer())
        
        backgroundColor = UIColor.clearColor()

        dataSource = self
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension HomeCellPictureCollectionView: UICollectionViewDelegate {
    //使用KVO机制,在点击该按钮的时候发送出通知
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let info: [String: AnyObject] = [
            "urls":viewModel!.large_urls!,
            "indexPath":indexPath
        ]
        
        NSNotificationCenter.defaultCenter().postNotificationName(SQShowBrowserNotification, object: self, userInfo: info)
    }
}

extension HomeCellPictureCollectionView {
    /*
     计算配图容器和cell的宽高
     
     - returns: 第一个是容器的宽高, 第二个是cell的宽高
     */
    func calculateSize() ->(CGSize, CGSize) {
        // 1.取出配图的个数
        let count = viewModel?.thumbnail_urls?.count ?? 0
        var col = 3
        var row = 3
        // cell宽度 = (屏幕宽度 - (列数 + 1) * 间隙) / 列数
        let screenWidth = Int(UIScreen.mainScreen().bounds.size.width) 
        let cellWidth = (screenWidth - (col + 1) * SQHomeCellMargin ) / col
        let cellHeight = cellWidth
        
        // 2.计算容器和cell的尺寸
        if count == 0 {
            return (CGSizeZero, CGSizeZero)
        }else if count == 1 {
            // 2.1判断是否是一张
            let key = viewModel!.thumbnail_urls!.first!.absoluteString
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
            let scale = UIScreen.mainScreen().nativeScale
            let width = image.size.width * scale
            let height = image.size.height * scale
            let size = CGSize(width: width, height: height)
            return (size, size)
        }else if  count == 4 {
            // 2.2判断是否是四张
            row = 2
            col = row
            // 宽度 = 列数 * cell宽度 + (列数- 1) * 间隙
            let width = col * cellWidth + (col - 1) * SQHomeCellMargin
            let height = width
            return(CGSize(width: width, height: height), CGSize(width: cellWidth, height: cellHeight))
        }else {
            // 2.3其它张(九宫格)
            col = 3
            row = (count - 1) / 3 + 1
            // 宽度 = 列数 * cell宽度 + (列数- 1) * 间隙
            let width = col * cellWidth + (col - 1) * SQHomeCellMargin
            let height = row * cellHeight + (row - 1) * SQHomeCellMargin
            
            return (CGSize(width: width, height: height), CGSize(width: cellWidth, height: cellHeight))
        }
        
    }
}


// MAKR: - 数据源方法
extension HomeCellPictureCollectionView: UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.thumbnail_urls?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HomePictureCell.identifer(), forIndexPath: indexPath) as! HomePictureCell
        
        cell.url = viewModel?.thumbnail_urls![indexPath.item]
        
        return cell
    }
}


class HomePictureCell: UICollectionViewCell {
    
    var url: NSURL? {
        didSet{
            imageView.sd_setImageWithURL(url)
        }
    }
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .ScaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //添加控件
        contentView.addSubview(imageView)
        //约束控件
        imageView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}