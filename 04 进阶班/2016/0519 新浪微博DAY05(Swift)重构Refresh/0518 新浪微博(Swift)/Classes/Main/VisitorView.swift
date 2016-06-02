//
//  VisitorView.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/19.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import SnapKit

class VisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MAKR: - 外部控制方法
    /**
     设置访客视图信息
     
     - parameter imageName: 需要展示的图标
     - parameter text:      需要展示的正文
     */
    func setupVisitorInfo(imageName: String?, text: String?){
        
        if imageName == nil {
            //代表进入了Home控制器,不需要任何修改,直接显示即可
            startAnimation()
            return
        }
        
        tipLabel.text = text
        iconImageView.image = UIImage(named: (imageName ?? ""))
        //隐藏转盘
        imageView.hidden = true
    }
    
    /**
     转盘的动画代码
     */
    func startAnimation() {
        //1.创建动画
        let anim = CABasicAnimation(keyPath:"transform.rotation")
        
        // 2.设置动画属性
        anim.toValue = 2 * M_PI
        anim.duration = 5.0
        anim.repeatCount = MAXFLOAT
        
        // 告诉系统不要自动移除动画
        anim.removedOnCompletion = false
        
        // 3.将动画添加到图层
        imageView.layer.addAnimation(anim, forKey: nil)
    }
    
    private func setup(){
        //添加子控件
        addSubview(imageView)
        addSubview(coverView)
        addSubview(iconImageView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        
        
        //布局子控件
        imageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-60)

        }
        coverView.snp_makeConstraints { (make) in
            make.center.equalTo(imageView)
        }
        iconImageView.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(imageView).offset(16)
        }
        tipLabel.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(imageView.snp_bottom).offset(15)
            make.width.equalTo(226)
        }
        registerButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(tipLabel.snp_bottom).offset(15)
            make.left.equalTo(tipLabel)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        loginButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(tipLabel.snp_bottom).offset(15)
            make.right.equalTo(tipLabel)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        
        backgroundColor = UIColor(white: 237.0/255.0, alpha: 1.0)


    }
    

    
    //MARK: - 懒加载
    // 转盘
    private lazy var imageView = UIImageView(image:UIImage(named:"visitordiscover_feed_image_smallicon"))
    // 蒙版
    private lazy var coverView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    /// 图标
    private lazy var iconImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    // 提示文本
    private lazy var tipLabel: UILabel = UILabel(text:  "关注一些人, 回这里看看有没有什么惊喜")
    // 注册按钮
    lazy var registerButton: UIButton = UIButton(title: "注册", backgroundImageName: "common_button_white_disable", color: UIColor.orangeColor())
    // 登录按钮
    lazy var loginButton: UIButton = UIButton(title: "登录", backgroundImageName: "common_button_white_disable", color: UIColor.lightGrayColor())
}
