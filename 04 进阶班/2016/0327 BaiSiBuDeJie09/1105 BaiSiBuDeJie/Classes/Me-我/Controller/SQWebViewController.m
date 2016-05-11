//
//  SQWebViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/2/18.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQWebViewController.h"

@interface SQWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reloadButton;

@end

@implementation SQWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

#pragma mark - button的功能设定
- (IBAction)backButtonClick:(id)sender {
    [self.webView goBack];
}
- (IBAction)forwardButtonClick:(id)sender {
    [self.webView goForward];
}
- (IBAction)reloadButtonClick:(id)sender {
    [self.webView reload];
}

#pragma mark - UIWebViewDelegate的代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.backButton.enabled = webView.canGoBack;
    self.forwardButton.enabled = webView.canGoForward;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
