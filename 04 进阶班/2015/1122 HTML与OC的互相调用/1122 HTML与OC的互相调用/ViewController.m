//
//  ViewController.m
//  1122 HTML与OC的互相调用
//
//  Created by 张思琦 on 15/11/22.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSURL *url = [NSURL URLWithString:@"http://www.xianhua.cn/m/"];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
    
    //启动时候让UIWebView被隐藏
    self.webView.scrollView.hidden = YES;
    self.webView.scrollView.backgroundColor = [UIColor grayColor];
    
    //创建HUD
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //view和WebView还是有区别的!
    activityIndicatorView.center = self.view.center;
//    activityIndicatorView.center = self.webView.center;
    [self.webView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    self.activityIndicatorView = activityIndicatorView;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //抓取网页的全部信息
    NSString *str3 = @"document.body.outerHTML";
    NSString *result = [webView stringByEvaluatingJavaScriptFromString:str3];
    
    NSLog(@"%@", result);
    
    
    
    
//    NSString *str1 = @"var h1 = document.getElementsByTagName('h1')[0];"
//                    "h1.innerHTML = 'SQ的鲜花网';";
//    [webView stringByEvaluatingJavaScriptFromString:str1];
//    
//    NSString *str2 = @"document.getElementById('footer').remove();";
//    [webView stringByEvaluatingJavaScriptFromString:str2];

    //在2秒后将scrollView显示
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.webView.scrollView.hidden = NO;
        [self.activityIndicatorView stopAnimating];
    });
    
    
}


@end
