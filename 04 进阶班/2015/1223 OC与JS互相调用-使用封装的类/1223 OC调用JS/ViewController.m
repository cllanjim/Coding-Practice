//
//  ViewController.m
//  1223 OC调用JS
//
//  Created by 张思琦 on 15/12/23.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "NSObject+performSelector.h"

@interface ViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
   //创建一个程序异常
    @[][1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载本地的html文件
    NSURLRequest *request = [NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"test.html" withExtension:nil]];
    [self.mainWebView loadRequest:request];
    
//    self.mainWebView.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - webViewDelegate
//每次加载Request时就会调用该方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //1 获取request中的URL内容
    NSString *urlStr = request.URL.absoluteString;
    NSString *scheme = @"xmg://";
    //2 判断获取的URL中是否包含特定的协议头
    if([urlStr hasPrefix:scheme]){
        //如果当前URL中带有特定的协议头,就去除特定的协议头
        urlStr = [urlStr substringFromIndex:scheme.length];
        //3 利用?将剩余内容划分为方法名和参数
        NSArray *subURL = [urlStr componentsSeparatedByString:@"?"];
        //4 将方法名中的_替换为:
        NSString *methodName = [subURL firstObject];
        methodName = [methodName stringByReplacingOccurrencesOfString:@"_" withString:@":"];
        SEL selector = NSSelectorFromString(methodName);
        
        //判断当前URL中是否含有参数
        if (subURL.count == 2) {
            //说明是带参数的方法
            NSArray *parms = [[subURL lastObject] componentsSeparatedByString:@"&"];
            //判断参数个数来确定下一步的操作
            [self performSelector:selector withObjects:parms];
            //执行完毕后就不应当加载URL
            return NO;
        }
        
        //执行到这说明是无参数的方法
        [self performSelector:selector withObject:nil];
        //执行完毕后就不应当加载当前URL
        return NO;
    }
    
    //如果URL中没有特定的协议头,说明JavaScript并没有调用Objective-C,所以应当加载当前URL
    return YES;
}

#pragma mark - method To Use

- (void)call{
    NSLog(@"%s",__func__);

}

- (void)callWithNumber:(NSString *)number{
    NSLog(@"call Number: %@", number);
}

- (void)callNumber:(NSString *)number WithContent:(NSString *)content{
    NSLog(@"call Number:%@, withContent:%@",number,content);
}

- (void)callNumber:(NSString *)number WithContent:(NSString *)content atPlace:(NSString *)place{
    NSLog(@"call Number:%@, withContent:%@, atPlace:%@",number,content,place);
}


//在加载完网页后调用该方法
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [webView stringByEvaluatingJavaScriptFromString:@"show()"];
//}



@end
