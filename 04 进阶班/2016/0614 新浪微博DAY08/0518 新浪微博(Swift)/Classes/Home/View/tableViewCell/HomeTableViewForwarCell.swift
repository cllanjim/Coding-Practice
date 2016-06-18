//
//  HomeTableViewForwarCell.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/29.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import KILabel

class HomeTableViewForwarCell: HomeTableViewCell {

    //控件属性
    // MAKR: - 懒加载
    private lazy var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGrayColor()
        return view
    }()
    
    //private lazy var forwradTextLabel = UILabel(text: "", color: UIColor.darkGrayColor(), screenInset: 10)
    
    private lazy var forwradTextLabel: KILabel = {
        let lb = KILabel()
        lb.textColor = UIColor.darkGrayColor()
        lb.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 2 * CGFloat(SQHomeCellMargin)
        lb.numberOfLines = 0
        return lb
    }()
    
    
    override var viewModel: StatusViewModel?{
        didSet{
            let name = viewModel?.statusModel.retweeted_status?.user?.screen_name ?? ""
            let text = viewModel?.statusModel.retweeted_status?.text ?? ""
            
            //forwradTextLabel.text = "@" + name + ":" + text
            forwradTextLabel.attributedText = SQKeyBoardEmoticonPackage.shareInstance.attributedStringWithString("@" + name + ":" + text, font: forwradTextLabel.font)
            
            // 更新配图布局
            pictureCollectionView.snp_updateConstraints { (make) in
                //当微博没有配图时,将pictureCollectionView的偏移量移除
                let offsetY = (viewModel?.thumbnail_urls?.count > 0) ? SQHomeCellMargin : 0
                make.top.equalTo(forwradTextLabel.snp_bottom).offset(offsetY)
            }
        }
    }
}

extension HomeTableViewForwarCell{
    
    override func setupUI() {
        super.setupUI()
        
        // 1.添加子控件
        contentView.insertSubview(coverView, belowSubview: pictureCollectionView)
        contentView.insertSubview(forwradTextLabel, aboveSubview: coverView)
        
        // 2.布局子控件
        coverView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.top.equalTo(contentTextLabel.snp_bottom).offset(SQHomeCellMargin)
            make.bottom.equalTo(pictureCollectionView.snp_bottom).offset(SQHomeCellMargin)
        }
        
        forwradTextLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(coverView.snp_left).offset(SQHomeCellMargin)
            make.top.equalTo(coverView.snp_top).offset(SQHomeCellMargin)
        }
        
        //移除原有的约束
        //将PictureCollectionView添加到coverView中
        pictureCollectionView.snp_removeConstraints()
        pictureCollectionView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(forwradTextLabel.snp_left)
            make.top.equalTo(forwradTextLabel.snp_bottom).offset(SQHomeCellMargin)
        }
    }
}
