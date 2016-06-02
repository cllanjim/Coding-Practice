//
//  HomeTableViewCell.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/26.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import QorumLogs

class HomeTableViewCell: UITableViewCell {
//    let margin = 10
    
    //MARK: - 设置基本属性
    var viewModel: StatusViewModel? {
        didSet{
            //设置数据
            // 1.设置头像
//            iconImageView.sd_setImageWithURL(viewModel?.avatarURL)
//            verifiedImageView.image = viewModel?.verifiedImage
//            nameLabel.text = viewModel?.screenNameStr
//            vipImageView.image = viewModel?.vipImage
//            timeLabel.text = viewModel?.timeStr
//            sourceLabel.text = viewModel?.sourceStr
            topView.viewModel = viewModel
            
            contentTextLabel.text = viewModel?.contentStr
            
            pictureCollectionView.viewModel = viewModel
            
            
            //计算CollectionView的size和内部item的size
            let (clvSize, _) = pictureCollectionView.calculateSize()
            //设置相关属性
            pictureCollectionView.snp_updateConstraints { (make) -> Void in
                make.width.equalTo(clvSize.width)
                make.height.equalTo(clvSize.height)
            }
//            //判断item的size是否为0
//            if itemSize != CGSizeZero{
//                let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//                layout.itemSize = itemSize
//                layout.minimumInteritemSpacing = 10
//                layout.minimumLineSpacing = 10
//            }
//            // 8.4刷新表格
//            collectionView.reloadData()
            
        }
    }
    
    //MARK: - 懒加载
//    /// 头像
//    private lazy var iconImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
//    /// 认证图标
//    private lazy var verifiedImageView = UIImageView(image: UIImage(named: "avatar_vip"))
//    /// 昵称
//    private lazy var nameLabel = UILabel(text: "小码哥", color: UIColor.orangeColor(), screenInset: 0)
//    
//    /// 会员图标
//    private lazy var vipImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
//    
//    /// 时间
//    private lazy var timeLabel = UILabel(text: "刚刚", color: UIColor.orangeColor(), screenInset: 0)
//    /// 来源
//    private lazy var sourceLabel = UILabel(text: "来自: 小码哥", color: UIColor.lightGrayColor(), screenInset: 0)
    
    private lazy var topView: HomeCellTopView = HomeCellTopView()
    
    // 正文
    private lazy var contentTextLabel =  UILabel(text: "", color: UIColor.darkGrayColor(), screenInset: CGFloat(SQHomeCellMargin))
    // 创建collectionView
//    private lazy var pictureCollectionView: HomeCellPictureCollectionView = {
//        let pictureCV = HomeCellPictureCollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
//        pictureCV.registerClass(HomePictureCell.self, forCellWithReuseIdentifier: "pictureCell")
//        pictureCV.backgroundColor = UIColor.darkGrayColor()
//        return pictureCV
//        
//    }()
      private lazy var pictureCollectionView: HomeCellPictureCollectionView = HomeCellPictureCollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    
//    // 转发按钮
//    private lazy var retweetButton = UIButton(title: "转发", imageName: "timeline_icon_retweet", backgroundImageName: "timeline_card_bottom_background")
//    // 评论按钮
//    private lazy var commentButton = UIButton(title: "评论", imageName: "timeline_icon_comment", backgroundImageName: "timeline_card_bottom_background")
//    // 赞按钮
//    private lazy var unlikeButton = UIButton(title: "赞", imageName: "timeline_icon_unlike", backgroundImageName: "timeline_card_bottom_background")
    // 底部工具条
    private lazy var bottomView: HomeCellBottomView = HomeCellBottomView()
//        {
//        let view = UIView()
//        view.backgroundColor = UIColor.orangeColor()
//        return view
//    }()
    // 配图
//    private lazy var collectionView: UICollectionView = {
//        
//        let clv = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
//    
//        //clv.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "pictureCell")
//        clv.registerClass(HomePictureCell.self, forCellWithReuseIdentifier: "pictureCell")
//        
//        clv.dataSource = self
//        
//        return clv
//
//    }()
    
    
    
