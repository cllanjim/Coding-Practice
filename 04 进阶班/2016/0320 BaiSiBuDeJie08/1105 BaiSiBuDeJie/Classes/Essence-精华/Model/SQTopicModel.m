//
//  SQTopicModel.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/18.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQTopicModel.h"
#import <MJExtension.h>

@interface SQTopicModel()

@property (nonatomic, strong) NSDateFormatter *fmt;
@property (nonatomic, strong) NSCalendar *cal;

@end

@implementation SQTopicModel


//+ (NSDictionary *)mj_objectClassInArray{
//    return @{@"top_cmt" : [SQCommentModel class]};
//}

/************** 使用懒方法加载   *****************/
#pragma mark - lazy
- (NSDateFormatter *)fmt{
    if (_fmt == nil) {
        _fmt = [[NSDateFormatter alloc] init];
    }
    return _fmt;
}

- (NSCalendar *)cal{
    if (_cal == nil) {
        _cal = [NSCalendar sq_calendar];
    }
    return _cal;
}

#pragma mark - 重写created_at的get方法
- (NSString *)created_at{
    //设置NSDateFormatter对象
    //设置dateFormat
    self.fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //设置TimeZone
    //设置Local
    
    
    //获取NSDate对象
    NSDate *date = [self.fmt dateFromString:_created_at];
    
    //判断当前时间
    if (date.sq_isThisYear){//为今年
        if (date.sq_isToday) {//是否为当天
            //创建Calendar对象
            NSCalendar *calendar = [NSCalendar sq_calendar];
            //在self.dateFormat的规则下,转换当前时间
            NSString *nowDateString = [self.fmt stringFromDate:[NSDate date]];
            NSDate *nowDate = [self.fmt dateFromString:nowDateString];
        
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmp = [calendar components:unit fromDate:date toDate:nowDate options:0];
            
            if (cmp.hour >= 1) { // 时间间隔 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmp.hour];
            } else if (cmp.minute >= 1) { // 1小时 > 时间间隔 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmp.minute];
            } else { // 1分钟 > 分钟
                return @"刚刚";
            }
        
        }else if (date.sq_isYesterday){//是否为昨天
            self.fmt.dateFormat = @"'昨天' HH:mm:ss";
            return [self.fmt stringFromDate:date];
        }else {//其他
            self.fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [self.fmt stringFromDate:date];
        }
        
    }else {//不为今年
        return [self.fmt stringFromDate:date];
    }
    
}



#pragma mark - 重写cellHeight的get方法

@end
