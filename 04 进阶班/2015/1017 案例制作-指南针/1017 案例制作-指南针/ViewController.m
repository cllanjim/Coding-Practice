//
//  ViewController.m
//  1017 案例制作-指南针
//
//  Created by 张思琦 on 15/10/17.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *compasspointer;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取当前设备的朝向(磁力计传感器)
    [self.locationManager startUpdatingHeading];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy
- (CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

#pragma mark - CLLocationManagerDelegate
/**
 *  startUpdatingHeading被调用时,会调用该方法,作用是获取当前设备朝向
 *
 *  @param manager    触发方法的LocationManager
 *  @param newHeading 设备的朝向
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{

    /**
     *  CLHeading对象
     *  magneticHeading : 距离磁北方向的角度
     *  trueHeading : 距离真北方向的角度
     *  headingAccuracy : 如果这个值是负数, 那么代表角度不可用
     */
    
    //如果headingAccuracy是负数,则代表当前数值不可取
    if (newHeading.headingAccuracy < 0) {
        return;
    }
    
    //获取设备的磁北方向
    CLLocationDirection magneticHeading = newHeading.magneticHeading;
    
    //转换为弧度
    float angle = magneticHeading * (M_PI / 180);
    
    //图片做旋转
    [UIView animateWithDuration:0.5 animations:^{
        self.compasspointer.transform = CGAffineTransformMakeRotation(-angle);
    }];
    
    
}



@end