    //MARK: - 构造方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 生命周期相关
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {

        // Configure the view for the selected state
    }

    //MARK: - 外部控制方法
    func rowHeight(viewModel: StatusViewModel) -> CGFloat {
        //1.设置数据
        self.viewModel = viewModel
        //2.更新布局
        layoutIfNeeded()
        //3.返回行高
        return CGRectGetMaxY(bottomView.frame)
        
    }
    
    
    //MARK: - 设置UI界面
    func setupUI() {
        //1 添加子控件
//        contentView.addSubview(iconImageView)
//        contentView.addSubview(verifiedImageView)
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(vipImageView)
//        contentView.addSubview(timeLabel)
//        contentView.addSubview(sourceLabel)

//        contentView.addSubview(collectionView)
//        bottomView.addSubview(retweetButton)
//        bottomView.addSubview(commentButton)
//        bottomView.addSubview(unlikeButton)
       
        contentView.addSubview(topView)
        contentView.addSubview(contentTextLabel)
        contentView.addSubview(pictureCollectionView)
        contentView.addSubview(bottomView)
        
        topView.snp_makeConstraints { (make) in
            make.top.equalTo(contentView.snp_top).offset(SQHomeCellMargin)
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.height.equalTo(SQHomeCellIconWidth)
        }
        
        contentTextLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentView.snp_left).offset(SQHomeCellMargin)
            make.top.equalTo(topView.snp_bottom).offset(SQHomeCellMargin)
        }
        
        pictureCollectionView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentView.snp_left).offset(SQHomeCellMargin)
            make.top.equalTo(contentTextLabel.snp_bottom).offset(SQHomeCellMargin)
        }
        // 2.8底部工具条
        bottomView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.height.equalTo(44)
            make.top.equalTo(pictureCollectionView.snp_bottom).offset(SQHomeCellMargin)
        
        //2 布局子控件
//        iconImageView.snp_makeConstraints { (make) in
//            make.left.equalTo(contentView.snp_left).offset(10)
//            make.top.equalTo(contentView.snp_top).offset(10)
//            make.width.equalTo(50)
//            make.height.equalTo(50)
//        }
//        iconImageView.layer.cornerRadius = 25
//        iconImageView.layer.masksToBounds = true
//
//        verifiedImageView.snp_makeConstraints { (make) in
//            make.right.equalTo(iconImageView.snp_right)
//            make.bottom.equalTo(iconImageView.snp_bottom)
////            make.width.equalTo(10)
////            make.height.equalTo(10)
//        }
//        
//        nameLabel.snp_makeConstraints { (make) in
//            make.top.equalTo(iconImageView.snp_top)
//            make.left.equalTo(iconImageView.snp_right).offset(10)
//            //缺少size的计算
////            make.height.equalTo(10)
//
//        }
//        
//        vipImageView.snp_makeConstraints { (make) in
//            make.centerY.equalTo(nameLabel.snp_centerY)
//            make.left.equalTo(nameLabel.snp_right).offset(10)
////            make.width.equalTo(10)
////            make.height.equalTo(10)
//        }
//    
//        timeLabel.snp_makeConstraints { (make) in
//            make.left.equalTo(nameLabel.snp_left)
//            make.bottom.equalTo(iconImageView.snp_bottom)
//            //缺少size的计算
////            make.height.equalTo(10)
//
//        }
//    
//        sourceLabel.snp_makeConstraints { (make) in
//            make.top.equalTo(timeLabel.snp_top)
//            make.left.equalTo(timeLabel.snp_right).offset(10)
//        }
        

        

//        collectionView.snp_makeConstraints { (make) -> Void in
//            make.left.equalTo(topView.snp_left)
//            make.top.equalTo(contentTextLabel.snp_bottom).offset(10)
//        }

        

            
            //why?
            //make.bottom.equalTo(contentView.snp_bottom)
        }
