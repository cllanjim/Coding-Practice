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
        
        //获取当前点击的cell
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! HomePictureCell
        // 取出当前点击图片的大图URL
        let url = viewModel?.large_urls![indexPath.item]
        
        //下载图片
        SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: { (current, total) in
            
                cell.imageView.progress = CGFloat(current) / CGFloat(total)
            
            }) { (_, _, _, _, _) in
                
                let info: [String: AnyObject] = [
                    "urls":self.viewModel!.large_urls!,
                    "indexPath":indexPath
                ]
                
                NSNotificationCenter.defaultCenter().postNotificationName(SQShowBrowserNotification, object: self, userInfo: info)
        }

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


// MAKR: - 动画代理
extension HomeCellPictureCollectionView: PhotoBrowserDelegate {
    // 获取一个和被点击cell一模一样的UIImageView
    func photoBrowserAnimationImage(path: NSIndexPath) -> UIImageView {
        // 1.取出被点击的cell
        let cell = cellForItemAtIndexPath(path) as! HomePictureCell
        // 2.拿到被点击cell上显示的图片
        let image = cell.imageView.image
        
        // 3.创建一个新的imageView
        let iv = UIImageView(image: image)
        iv.contentMode = .ScaleAspectFill
        iv.clipsToBounds = true
        
        // 4.返回imageView
        return iv
    }
    // 获取被点击cell相对于keywindow的frame
    func photoBrowserAnimationFromRect(path: NSIndexPath) -> CGRect {
        // 1.取出被点击的cell
        let cell = cellForItemAtIndexPath(path) as! HomePictureCell
        // 2.将被点击cell的坐标系从当前collectionView转换到keywindow
        let frame = convertRect(cell.frame, toCoordinateSpace: UIApplication.sharedApplication().keyWindow!)
        return frame
    }
    // 获取被点击cell中的图片, 将来在图片浏览器中显示的尺寸
    func photoBrowserAnimationToRect(path: NSIndexPath) -> CGRect {
        // 1.取出被点击的cell
        let cell = cellForItemAtIndexPath(path) as! HomePictureCell
        // 2.拿到被点击cell上显示的图片
        let image = cell.imageView.image!
        // 3.计算图片宽高比
        let screenWidth = UIScreen.mainScreen().bounds.width
        let screenheight = UIScreen.mainScreen().bounds.height
        let scale = image.size.height / image.size.width
        let height = scale * screenWidth
        
        if height > screenheight {
            return CGRect(x: 0, y: 0, width: screenWidth, height: height)
        }else {
            let offsetY = (screenheight - height) * 0.5
            return CGRect(x: 0, y: offsetY, width: screenWidth, height: height)
        }
        
    }
}


class HomePictureCell: UICollectionViewCell {
    
    var url: NSURL? {
        didSet{
            imageView.sd_setImageWithURL(url)
            
            if let temp: NSString = url?.absoluteString.lowercaseString {
                    gifImageView.hidden = !temp.pathExtension.hasSuffix("gif")
                }
        }
    }
    
    private lazy var imageView: SQProgressImageView = {
        let iv = SQProgressImageView(frame: CGRectZero)
        iv.contentMode = .ScaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var gifImageView: UIImageView = {
        UIImageView(image: UIImage(named: "gif_Identifier"))
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //添加控件
        contentView.addSubview(imageView)
        contentView.addSubview(gifImageView)
        
        //约束控件
        imageView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        gifImageView.snp_makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.right.equalTo(contentView.snp_right)
            make.bottom.equalTo(contentView.snp_bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


