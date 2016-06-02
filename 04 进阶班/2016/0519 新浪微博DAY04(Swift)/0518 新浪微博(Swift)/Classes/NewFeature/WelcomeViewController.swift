//
//  WelcomeViewController.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/24.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import QorumLogs

class WelcomeViewController: UIViewController {
    //MARK: - 懒加载
    private lazy var iconImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    private lazy var tipLabel: UILabel = {
        let lb = UILabel()
        lb.alpha = 0.0
        lb.text = "欢迎回来"
        lb.font = UIFont.systemFontOfSize(18)
        lb.textColor = UIColor.darkGrayColor()
        return lb
    }()
    
    //MARK: - 生命周期方法
    override func loadView() {
        let imageView = UIImageView(image: UIImage(named: "ad_background"))
        view = imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.添加子控件
        view.addSubview(iconImageView)
        view.addSubview(tipLabel)
        
        // 2.布局子控件
        iconImageView.snp_makeConstraints { (make) in
            make.width.equalTo(90)
            make.height.equalTo(90)
            make.centerX.equalTo(view)
            
            let offsetY = -view.bounds.height * 0.3
            make.bottom.equalTo(view.snp_bottom).offset(offsetY)
        }
        
        tipLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconImageView.snp_bottom).offset(20)
            make.centerX.equalTo(iconImageView)
        }
        
        // 3.设置图片圆角
        iconImageView.layer.cornerRadius = 45
        iconImageView.layer.masksToBounds = true
        
        // 4.添加头像
        iconImageView.sd_setImageWithURL(UserAccountViewModel.shareInstance.getAvatar_URL)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // 1.修改约束
        iconImageView.snp_updateConstraints { (make) -> Void in
            let offsetY = -self.view.bounds.height * 0.7
            make.bottom.equalTo(view.snp_bottom).offset(offsetY)
        }
        
        // 2.执行动画
        UIView.animateWithDuration(1.0, animations: {
            self.view.layoutIfNeeded()
            }) { (_) in
                UIView.animateWithDuration(1.0, animations: {
                    self.tipLabel.alpha = 1.0
                    }, completion: { (_) in

                        //在执行完动画后,发出通知,且传递参数true,代表需要跳转到mainViewController
                        NSNotificationCenter.defaultCenter().postNotificationName(SQChangeRootViewControllerNotification, object: true)
                        
                        //UIApplication.sharedApplication().keyWindow?.rootViewController = MainViewController()
                })
        }
    }
    
    
}
