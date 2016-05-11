//
//  ViewController.m
//  1017 CoreLocation的使用 iOS 8.0
//
//  Created by 张思琦 on 15/10/17.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //1 创建CLLocationManager对象
    
    //2 设置对象的代理
    self.locationManager.delegate = self;
    
    
    /******************* iOS 8.0系统的适配方法 **************/
    if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
    //3 设置请求
    //设置前台请求
//    [self.locationManager requestWhenInUseAuthorization];
    //设置前后台请求
    [self.locationManager requestAlwaysAuthorization];
    //同时在info.plist文件中设置对应的key
    }
    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    //4 开始进行定位
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark - lazy
- (CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"开始定位");
}

/**
 *  当前定位功能的授权发生变化时会调用
 *
 *  @param manager 触发该方法的LocationManager
 *  @param status  当前LocationManager的授权状态
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            //用户没有决定的状态
            NSLog(@"kCLAuthorizationStatusNotDetermined");
            break;
        }
        case kCLAuthorizationStatusRestricted: {
            //状态受限制的情况 系统预留
            NSLog(@"kCLAuthorizationStatusRestricted");
            break;
        }
        case kCLAuthorizationStatusDenied: {
            //用户已经决定的状态
            NSLog(@"kCLAuthorizationStatusDenied");
            //如果当前定位服务功能是开启状态
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"用户已经拒绝使用定位功能");
                //自动跳转至定位服务功能界面
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }else{
                NSLog(@"定位服务功能被关闭");
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways: {
            //用户同意前后台使用的时候授权
            //与 kCLAuthorizationStatusAuthorized 相同
            NSLog(@"kCLAuthorizationStatusAuthorizedAlways");

            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            //用户同意前台使用的时候授权
            NSLog(@"kCLAuthorizationStatusAuthorizedWhenInUse");
            break;
        }
        default: {
            break;
        }
    }
}

@end
