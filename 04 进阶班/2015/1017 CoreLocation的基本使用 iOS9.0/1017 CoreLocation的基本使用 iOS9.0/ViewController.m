//
//  ViewController.m
//  1017 CoreLocation的基本使用 iOS9.0
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

    //1 设置代理
    self.locationManager.delegate = self;
    
    //2 设置授权请求
//    [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager requestAlwaysAuthorization];
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
//        self.locationManager.allowsBackgroundLocationUpdates = YES;
//    }
    
    //2 启动定位
    //只获取一次对应的定位信息
    [self.locationManager requestLocation];
//    [self.locationManager startUpdatingLocation];
}

#pragma mark - lazy 
- (CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager;
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"正在定位");
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败");
}

@end
