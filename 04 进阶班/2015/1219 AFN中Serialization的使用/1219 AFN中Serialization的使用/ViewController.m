//
//  ViewController.m
//  1219 AFN中Serialization的使用
//
//  Created by 张思琦 on 15/12/19.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()

//@property (nonatomic, strong) <#type#> *<#value#>;

@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

//- (UILabel *)label{
//    if (_label == nil) {
//        _label = UILa
//    }
//    return _label;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    //1 创建AFNetworkReachabilityManager
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    //2 使用
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //AFNetworkReachabilityStatusUnknown          = -1, 网络情况未知
        //AFNetworkReachabilityStatusNotReachable     = 0,  网络无链接
        //AFNetworkReachabilityStatusReachableViaWWAN = 1,  通过移动网络
        //AFNetworkReachabilityStatusReachableViaWiFi = 2,  通过WiFi
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.label.text=@"网络情况未知";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.label.text=@"网络无链接";

                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.label.text=@"通过移动网络";

                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.label.text=@"通过WiFi";

                break;
            default:
                break;
        }
        
    }];
    //3 开始监听
    [reachabilityManager startMonitoring];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"Hello,World");

    
    
    

    
    
}


- (void)setSerializer{

    //1 创建AFN管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置响应的方式为XML
    //请求格式
    //AFHTTPRequestSerializer            二进制格式(默认选项)
    //AFJSONRequestSerializer            JSON
    //AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //返回格式
    //AFHTTPResponseSerializer           二进制格式
    //AFJSONResponseSerializer           JSON(默认选项)
    //AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
    //AFXMLDocumentResponseSerializer (Mac OS X)
    //AFPropertyListResponseSerializer   PList
    //AFImageResponseSerializer          Image
    //AFCompoundResponseSerializer       组合
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    
    //2 利用Manager发送GET请求
    NSDictionary *parameters = @{
                                 @"username":@"520it",
                                 @"pwd":@"520it",
                                 @"type":@"XML"
                                 };
    
    
    [manager GET:@"http://120.25.226.186:32812/login" parameters:parameters progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"回调成功");
         }   failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"回调失败");
         }];
}


@end
