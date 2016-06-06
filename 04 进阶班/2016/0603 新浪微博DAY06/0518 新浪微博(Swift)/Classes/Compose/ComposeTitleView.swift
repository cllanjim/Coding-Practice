//
//  ComposeTitleView.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/6/5.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class ComposeTitleView: UIView {

    // MAKR: - 懒加载
    lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "发微博"
        lb.font = UIFont.systemFontOfSize(20)
        return lb
    }()
    lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFontOfSize(15)
        lb.textColor = UIColor.lightGrayColor()
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(nameLabel)
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top)
            make.centerX.equalTo(self.snp_centerX)
        }
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp_bottom)
            make.centerX.equalTo(titleLabel.snp_centerX)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
