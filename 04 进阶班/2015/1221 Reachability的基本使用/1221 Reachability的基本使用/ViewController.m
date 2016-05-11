//
//  ViewController.m
//  1221 Reachability的基本使用
//
//  Created by 张思琦 on 15/12/21.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, strong) Reachability *reachAbility;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1 创建Reachability对象,用于监听网络连接状态
    Reachability *reachAbility = [Reachability reachabilityForInternetConnection];
    self.reachAbility = reachAbility;
    //2 添加通知到系统中,通知名为kReachabilityChangedNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNetWorkStatus)  name:kReachabilityChangedNotification object:nil];
    //3 开始发送reachAbility的状态
    [self.reachAbility startNotifier];
    
}


- (void)getNetWorkStatus{
    if ([Reachability reachabilityForLocalWiFi].currentReachabilityStatus != NotReachable) {
        self.label.text = @"当前为WiFi";
        NSLog(@"当前为WiFi");
    }else if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus != NotReachable){
        NSLog(@"当前为手机网络");
        self.label.text = @"当前为手机网络";
    }else{
        NSLog(@"没有网络");
        self.label.text = @"没有网络";
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
