//
//  ViewController.m
//  1017 CoreLocation的基本使用 iOS 8.0之前
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

#pragma mark - lazy
- (CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        //创建LocationManager对象
        _locationManager = [[CLLocationManager alloc] init];
        //为LocationManager设置代理
        self.locationManager.delegate = self;
        
        //设置LocationManager的参数
        
        //设置过滤距离,即超过指定距离后才通过代理方法告诉外界
//        _locationManager.distanceFilter = 100;
        
        //设置定位精度
//        kCLLocationAccuracyBestForNavigation  适合导航;
//        kCLLocationAccuracyBest               精确度最高;
//        kCLLocationAccuracyNearestTenMeters   精确度在10m左右;
//        kCLLocationAccuracyHundredMeters;     精确度在100m左右
//        kCLLocationAccuracyKilometer;         精确度在1000m左右
//        kCLLocationAccuracyThreeKilometers;   精确度在3000m左右
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        
    }
    return _locationManager;
}


#pragma mark - 测试方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //启动地图定位功能
    //标准位置变化的定位功能
    [self.locationManager startUpdatingLocation];
    //显著位置变化的定位功能
//    [self.locationManager startMonitoringSignificantLocationChanges];
}


#pragma mark - 代理方法
/**
 *  当开启starUpdatingLocation后会调用以下代理方法
 *
 *  @param manager   触发该方法的LocationManager
 *  @param locations 当前的位置信息
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"正在跑步");
}

@end
