//
//  HomeCellTopView.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/29.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class HomeCellTopView: UIView {
    
    //HomeCellTopView的属性
    // 头像
    private lazy var iconImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    // 认证图标
    private lazy var verifiedImageView = UIImageView(image: UIImage(named: "avatar_vip"))
    // 昵称
    private lazy var nameLabel = UILabel(text: "小码哥", color: UIColor.orangeColor(), screenInset: 0)
    
    // 会员图标
    private lazy var vipImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    
    // 时间
    private lazy var timeLabel = UILabel(text: "刚刚", color: UIColor.orangeColor(), screenInset: 0)
    // 来源
    private lazy var sourceLabel = UILabel(text: "来自: 小码哥", color: UIColor.lightGrayColor(), screenInset: 0)
    
    //模型数据
    var viewModel: StatusViewModel? {
        didSet{
            iconImageView.sd_setImageWithURL(viewModel?.avatarURL)
            verifiedImageView.image = viewModel?.verifiedImage
            nameLabel.text = viewModel?.screenNameStr
            vipImageView.image = viewModel?.vipImage
            timeLabel.text = viewModel?.timeStr
            sourceLabel.text = viewModel?.sourceStr
        }
    }
    
    //构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = UIColor.randomColor()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置UI以及布局UI
    func setupUI() {
        //添加控件
        addSubview(iconImageView)
        addSubview(verifiedImageView)
        addSubview(nameLabel)
        addSubview(vipImageView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        
        //布局UI
        iconImageView.snp_makeConstraints { (make) in
            make.left.equalTo(self.snp_left).offset(SQHomeCellMargin)
            make.top.equalTo(self.snp_top).offset(SQHomeCellMargin)
            make.width.equalTo(SQHomeCellIconWidth)
            make.height.equalTo(SQHomeCellIconWidth)
        }
        iconImageView.layer.cornerRadius = CGFloat(SQHomeCellIconWidth) * 0.5
        iconImageView.layer.masksToBounds = true
        
        verifiedImageView.snp_makeConstraints { (make) in
            make.right.equalTo(iconImageView.snp_right)
            make.bottom.equalTo(iconImageView.snp_bottom)
        }
        
        nameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp_top)
            make.left.equalTo(iconImageView.snp_right).offset(SQHomeCellMargin)
        }
        
        vipImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(nameLabel.snp_centerY)
            make.left.equalTo(nameLabel.snp_right).offset(SQHomeCellMargin)
        }
        
        timeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp_left)
            make.bottom.equalTo(iconImageView.snp_bottom)
        }
        
        sourceLabel.snp_makeConstraints { (make) in
            make.top.equalTo(timeLabel.snp_top)
            make.left.equalTo(timeLabel.snp_right).offset(SQHomeCellMargin)
        }
    }
    
}
