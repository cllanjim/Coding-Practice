//
//  DateTextField.m
//  1004 PickerView综合应用
//
//  Created by 张思琦 on 15/10/11.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "DateTextField.h"

@implementation DateTextField

#pragma mark - 初始化操作

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    };
    return self;

}

- (void)awakeFromNib{
    [self setUp];
}


-(void)setUp{

    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    
    //设置日期模式
    //UIDatePickerModeTime,    Displays hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. 6 | 53 | PM)
    //UIDatePickerModeDate,   Displays month, day, and year depending on the locale setting (e.g. November | 15 | 2007)
    //UIDatePickerModeDateAndTime,   Displays date, hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. Wed Nov 15 | 6 | 53 | PM)
    //UIDatePickerModeCountDownTimer,    Displays hour and minute (e.g. 1 | 53)
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    //设置地区
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    
    //创建日期
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [fmt dateFromString:@"1990-01-01"];
    //设置日期
    datePicker.date = date;
    //监听datePicker的变化
    //当设置Target-Action的监听模式时,action中传入的参数即为方法调用者
    //被监听后应该是被强引用了?
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    //设置textField弹出的界面为dataPicker
    self.inputView = datePicker;
    
}

- (void)dateChange:(UIDatePicker *)datePicker
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:datePicker.date];
    self.text = dateStr;

}

- (void)prepareForUse{
    [self dateChange:(UIDatePicker *)self.inputView];
}

@end
