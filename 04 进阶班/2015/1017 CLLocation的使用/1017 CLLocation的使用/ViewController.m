//
//  ViewController.m
//  1017 CLLocation的使用
//
//  Created by 张思琦 on 15/10/17.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *lastLocation;

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
    
    //2 设置前后台使用请求
    [self.locationManager requestAlwaysAuthorization];
    //配置key
    
    //3 启动定位服务
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
    
    //locations数组中的信息是按照时间顺序进行排序,所以最新的地址信息排列在数组的末位
    CLLocation *loaction = [locations lastObject];
    NSLog(@"%@",loaction);
    
    //当verticalAccuracy和horizontalAccuracy的值小于0时说明当前数据无效,应当直接退出
//    if ((loaction.verticalAccuracy < 0) || (loaction.horizontalAccuracy < 0) ) {
//        return;
//    }
    if (loaction.horizontalAccuracy < 0) {
        return;
    }
    //打印当前用户的行走方向,偏离角度以及对应的行走距离
    
    //计算行走方向
    //当direction = 0 北偏东
    //当direction = 1 东偏南
    //当direction = 2 南偏西
    //当direction = 3 西偏北
    
    NSInteger directionNumber = (int)loaction.course / 90;
    NSArray *directionGroup = @[@"北偏东", @"东偏南", @"南偏西", @"西偏北"];
    NSString *direction = directionGroup[directionNumber];
    
    /*
     NSString *direction = [NSString string];
     switch (directionNumber) {
     case 0:
     direction = @"北偏东";
     break;
     case 1:
     direction = @"东偏南";
     break;
     case 2:
     direction = @"南偏西";
     break;
     case 3:
     direction = @"西偏北";
     break;
     default:
     break;
     }
     */
    
    //计算偏离角度
    NSInteger angle = (int)loaction.course % 90;
    
    if (angle == 0) {
        //方向为正方向,需要修改原方向字符
        //去除原方向中后两个文字
        direction = [direction substringToIndex:1];
        //在剩余的字符中起始位置添加正字
        direction = [@"正" stringByAppendingString:direction];
    }
    
    //计算行走距离
    CGFloat distance = 0;
    if (self.lastLocation != nil) {
        distance = [loaction distanceFromLocation:self.lastLocation];
    }
    self.lastLocation = loaction;
    
    
    //打印输出结果
    NSString *notice;
    if (angle == 0 ) {
        notice = [NSString stringWithFormat:@"%@方向----移动%f米", direction, distance];
    }else{
        notice = [NSString stringWithFormat:@"%@ %zd度 方向 移动%f米",direction, angle, distance];
    }
    
    NSLog(@"%@", notice);
    
}


@end
