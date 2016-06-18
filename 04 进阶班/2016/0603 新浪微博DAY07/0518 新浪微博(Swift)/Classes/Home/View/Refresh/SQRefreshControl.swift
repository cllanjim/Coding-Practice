//
//  SQRefreshControl.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/30.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class SQRefreshControl: UIRefreshControl {

    var isArrowRotate = false
    
    private lazy var refreshView = SQRefreshView.refreshView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        //添加子控件
        addSubview(refreshView)
        //监听自身frame的变化
        addObserver(self, forKeyPath: "frame", options: .New, context: nil)
    }
    
    deinit {
        removeObserver(self, forKeyPath: "frame")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width: CGFloat = 200
        let height: CGFloat = 60
        let y: CGFloat = 0
        let x: CGFloat = (bounds.width - width) * 0.5
        refreshView.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        //复原旋转表示为false
        isArrowRotate = false
        //恢复RefreshView到初始状态
        refreshView.recoverStartStatus()
    }
    
    //监听到值变化就会调用该方法
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        //1 过滤垃圾数据
        if frame.origin.y == 0 || frame.origin.y == -64 {
            return
        }
        
        //2 判断是否触发刷新事件
        //在UIRefreshControl中通过refreshing
        if refreshing {
            refreshView.startLoadingView()
        }
    
        if frame.origin.y < -60 && !isArrowRotate {
            isArrowRotate = true
            refreshView.rotationArrow(isArrowRotate)
        }else if frame.origin.y > -60 && isArrowRotate {
            isArrowRotate = false
            refreshView.rotationArrow(isArrowRotate)
        }
        
    }

}
