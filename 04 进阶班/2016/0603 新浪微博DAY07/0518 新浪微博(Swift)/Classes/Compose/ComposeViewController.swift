//
//  ComposeViewController.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/6/5.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import SVProgressHUD

class ComposeViewController: UIViewController {
    //Navigation中的titleView
    private lazy var titleView: ComposeTitleView = {
        let titleView = ComposeTitleView()
        titleView.frame = CGRect(origin: CGPointZero, size: CGSize(width: 100, height: 44))
        titleView.nameLabel.text = UserAccountViewModel.shareInstance.getScreen_name
        return titleView
    }()
    
    //ComposeViewController的文本框
    private lazy var textView: ComposeTextView = {
        let textView = ComposeTextView()
        textView.font = UIFont.systemFontOfSize(20)
        textView.alwaysBounceVertical = true
        textView.keyboardDismissMode = .OnDrag
        
        return textView
    }()
    
    //ComposeViewController的底部工具框
    private lazy var toolbar: UIToolbar = {
        let tb = UIToolbar()
        let itemSettings = [
            ["imageName": "compose_toolbar_picture", "action": "selectPicture"],
            ["imageName": "compose_mentionbutton_background"],
            ["imageName": "compose_trendbutton_background"],
            ["imageName": "compose_emoticonbutton_background", "action": "inputEmoticon"],
            ["imageName": "compose_addbutton_background"]
        ]
        
        var items = [UIBarButtonItem]()
        
        for dict in itemSettings {
            // 1.创建按钮
            let imageName = dict["imageName"]!
            let sel = (dict["action"] != nil) ? Selector(dict["action"]!) : nil
            let item = UIBarButtonItem(imageName: imageName, target: self, action: sel)
            items.append(item)
            
            // 2.创建弹簧
            let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
            items.append(flexible)
        }
        
        items.removeLast()
        
        tb.items = items
        
        return tb
    }()
    
    private lazy var keyboardVC: SQKeyBoardViewController = SQKeyBoardViewController { [unowned self] (emoticon) -> () in
        self.textView.insertEmoticon(emoticon)
    }
    
    private lazy var photoVC: SQPhotoCollectionViewController = SQPhotoCollectionViewController()
    
    
    //MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航栏
        setupNav()
        //设置文本框
        setupTextView()
        
        setupToolBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        textView.resignFirstResponder()
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    //MARK: - 内部控制方法
    //设置导航栏
    func setupNav() {
        //设置左右按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: #selector(ComposeViewController.cancleBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .Plain, target: self, action: #selector(ComposeViewController.sendBtnClick))
        navigationItem.rightBarButtonItem?.enabled = false
        //设置中部按钮
        navigationItem.titleView = titleView
   
    }
    
    //设置文本框
    func setupTextView() {
        
        addChildViewController(keyboardVC)
        addChildViewController(photoVC)
        
        view.addSubview(textView)
        view.addSubview(photoVC.view)
        
        photoVC.view.snp_makeConstraints { (make) in
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.bottom.equalTo(view.snp_bottom)
            make.height.equalTo(0)
        }
        
        
        textView.snp_makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        textView.delegate = self
    }
    
    //设置底部工具条
    func setupToolBar() {
        // 1.添加工具条
        view.addSubview(toolbar)
        // 2.布局工具条
        toolbar.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp_left)
            make.right.equalTo(view.snp_right)
            make.bottom.equalTo(view.snp_bottom)
            make.height.equalTo(44)
        }
        // 3.监听键盘
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ComposeViewController.keyboardWillChange(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    

    //监听navigationBar左右按钮的点击事件
    @objc private func cancleBtnClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func sendBtnClick() {
        
        // 1.判断当前是文字微博还是图片微博
        if photoVC.groupOfImages.count > 0 {
            //是图片微博
            NetWorkTools.sharedInstance.sendStatus(textView.emoticonString(), image: photoVC.groupOfImages.first!, finished: { (dict, error) in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("发送失败")
                    SVProgressHUD.setDefaultMaskType(.Black)
                    return
                }
                
                SVProgressHUD.showErrorWithStatus("发送成功")
                SVProgressHUD.setDefaultMaskType(.Black)
                self.cancleBtnClick()
            })
            
        }else {
            //是文字微博
            NetWorkTools.sharedInstance.sendStatus(textView.emoticonString()) { (dict, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("发送失败")
                    SVProgressHUD.setDefaultMaskType(.Black)
                    return
                }
                
                SVProgressHUD.showErrorWithStatus("发送成功")
                SVProgressHUD.setDefaultMaskType(.Black)
                self.cancleBtnClick()
            }
        }
        
        

    }
    
    //监听toolBar中按钮的点击事件
    @objc private func selectPicture() {
        // 关闭键盘
        textView.resignFirstResponder()
        // 显示图片选择器
        photoVC.view.snp_updateConstraints { (make) -> Void in
            make.height.equalTo(view.bounds.height * 0.7)
        }
    }
    
    @objc private func inputEmoticon() {
        print("Hello,World")
        
        photoVC.view.snp_updateConstraints { (make) -> Void in
            make.height.equalTo(0)
        }
        
        //关闭键盘
        textView.resignFirstResponder()
        
        //切换键盘
        //当textView为nil时为系统键盘
        if textView.inputView != nil {
            //说明此时为自定义键盘,需要切换为系统键盘
            textView.inputView = nil
        } else {
//            let customKeyboardView = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 271))
//            customKeyboardView.backgroundColor = UIColor.randomColor()
            textView.inputView = keyboardVC.view
        }
        
        //弹出键盘
        textView.becomeFirstResponder()
        
    }
    
    //监听键盘frame改变事件
    @objc private func keyboardWillChange(notice: NSNotification) {
        // 1.获取偏移位
        let rect = notice.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
        let screenHeight = UIScreen.mainScreen().bounds.height
        //toolBar的偏移距离 = 屏幕高度 - 键盘的Y值
        let offsetY = screenHeight - rect.origin.y
        
        // 2.更新约束
        toolbar.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(-offsetY)
        }
        
        // 3.执行动画
        UIView.animateWithDuration(0.25) { () -> Void in
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            self.view.layoutIfNeeded()
        }
    }
    
}


extension ComposeViewController: UITextViewDelegate {
    //监听textView的文本框是否发生改变
    func textViewDidChange(textView: UITextView) {
        // 控制发送按钮是否可用
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
    }
}
