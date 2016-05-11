//
//  ViewController.m
//  1223 WebView的基本使用
//
//  Created by 张思琦 on 15/12/23.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reloadButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //加载网址
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];
    
//    //加载图片
//    NSURL *url = [NSURL fileURLWithPath:@"/Users/SketchK/Desktop/Snip20151223_8.png"];
    
//    //加载视频
//    NSURL *url = [NSURL fileURLWithPath:@"/Users/SketchK/Desktop/123.mp4"];
    
    
//    //加载内置网页
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];
    
    //加载页面需要调整的网站
    NSURL *url = [NSURL URLWithString:@"http://www.zhibo8.cc/"];
    self.webView.scalesPageToFit = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView.dataDetectorTypes
    
   
    //禁用button
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
    //设置webView的代理为ViewController
    self.webView.delegate = self;
    //加载对应网络请求
    [self.webView loadRequest:request];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - button功能区域
- (IBAction)backButtonClick:(id)sender {
    [self.webView goBack];
}
- (IBAction)forwardButtonClick:(id)sender {
    [self.webView goForward];
}
- (IBAction)reloadButtonClick:(id)sender {
    [self.webView reload];
}

#pragma mark - 生命周期
/**
 *  UIWebView在加载请求时会调用该方法
 *
 *  @param webView        触发该方法的webView
 *  @param request        需要加载的请求
 *  @param navigationType 加载请求的方式
 *
 *  @return 返回NO为禁止加载,返回YES为允许加载
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.forwardButton.enabled = self.webView.canGoForward;
    self.backButton.enabled = self.webView.canGoBack;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

}


@end
