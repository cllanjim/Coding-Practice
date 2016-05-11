//
//  NSCalendar+SQCalendarExtension.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/25.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "NSCalendar+SQCalendarExtension.h"

@implementation NSCalendar (SQCalendarExtension)

+ (instancetype)sq_calendar{
    //由于[NSCalendar currentCalendar]会出现一些莫名崩溃的情况
    //所以要进行相应的修正
    if([[self class] respondsToSelector:@selector(calendarWithIdentifier:)]){
        //对于可以响应calendarWithIdentifier:的方法,才有calendarWithIdentifier:的方法创建Calendar对象
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else{
        //否则使用currentCalendar方法创建
        return [NSCalendar currentCalendar];
    }
}

@end
