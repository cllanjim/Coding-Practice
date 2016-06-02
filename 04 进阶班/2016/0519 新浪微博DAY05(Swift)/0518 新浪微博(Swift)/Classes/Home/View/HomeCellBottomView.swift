//
//  HomeCellBottomView.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/29.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class HomeCellBottomView: UIView {

    // 转发按钮
    private lazy var retweetButton = UIButton(title: "转发", imageName: "timeline_icon_retweet", backgroundImageName: "timeline_card_bottom_background")
    // 评论按钮
    private lazy var commentButton = UIButton(title: "评论", imageName: "timeline_icon_comment", backgroundImageName: "timeline_card_bottom_background")
    // 赞按钮
    private lazy var unlikeButton = UIButton(title: "赞", imageName: "timeline_icon_unlike", backgroundImageName: "timeline_card_bottom_background")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
//        self.backgroundColor = UIColor.redColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        addSubview(retweetButton)
        addSubview(commentButton)
        addSubview(unlikeButton)
        
        
        // 2.9转发
        retweetButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left)
            make.top.equalTo(self.snp_top)
            make.bottom.equalTo(self.snp_bottom)
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
            make.right.equalTo(self.snp_right)
        }
    }

}
