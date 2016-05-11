//
//  ViewController.m
//  1123 在HTML中调用OC
//
//  Created by 张思琦 on 15/11/23.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    
    //加载页面
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    NSString *url = request.URL.absoluteString;
    NSLog(@"%@",url);

    NSRange range =[url rangeOfString:@"ds2q://"];
//    NSLog(@"%@",NSStringFromRange(range));
    //{9223372036854775807, 0}
    //代表range为-1,0 ,即子字符串串不存在当前字符串中
    
    NSUInteger location = range.location;
    NSLog(@"%ld",location);
    NSLog(@"%ld",range.length);
    
    //NSRange包含location和length
    if (location != NSNotFound) {
        //如果调用失败注意检查HTML文件中是否存在错误!
        //从ds2q://后面开始截取字段
        NSString *str = [url substringFromIndex:location + range.length];
        //将字段保存成SEL
        SEL sel = NSSelectorFromString(str);
        //执行SEL
        [self performSelector:sel];
        NSLog(@"YES");
    }
    return YES;

}


- (void)openCamera{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    UIImagePickerControllerSourceTypePhotoLibrary,
//    UIImagePickerControllerSourceTypeCamera,
//    UIImagePickerControllerSourceTypeSavedPhotosAlbum
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:^{
        NSLog(@"调用成功");
    }];
    

}


@end
