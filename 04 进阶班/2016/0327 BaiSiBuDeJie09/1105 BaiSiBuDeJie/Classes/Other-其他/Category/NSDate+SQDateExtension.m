//
//  NSDate+SQDateExtension.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/25.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "NSDate+SQDateExtension.h"

@implementation NSDate (SQDateExtension)

/**
 *  是否为今年
 */
- (BOOL)sq_isThisYear{
    //创建Calendar对象
    NSCalendar *calendar = [NSCalendar sq_calendar];
    
    //获取年元素
    NSInteger selfElementofYear = [calendar component:NSCalendarUnitYear fromDate:self];
    NSInteger nowElementofYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    //判断两个年份是否相等
    return (selfElementofYear == nowElementofYear);
}

/**
 *  是否为今天
 */
- (BOOL)sq_isToday{
    //在同一个标准下,将两个时间值转换为NSDate对象
    //创建NSDateFormatter对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //使用同一个DateFormatter进行一次转换和反转,防止设置上出现区别
    //转换成NSString
    NSString *selfDateString = [fmt stringFromDate:self];
    NSString *nowDateString = [fmt stringFromDate:[NSDate date]];
    //反转成NSDate
    NSDate *selfDate = [fmt dateFromString:selfDateString];
    NSDate *nowDate = [fmt dateFromString:nowDateString];
    
    //利用NSCalendar对象,计算两个时间值的差
    //创建NSCalendar对象
    NSCalendar *calendar = [NSCalendar sq_calendar];
    //获取年月日
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmp = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    //yaar, month, day中的值为0
    BOOL result = (cmp.year == 0 && cmp.month == 0 && cmp.day == 0);

    return result;
}


/**
 *  是否为昨天
 */
- (BOOL)sq_isYesterday{
    //在同一个标准下,将两个时间值转换为NSDate对象
    //创建NSDateFormatter对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //使用同一个DateFormatter进行一次转换和反转,防止设置上出现区别
    //转换成NSString
    NSString *selfDateString = [fmt stringFromDate:self];
    NSString *nowDateString = [fmt stringFromDate:[NSDate date]];
    //反转成NSDate
    NSDate *selfDate = [fmt dateFromString:selfDateString];
    NSDate *nowDate = [fmt dateFromString:nowDateString];
    
    //利用NSCalendar对象,计算两个时间值的差
    //创建NSCalendar对象
    NSCalendar *calendar = [NSCalendar sq_calendar];
    //获取年月日
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmp = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    BOOL result = (cmp.year == 0 && cmp.month == 0 && cmp.day == 1);

    return result;
}


/**
 *  是否为明天
 */
- (BOOL)sq_isTomorrow{
    //在同一个标准下,将两个时间值转换为NSDate对象
    //创建NSDateFormatter对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //使用同一个DateFormatter进行一次转换和反转,防止设置上出现区别
    //转换成NSString
    NSString *selfDateString = [fmt stringFromDate:self];
    NSString *nowDateString = [fmt stringFromDate:[NSDate date]];
    //反转成NSDate
    NSDate *selfDate = [fmt dateFromString:selfDateString];
    NSDate *nowDate = [fmt dateFromString:nowDateString];
    
    //利用NSCalendar对象,计算两个时间值的差
    //创建NSCalendar对象
    NSCalendar *calendar = [NSCalendar sq_calendar];
    //获取年月日
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmp = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    BOOL result = (cmp.year == 0 && cmp.month == 0 && cmp.day == -1);
    return result;
}

@end
