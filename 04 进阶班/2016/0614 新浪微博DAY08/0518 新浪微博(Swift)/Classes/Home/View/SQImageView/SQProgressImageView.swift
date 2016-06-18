//
//  SQProgressImageView.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/6/3.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class SQProgressImageView: UIImageView {

    /// 进度 取值范围0.0~1.0
    var progress: CGFloat = 0.0 {
        didSet {
            progressView.progress = progress
        }
    }
    
    private lazy var progressView: SQProgressView = SQProgressView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(progressView)
        
        progressView.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        progressView.frame = bounds
    }

}