//        // 2.9转发
//        retweetButton.snp_makeConstraints { (make) -> Void in
//            make.left.equalTo(bottomView.snp_left)
//            make.top.equalTo(bottomView.snp_top)
//            make.bottom.equalTo(bottomView.snp_bottom)
//        }
//        // 2.10评论
//        commentButton.snp_makeConstraints { (make) -> Void in
//            make.left.equalTo(retweetButton.snp_right)
//            make.top.equalTo(retweetButton.snp_top)
//            make.bottom.equalTo(retweetButton.snp_bottom)
//            make.width.equalTo(retweetButton.snp_width)
//        }
//        // 2.11赞
//        unlikeButton.snp_makeConstraints { (make) -> Void in
//            make.left.equalTo(commentButton.snp_right)
//            make.top.equalTo(commentButton.snp_top)
//            make.bottom.equalTo(commentButton.snp_bottom)
//            make.width.equalTo(commentButton.snp_width)
//            make.right.equalTo(bottomView.snp_right)
//        }
        

    }
    
//    /*
//    计算配图容器和cell的宽高
//    
//    - returns: 第一个是容器的宽高, 第二个是cell的宽高
//    */
//    private func calculateSize() ->(CGSize, CGSize) {
//        // 1.取出配图的个数
//        let count = viewModel?.thumbnail_urls?.count ?? 0
//        var col = 3
//        var row = 3
//        // cell宽度 = (屏幕宽度 - (列数 + 1) * 间隙) / 列数
//        let screenWidth = Int(UIScreen.mainScreen().bounds.size.width)
//        let cellWidth = (screenWidth - (col + 1) * margin ) / col
//        let cellHeight = cellWidth
//        
//        // 2.计算容器和cell的尺寸
//        if count == 0 {
//            return (CGSizeZero, CGSizeZero)
//        }else if count == 1 {
//            // 2.1判断是否是一张
//            let key = viewModel!.thumbnail_urls!.first!.absoluteString
//            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
//            let scale = UIScreen.mainScreen().nativeScale
//            let width = image.size.width * scale
//            let height = image.size.height * scale
//            let size = CGSize(width: width, height: height)
//            return (size, size)
//        }else if  count == 4 {
//            // 2.2判断是否是四张
//            row = 2
//            col = row
//            // 宽度 = 列数 * cell宽度 + (列数- 1) * 间隙
//            let width = col * cellWidth + (col - 1) * margin
//            let height = width
//            return(CGSize(width: width, height: height), CGSize(width: cellWidth, height: cellHeight))
//        }else {
//            // 2.3其它张(九宫格)
//            col = 3
//            row = (count - 1) / 3 + 1
//            // 宽度 = 列数 * cell宽度 + (列数- 1) * 间隙
//            let width = col * cellWidth + (col - 1) * margin
//            let height = row * cellHeight + (row - 1) * margin
//
//            return (CGSize(width: width, height: height), CGSize(width: cellWidth, height: cellHeight))
//        }
//        
//    }
}

//extension HomeTableViewCell: UICollectionViewDataSource{
//
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel?.thumbnail_urls?.count ?? 0
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        //取出cell
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pictureCell", forIndexPath: indexPath) as! HomePictureCell
//        
//        cell.backgroundColor = UIColor.redColor()
//        cell.url = viewModel?.thumbnail_urls![indexPath.item]
//        
//        
//        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pictureCell", forIndexPath: indexPath)
//        
//        //cell.backgroundColor = UIColor.redColor()
//        
//        return cell
//    }
//}
//
//
//class HomePictureCell: UICollectionViewCell {
//    
//    var url: NSURL? {
//        didSet{
//            imageView.sd_setImageWithURL(url)
//        }
//    }
//    
//    private lazy var imageView: UIImageView = {
//        let iv = UIImageView()
//        iv.contentMode = .ScaleAspectFill
//        iv.clipsToBounds = true
//        return iv
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        //添加控件
//        contentView.addSubview(imageView)
//        //约束控件
//        imageView.snp_makeConstraints { (make) in
//            make.edges.equalTo(0)
//        }
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}