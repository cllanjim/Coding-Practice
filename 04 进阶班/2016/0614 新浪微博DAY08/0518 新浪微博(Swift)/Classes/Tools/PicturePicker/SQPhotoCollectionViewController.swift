//
//  PhotoCollectionViewController.swift
//  0611 图片浏览器
//
//  Created by 张思琦 on 16/6/11.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCollectionViewCell"
// cell之间的间隙
private let photoCellMargin: Int = 10
// cell最大列数
private let photoCellMaxCol: Int = 3


class SQPhotoCollectionViewController: UICollectionViewController {
    //
    lazy var groupOfImages = [UIImage]()
    
    //MARK: - 生命周期的相关方法
    init(){
        super.init(collectionViewLayout: PhotoFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.registerClass(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.backgroundColor = UIColor.darkGrayColor()
    }
}

extension SQPhotoCollectionViewController {
    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupOfImages.count + 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCollectionViewCell
        cell.image = (indexPath.item < groupOfImages.count) ? groupOfImages[indexPath.item] : nil
        return cell
    }
}

extension SQPhotoCollectionViewController {
    // MARK: UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! PhotoCollectionViewCell
        
        //如果当前cell是最后一个加号按钮
        if cell.closeBtn.hidden == true {
            //当前是最后一个加号按钮,不显示关闭按钮
            //判断资源是否可以打开
            if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
                return
            }
            
            //创建Picker
            let pickerVC = UIImagePickerController()
            //设置picker的类型
            pickerVC.sourceType = .PhotoLibrary
            pickerVC.delegate = self
            
            //弹出pickerViewController
            presentViewController(pickerVC, animated: true, completion: nil)
            
        }else {
            //当前是图片按钮,显示关闭按钮
            groupOfImages.removeAtIndex(indexPath.item)
            collectionView.reloadData()
        }
    }
}

extension SQPhotoCollectionViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //1 取出图片
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        //2 将图片添加到groupOfImages数组中
        //groupOfImages.append(image)
        let newImage = scaleImage(image, width: 200)
        groupOfImages.append(newImage)
        
        //3 刷新表格
        collectionView?.reloadData()
        //4 关闭picker
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /**
     缩放图片
     
     - parameter image: 需要缩放的图片
     - parameter width: 图片缩放之后的宽度
     */
    private func scaleImage(image: UIImage, width: CGFloat) -> UIImage {
        
        // 1.创建图片上下文
        UIGraphicsBeginImageContext(CGSize(width: width, height: width))
        // 2.绘制图片
        image.drawInRect(CGRect(origin: CGPointZero, size: CGSize(width: width, height: width)))
        // 3.从上下文中取出图片
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


class PhotoCollectionViewCell: UICollectionViewCell {
    private lazy var photoBtn: UIButton = {
        let btn = UIButton()
        btn.userInteractionEnabled = false
        btn.setBackgroundImage(UIImage(named: "compose_pic_add"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "compose_pic_add_highlighted"), forState: .Highlighted)
        return btn
    }()

    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.userInteractionEnabled = false
        btn.setBackgroundImage(UIImage(named: "compose_photo_close"), forState: .Normal)
        btn.hidden = true
        btn.sizeToFit()
        return btn
    }()

    var image: UIImage? {
        didSet {
            if image == nil {
                //如果没有图片数据,就设置为加号
                closeBtn.hidden = true
                photoBtn.setBackgroundImage(UIImage(named: "compose_pic_add"), forState: .Normal)
                photoBtn.setBackgroundImage(UIImage(named: "compose_pic_add_highlighted"), forState: .Highlighted)
            }else {
                //如果有图片数据就设置图片数据
                closeBtn.hidden = false
                photoBtn.setBackgroundImage(image, forState: .Normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //1添加子控件
        contentView.addSubview(photoBtn)
        contentView.addSubview(closeBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoBtn.frame = bounds
        closeBtn.frame.origin.x = (bounds.width - closeBtn.bounds.width)
    }
}


class PhotoFlowLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        super.prepareLayout()
        
        //计算cell的宽高
        let itemWidth = (Int(UIScreen.mainScreen().bounds.width) - (photoCellMaxCol + 1) * photoCellMargin) / photoCellMaxCol
        let itemHeight = itemWidth
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        minimumLineSpacing = CGFloat(photoCellMargin)
        minimumInteritemSpacing = CGFloat(photoCellMargin)
        collectionView?.contentInset = UIEdgeInsetsMake(CGFloat(photoCellMargin), CGFloat(photoCellMargin), CGFloat(photoCellMargin), CGFloat(photoCellMargin))
    }
}


