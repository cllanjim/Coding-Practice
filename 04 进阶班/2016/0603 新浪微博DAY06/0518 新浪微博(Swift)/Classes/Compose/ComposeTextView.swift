//
//  ComposeTextView.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/6/5.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class ComposeTextView: UITextView {

    override var font: UIFont? {
        didSet {
            placeholder.font = font
        }
    }
    
    // MAKR: - 懒加载
    private lazy var placeholder: UILabel = {
        let lb = UILabel()
        lb.text = "分享新鲜事..."
        lb.textColor = UIColor.lightGrayColor()
        return lb
    }()
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeholder)
        
        placeholder.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self).offset(5)
            make.top.equalTo(self).offset(8)
        }
        
        // 设置监听, 监听文本变化
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ComposeTextView.textChange), name: UITextViewTextDidChangeNotification, object: self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    // MAKR: - 内部控制方法
    @objc private func textChange() {
        placeholder.hidden = hasText()
    }
    
}
