//
//  OAuthViewController.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/22.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit
import SVProgressHUD
import QorumLogs

class OAuthViewController: UIViewController {
    
    //MARK: - 懒加载
    private lazy var webView: UIWebView = {
        let webView = UIWebView()
        webView.delegate = self
        return webView
    }()
    
    //MARK: - 生命周期相关的方法
    override func loadView() {
        view = webView
        
        //在webView上加载导航条
        navigationItem.title = "请求授权"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(OAuthViewController.closeBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(OAuthViewController.autoAccount))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadOAuthPage()
    }
    
    deinit {

    }

    //MARK: - 监听方法
    @objc private func closeBtnClick() {
        SVProgressHUD.dismiss()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func autoAccount(){
        //let jsStr = "document.getElementById('userId').value='kidd_zhangsiqi@163.com';" + "document.getElementById('passwd').value='zsq2011943';"
        let jsStr = "document.getElementById('userId').value='xiaosunqing0921@sina.cn';" + "document.getElementById('passwd').value='qqwoaini921';"
        webView.stringByEvaluatingJavaScriptFromString(jsStr)
    }
    
    //MARK: - 网络请求方法
    func loadOAuthPage() {
        let str = "https://api.weibo.com/oauth2/authorize?client_id=\(SQ_App_Key)&redirect_uri=\(SQ_Redirect_uri)"
        let url = NSURL(string: str)!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }
    
}

extension OAuthViewController: UIWebViewDelegate {
    //处理重定向地址
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        
        //0.取出当前的请求网址
        guard let urlStr = request.URL?.absoluteString else {
            //如果当前的网络请求没有网址,就停止跳转
            closeBtnClick()
            return false
        }
        //1.如果请求的URL地址不是回调页面
        if urlStr.hasPrefix(SQ_Redirect_uri) == false {
            //如果不是回调页面,就要继续跳转
            return true
        }
        
        //2.如果请求的URL地址是授权失败的情况
        if urlStr.containsString("error_uri=") == true {
            authFailAction()
            return false
        }

        //3 此时是授权回调页面,且为授权成功回调页面
        guard let range = urlStr.rangeOfString("code=") else {
            authFailAction()
            return false
        }
        
        //4 截取字符串,获取授权的RequestToken
        let requestToken = urlStr.substringFromIndex(range.endIndex)
        
        //5 利用获取的RequestToken来换取AccessToken和UserInfo
        UserAccountViewModel.shareInstance.saveAccessTokenAndUserInfo(requestToken) {
            //6 更换首页
             //在执行完动画后,发出通知,且传递参数fales,代表需要跳转到WelcomeViewController
            NSNotificationCenter.defaultCenter().postNotificationName(SQChangeRootViewControllerNotification, object: false)
            
        }
        
        //关闭当前界面
        closeBtnClick()
        
        return false
    }
    
    //每次请求之前调用
    func webViewDidStartLoad(webView: UIWebView){
        SVProgressHUD.showInfoWithStatus("正在努力加载中")
        SVProgressHUD.setDefaultMaskType(.Black)
    }
    
    //每次请求完毕后调用
    func webViewDidFinishLoad(webView: UIWebView){
        SVProgressHUD.dismiss()
    }
    
    //请求发生错误时调用
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?){
    }
    

    func authFailAction() {
        SVProgressHUD.showErrorWithStatus("授权失败了...")
        SVProgressHUD.setDefaultMaskType(.Black)
        
        let time: NSTimeInterval = 2.0
        let delay = dispatch_time(DISPATCH_TIME_NOW,
                                  Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue(), {
            self.closeBtnClick()
        })
    }
}
