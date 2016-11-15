//
//  SQFooterView.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/12/3.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import <MJExtension.h>
#import "SQFooterView.h"
#import "SQMeSquareModel.h"
#import "SQMeViewController.h"
#import "SQMeSquareButton.h"



#import "SQTabBarController.h"
#import "SQNavigationController.h"
#import "SQWebViewController.h"
//改用自定义的AFHTTPSessionManager
#import "SQHTTPSessionManager.h"
//#import <AFNetworking.h>



#import <SafariServices/SafariServices.h>

//#import <AFNetworking/UIButton+AFNetworking.h>
#import <SDWebImage/UIButton+WebCache.h>



@implementation SQFooterView


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        
        //发送GET请求的parameters参数
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        parameter[@"a"] = @"square";
        parameter[@"c"] = @"topic";
        
        //在创建footerView的时候就发送请求获取footerView的数据
        SQHTTPSessionManager *sessionManager = [SQHTTPSessionManager manager];
        __weak typeof(self) weakSelf = self;
        [sessionManager GET:SQCommonURL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            //查看返回的JSON数据
//            SQLOG(@"请求成功");
//            //查看返回数据
//            //方法一 打印数据
//            //缺点:对于中文字体无法显示,且数据结构不清晰
//            NSLog(@"%@",responseObject);
//            
//            //方法二 生成plist文件
//            //1. 查看responseObject的真实类型
//            NSLog(@"%@",[responseObject class]);
//            //2. 将响应体转换为真实类型
//            responseObject = (NSDictionary *)responseObject;
//            //3. 将响应体打印出来
//            [responseObject writeToFile:@"/Users/SketchK/Desktop/me.plist" atomically:YES];
//            NSLog(@"%@",responseObject[@"square_list"]);
            //将传入的字典数组转换为模型数组
            NSArray *classOfModel = [SQMeSquareModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            //根据模型数组创建footerView中的控件
            [weakSelf createInterfaceWithModelArray:classOfModel];
            

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            SQLOG(@"请求失败 - %@",error);
        }];
        
    }

    return self;
    
}

- (void)createInterfaceWithModelArray:(NSArray *)modelArray{
    //获取模型数据的个数
    NSInteger count = modelArray.count;
    
    //最大列数
    int maxColCount = 4;
    //设定button的宽高
    CGFloat buttonW = self.bounds.size.width / maxColCount;
    CGFloat buttonH = buttonW;
    
    //布局button
    for (int i = 0 ; i < count; i++) {
        //取模型数据
        SQMeSquareModel *modelData = modelArray[i];
        
        //创建s
        SQMeSquareButton *button = [SQMeSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置button的frame
        button.sq_x = (i % maxColCount) * buttonW;;
        button.sq_y = (i / maxColCount) * buttonH;
        button.sq_width = buttonW;
        button.sq_height = buttonH;
        
        //设置模型数据
        button.modelData = modelData;
        
//        //设置button的title
//        [button setTitle:modelData.name forState:UIControlStateNormal];
//        
//        //设置button的image
//        //方法一
////        //使用AFNetworking的UIButton+AFNetworking.h文件设置图片
////        [button setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:modelData.icon] placeholderImage:[UIImage imageNamed:@"chose_tag_close_icon"]];
//        //方法二
//        //使用SDWebImage的UIButton+WebCache.h文件设置图片
//        [button sd_setImageWithURL:[NSURL URLWithString:modelData.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"chose_tag_close_icon"]];
        
        
        [self addSubview:button];
        
    }
    
    //设置SQFooterView的高度
    self.sq_height = self.subviews.lastObject.sq_bottom;
    
    //设置MeViewController的contentSize
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    [tableView reloadData];
    
    
}

- (void)buttonClick:(SQMeSquareButton *)button{
    SQLOGFUNC;
    //获取button中保存的JSON数据
    SQMeSquareModel *modelData = button.modelData;
    
    if ([modelData.url hasPrefix:@"http"]) { // 利用webView加载url即可
        SQLOG(@"利用webView加载url");
    
        //获取TabBarController
        UITabBarController *tabelBarController = (SQTabBarController *)self.window.rootViewController;
        //获取NavigationController
        SQNavigationController *navigationController = tabelBarController.selectedViewController;
        
        //方法一使用自定义的WebViewController加载页面
        //push出WebViewController
        SQWebViewController *webViewController = [[SQWebViewController alloc] init];
        //加载navigationItem的title
        webViewController.navigationItem.title = button.currentTitle;
        //加载url
        webViewController.url = modelData.url;
        //push出webViewController
        [navigationController pushViewController:webViewController animated:YES];
        
//        //方法二使用SFSafariViewController加载页面
//        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:modelData.url]];
//        //在modal方式下能够显示进度条
//        [navigationController presentViewController:safariViewController animated:YES completion:nil];
//        //在push方式下不显示进度条
//        [navigationController pushViewController:safariViewController animated:YES];
        
    } else if ([modelData.url hasPrefix:@"mod"]) { // 另行处理
        if ([modelData.url hasSuffix:@"BDJ_To_Check"]) {
            SQLOG(@"跳转到[审帖]界面");
        } else if ([modelData.url hasSuffix:@"BDJ_To_RecentHot"]) {
            SQLOG(@"跳转到[每日排行]界面");
        } else {
            SQLOG(@"跳转到其他界面");
        }
    } else {
        SQLOG(@"不是http或者mod协议的");
    }
    
    
}

@end
