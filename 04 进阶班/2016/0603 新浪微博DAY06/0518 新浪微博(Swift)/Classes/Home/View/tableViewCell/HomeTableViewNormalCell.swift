//
//  HomeTableViewNormalCell.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/29.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class HomeTableViewNormalCell: HomeTableViewCell {

    /// 视图模型
    override var viewModel: StatusViewModel? {
        didSet{
            // 更新配图布局
            pictureCollectionView.snp_updateConstraints { (make) in
                //当微博没有配图时,将pictureCollectionView的偏移量移除
                let offsetY = (viewModel?.thumbnail_urls?.count > 0) ? SQHomeCellMargin : 0
                make.top.equalTo(contentTextLabel.snp_bottom).offset(offsetY)
            }
        }
    }
}
