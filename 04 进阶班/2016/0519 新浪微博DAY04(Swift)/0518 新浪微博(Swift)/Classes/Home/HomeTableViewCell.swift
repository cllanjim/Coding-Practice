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
    let margin = 10
    
    //MARK: - 设置基本属性
    var viewModel: StatusViewModel? {
        didSet{
            //设置数据
            // 1.设置头像
            iconImageView.sd_setImageWithURL(viewModel?.avatarURL)
            verifiedImageView.image = viewModel?.verifiedImage
            nameLabel.text = viewModel?.screenNameStr
            vipImageView.image = viewModel?.vipImage
            timeLabel.text = viewModel?.timeStr
            sourceLabel.text = viewModel?.sourceStr
            contentTextLabel.text = viewModel?.contentStr
            
            let (clvSize, itemSize) = calculateSize()
            collectionView.snp_updateConstraints { (make) -> Void in
                make.width.equalTo(clvSize.width)
                make.height.equalTo(clvSize.height)
            }
            
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = itemSize
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            
            // 8.4刷新表格
            collectionView.reloadData()
            
//            let url = NSURL(string: status?.user?.profile_image_url ?? "")
//            iconImageView.sd_setImageWithURL(url)

            
            // 2.设置认证图标
//            let type = status?.user?.verified_type ?? -1
//            var image: UIImage? = nil
//            switch type {
//            case 0:
//                image = UIImage(named: "avatar_vip")
//            case 2, 3, 5:
//                image = UIImage(named: "avatar_enterprise_vip")
//            case 220:
//                image = UIImage(named: "avatar_grassroot")
//            default:
//                image = nil
//            }
//            verifiedImageView.image = image

            
            

            // 3.设置昵称
            //nameLabel.text = status?.user?.screen_name

            
            
            // 4.设置会员图标
//            let rank = status?.user?.mbrank ?? 0
//            if  rank > 0 && rank < 7 {
//                vipImageView.image = UIImage(named: "common_icon_membership_level\(rank)")
//                nameLabel.textColor = UIColor.orangeColor()
//            }else {
//                vipImageView.image = nil
//                nameLabel.textColor = UIColor.lightGrayColor()
//            }
            

            
//            // 5.设置时间
//            //获取字符串
//            if let temp = status?.created_at{
//                //转换字符串为NSDate
//                if let createDate = NSDate.createDateWithString(temp){
//                    //根据NSDate与当前Date的情况,返回String
//                    timeLabel.text = createDate.describeDate()
//                }
//            }

            
//            if let temp = status?.created_at {
//                var result = ""
//                
//                temp = "Wed May 24 10:50:30 +0800 2016"
//
//                //1创建时间格式
//                let formatter = NSDateFormatter()
//                //2设置时间格式
//                formatter.dateFormat = "EE MM dd HH:mm:ss Z yyyy"
//                //3设置区域
//                formatter.locale = NSLocale(localeIdentifier: "en")
//                4将字符串转换为NSDate
//                if let createDate = formatter.dateFromString(temp) {
//                    //创建日历类
//                    let calendar = NSCalendar.currentCalendar()
//                    if calendar.isDateInToday(createDate){
//                        //判断是否是当天
//                        let comps = calendar.components([.Hour, .Second], fromDate: createDate, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
//                        if comps.hour > 1 {
//                           //多少小时前
//                            formatter.dateFormat = "HH小时前"
//                        }else if comps.minute > 1 {
//                            //多少分钟前
//                            formatter.dateFormat = "mm分钟以前"
//                        }else {
//                            //1分钟以前
//                            formatter.dateFormat = "刚刚"
//                        }
//                        //将时间转换为字符串
//                        result = formatter.stringFromDate(createDate)
//                    }else if calendar.isDateInYesterday(createDate){
//                        //判断是否是昨天
//                        formatter.dateFormat = "昨天 HH:mm"
//                        result = formatter.stringFromDate(createDate)
//                    }else {
//                        //获取当前时间与服务器返回时间的年单位的插值
//                        let comp = calendar.components(.Year, fromDate: createDate, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
//                        if comp.year > 1 {
//                            //一年以外的时间
//                            formatter.dateFormat = "yyyy-MM-dd HH:mm"
//                        }else {
//                            //一年以内
//                            formatter.dateFormat = "MM-dd HH:mm"
//                        }
//                        //将时间转换为字符串
//                        result = formatter.stringFromDate(createDate)
//                    }
//                }
//                timeLabel.text = result
//            }
            
            

            // 6.设置来源
//            sourceLabel.text = {
//                var text: String? = nil
//                
//                if let nsText: NSString = status?.source where nsText != ""{
//                    // 1. 查找开始的位置
//                    let startIndex = nsText.rangeOfString(">").location + 1
//                    // 2.计算截取长度
//                    // 注意: rangeOfString方法默认是从前往后找, 只要找到一个就不继续查找了
//                    let length = nsText.rangeOfString("<", options: .BackwardsSearch).location - startIndex
//                    // 3.截取字符串
//                    let result = nsText.substringWithRange(NSMakeRange(startIndex, length))
//                    
//                    text = "来自: " + (result as String)
//                }
//                return text
//            }()



            // 7.设置正文
            //contentTextLabel.text = status?.text
            
        }
    }
    
    //MARK: - 懒加载
    /// 头像
    private lazy var iconImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    /// 认证图标
    private lazy var verifiedImageView = UIImageView(image: UIImage(named: "avatar_vip"))
    /// 昵称
    private lazy var nameLabel = UILabel(text: "小码哥", color: UIColor.orangeColor(), screenInset: 0)
    
    /// 会员图标
    private lazy var vipImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    
    /// 时间
    private lazy var timeLabel = UILabel(text: "刚刚", color: UIColor.orangeColor(), screenInset: 0)
    /// 来源
    private lazy var sourceLabel = UILabel(text: "来自: 小码哥", color: UIColor.lightGrayColor(), screenInset: 0)
    /// 正文
    private lazy var contentTextLabel =  UILabel(text: "", color: UIColor.darkGrayColor(), screenInset: 10)
    // 转发按钮
    private lazy var retweetButton = UIButton(title: "转发", imageName: "timeline_icon_retweet", backgroundImageName: "timeline_card_bottom_background")
    // 评论按钮
    private lazy var commentButton = UIButton(title: "评论", imageName: "timeline_icon_comment", backgroundImageName: "timeline_card_bottom_background")
    // 赞按钮
    private lazy var unlikeButton = UIButton(title: "赞", imageName: "timeline_icon_unlike", backgroundImageName: "timeline_card_bottom_background")
    // 底部工具条
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orangeColor()
        return view
    }()
    // 配图
    private lazy var collectionView: UICollectionView = {
        let clv = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
        
        clv.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "pictureCell")
        
        clv.dataSource = self
        
        return clv

    }()
    
    
    
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

    //MARK: - 设置UI界面
    func setupUI() {
        //1 添加子控件
        contentView.addSubview(iconImageView)
        contentView.addSubview(verifiedImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(vipImageView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(contentTextLabel)
        contentView.addSubview(bottomView)
        contentView.addSubview(collectionView)
        bottomView.addSubview(retweetButton)
        bottomView.addSubview(commentButton)
        bottomView.addSubview(unlikeButton)
        
        
        //2 布局子控件
        iconImageView.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        iconImageView.layer.cornerRadius = 25
        iconImageView.layer.masksToBounds = true

        verifiedImageView.snp_makeConstraints { (make) in
            make.right.equalTo(iconImageView.snp_right)
            make.bottom.equalTo(iconImageView.snp_bottom)
        }
        
        nameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp_top)
            make.left.equalTo(iconImageView.snp_right).offset(10)
        }
        
        vipImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(nameLabel.snp_centerY)
            make.left.equalTo(nameLabel.snp_right).offset(10)
        }
    
        timeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp_left)
            make.bottom.equalTo(iconImageView.snp_bottom)
        }
    
        sourceLabel.snp_makeConstraints { (make) in
            make.top.equalTo(timeLabel.snp_top)
            make.left.equalTo(timeLabel.snp_right).offset(10)
        }
        
        
        // 2.7正文
        contentTextLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconImageView.snp_left)
            make.top.equalTo(iconImageView.snp_bottom).offset(10)
        }
        
        collectionView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentView.snp_left).offset(10)
            make.top.equalTo(contentTextLabel.snp_bottom).offset(10)
        }
        
        // 2.8底部工具条
        bottomView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.height.equalTo(44)
            make.top.equalTo(collectionView.snp_bottom).offset(10)
            //make.top.equalTo(contentTextLabel.snp_bottom).offset(10)
            make.bottom.equalTo(contentView.snp_bottom)
        }
        // 2.9转发
        retweetButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(bottomView.snp_left)
            make.top.equalTo(bottomView.snp_top)
            make.bottom.equalTo(bottomView.snp_bottom)
        }
        // 2.10评论
        commentButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(retweetButton.snp_right)
            make.top.equalTo(retweetButton.snp_top)
            make.bottom.equalTo(retweetButton.snp_bottom)
            make.width.equalTo(retweetButton.snp_width)
        }
        // 2.11赞
        unlikeButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(commentButton.snp_right)
            make.top.equalTo(commentButton.snp_top)
            make.bottom.equalTo(commentButton.snp_bottom)
            make.width.equalTo(commentButton.snp_width)
            make.right.equalTo(bottomView.snp_right)
        }
        

    }
    
    /*
    计算配图容器和cell的宽高
    
    - returns: 第一个是容器的宽高, 第二个是cell的宽高
    */
    private func calculateSize() ->(CGSize, CGSize) {
        // 1.取出配图的个数
        let count = viewModel?.thumbnail_urls?.count ?? 0
        var col = 3
        var row = 3
        // cell宽度 = (屏幕宽度 - (列数 + 1) * 间隙) / 列数
        let screenWidth = Int(UIScreen.mainScreen().bounds.size.width)
        let cellWidth = (screenWidth - (col + 1) * margin ) / col
        let cellHeight = cellWidth
        //let cellWidth = (UIScreen.mainScreen().bounds.width - CGFloat(col + 1) * margin) / CGFloat(col)
        //let cellHeight = cellWidth
        
        // 2.计算容器和cell的尺寸
        if count == 0 {
            return (CGSizeZero, CGSizeZero)
        }else if count == 1 {
            // 2.1判断是否是一张
            let key = viewModel!.thumbnail_urls!.first!.absoluteString
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
            return (image.size, image.size)
        }else if  count == 4 {
            // 2.2判断是否是四张
            row = 2
            col = row
            // 宽度 = 列数 * cell宽度 + (列数- 1) * 间隙
            let width = col * cellWidth + (col - 1) * margin
            //let width = CGFloat(col) * cellWidth + CGFloat(col - 1) * margin
            let height = width
            return(CGSize(width: width, height: height), CGSize(width: cellWidth, height: cellHeight))
        }else {
            // 2.3其它张(九宫格)
            col = 3
            row = (count - 1) / 3 + 1
            // 宽度 = 列数 * cell宽度 + (列数- 1) * 间隙
            let width = col * cellWidth + (col - 1) * margin
            let height = row * cellHeight + (row - 1) * margin
            
            //let width = CGFloat(col) * cellWidth + CGFloat(col - 1) * margin
            //let height = CGFloat(row) * cellHeight + CGFloat(row - 1) * margin
            return (CGSize(width: width, height: height), CGSize(width: cellWidth, height: cellHeight))
        }
        
    }
}

extension HomeTableViewCell: UICollectionViewDataSource{

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.thumbnail_urls?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("pictureCell", forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor.redColor()
        
        return cell
    }
}