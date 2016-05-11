//
//  main.m
//  0324 NSDate类的学习
//
//  Created by 张思琦 on 16/3/24.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
//        NSLog(@"Hello, World!");
        
//        NSDate *nowDate = [NSDate date];
//        NSLog(@"%@",nowDate);
        
        
        
//        //NSString对象 ----> NSDate对象
//        NSString *calDate = @"2015-03-14 13:00:00";
//        //创建NSDateFormatter对象
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        //设置dateFormatter对象的dateFormat格式
//        formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
//        //设置dateFormatter对象的时区
//        formatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
//        //利用dateFromString方法转换时间
//        NSDate *date = [formatter dateFromString:calDate];
//        
//        NSLog(@"%@",date);

/***********************************************/
        // 时间字符串
        NSString *string = @"周四 3月 24 14:44:00 +0800 2016";
        // 日期格式化类
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
        //设置时区
        fmt.timeZone = [NSTimeZone timeZoneWithName:@"CCT"];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
        NSDate *date = [fmt dateFromString:string];
        NSLog(@"date = %@",[fmt stringFromDate:date]);
        NSLog(@"date = %@",date);
/***********************************************/

        

//        //时间戳的概念
//        NSString *time = @"1";
//        NSTimeInterval second = time.longLongValue;
//        
//        //
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
//        NSLog(@"%@",date);
        
        
//        //NSDate对象 ----> NSString对象
//        NSDate *date = [NSDate date];
//        
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        dateFormatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
//        
//        NSString *string = [dateFormatter stringFromDate:date];
//        NSLog(@"%@",string);
        
        
//        //获取NSDate中的元素
//        NSString *string = @"2015-11-20 09:10:05";
//        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//        formatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
//        formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0000"];
//        NSDate *date = [formatter dateFromString:string];
//        
//        //创建NSCalendar对象
//        NSCalendar *calender = [NSCalendar currentCalendar];
//        //利用Calendar对象从NSDate对象里提取相应的元素
//        //获得单个元素
//        NSInteger year = [calender component:NSCalendarUnitYear fromDate:date];
//        NSInteger month = [calender component:NSCalendarUnitMonth fromDate:date];
//        //获得多个元素
//        NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
//        NSDateComponents *dateComponents = [calender components:unit fromDate:date];

        //比较两个日期的大小
        
        //比大小
//        NSString *string = @"2015-11-20 11:10:05";
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
//        
//        NSDate *date1 = [dateFormatter dateFromString:string];
//        NSLog(@"%@",[dateFormatter stringFromDate:date1]);
//        
//        NSDate *date2 = [NSDate date];
//        NSLog(@"%@",[dateFormatter stringFromDate:date2]);
//
//        NSComparisonResult result = [date1 compare:date2];
//        if (result == NSOrderedAscending) { // 升序, 越往右边越大
//            NSLog(@"createdAtDate > nowDate");
//        } else if (result == NSOrderedDescending) { // 降序, 越往右边越小
//            NSLog(@"createdAtDate < nowDate");
//        } else {
//            NSLog(@"createdAtDate == nowDate");
//        }

        
        //计算两个时间相差的秒数
//        NSString *string = @"2015-11-20 11:10:05";
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
//        NSDate *date1 = [dateFormatter dateFromString:string];
//        NSDate *date2 = [NSDate date];
//        
//        NSTimeInterval interval = [date1 timeIntervalSinceDate:date2];
//        
//        NSTimeInterval intervalWithNow = [date1 timeIntervalSinceNow];
//        NSTimeInterval intervalWith1970 = [date1 timeIntervalSince1970];
        
        //计算两个时间的间隔
        NSString *string1 = @"2015-11-20 11:10:05";
        NSString *string2 = @"2014-11-20 11:10:04";

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        NSDate *date1 = [dateFormatter dateFromString:string1];
        NSDate *date2 = [dateFormatter dateFromString:string2];
        
        NSCalendar *calendar = nil;
        if([[NSCalendar class] respondsToSelector:@selector(calendarWithIdentifier:)]){
            calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        }else{
            calendar = [NSCalendar currentCalendar];
        }
        
        NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        
        NSDateComponents *cmps = [calendar components:unit fromDate:date1 toDate:date2 options:0];
        
        NSLog(@"%@",cmps);
        
        
        
        
    
        
    }
    return 0;
}
