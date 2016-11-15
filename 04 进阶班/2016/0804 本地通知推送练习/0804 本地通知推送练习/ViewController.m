//
//  ViewController.m
//  0804 本地通知推送练习
//
//  Created by 张思琦 on 16/8/4.
//  Copyright © 2016年 SQ-Studio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建操作行为
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
    action1.title = @"成功";
    action1.identifier = @"success";
    // 行为执行的必要状态
    action1.activationMode = UIUserNotificationActivationModeForeground;
    
    
    // 创建操作行为
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
    action2.title = @"失败";
    action2.identifier = @"failed";
    // 行为执行的必要状态
    action2.activationMode = UIUserNotificationActivationModeBackground;
    
    
    
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    category.identifier = @"Text";
    
    
    
    
    
    
    NSSet<UIUserNotificationCategory *> *categories = [NSSet setWithObjects: nil];
    
    /*获取发送通知的权限*/
    //创建通知的相关设置
    /*
     通知的几种类型
     UIUserNotificationTypeNone    = 0,      //
     UIUserNotificationTypeBadge   = 1 << 0, //
     UIUserNotificationTypeSound   = 1 << 1, //
     UIUserNotificationTypeAlert   = 1 << 2, //
     */
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:categories];
    //注册通知的相关设置
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    
    
    
    
    
    
    /*创建具体的通知*/
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    //设置通知的内容主体
    notification.alertBody = @"思琦,要喝水喽";
    //设置通知的推送时间
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:6];
    //设置通知的时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    
    //通知的其他属性
    //localNotice.repeatInterval = NSCalendarUnitMinute;

    //在锁屏状况下,通知的相关属性
    notification.alertTitle = @"提醒喝水";

    // 滑动后面的文字
    notification.hasAction = YES;
    notification.alertAction = @"不喝水对身体不好";
    
    // 设置启动图(任何情况下都读取LaunchImage文件)
    notification.alertLaunchImage = @"abc";
    

    
    /*发送通知*/
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    
//    /*取消通知*/
//    //取消全部通知
//    [[UIApplication sharedApplication] cancelAllLocalNotifications];
//    //取消单个通知
//    [[UIApplication sharedApplication] cancelLocalNotification:notification];
    
    NSArray<UILocalNotification *> * notificationsArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}

@end
