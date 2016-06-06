//
//  NSDate+Extension.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/27.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import Foundation

extension NSDate {

    /**
     根据字符串创建时间
     - parameter str: 时间字符串
     */
    class func createDateWithString(string: String) -> NSDate? {
        //1创建时间格式
        let formatter = NSDateFormatter()
        //2设置时间格式
        formatter.dateFormat = "EE MM dd HH:mm:ss Z yyyy"
        //3设置区域
        formatter.locale = NSLocale(localeIdentifier: "en")
        return formatter.dateFromString(string)
    }
    
    /**
     返回当前时间对象对应的字符串
     */
    func describeDate() -> String {
        //1创建时间格式
        let formatter = NSDateFormatter()
        //2设置区域
        formatter.locale = NSLocale(localeIdentifier: "en")
        //3创建日历类
        let calendar = NSCalendar.currentCalendar()
        //判断逻辑
        if calendar.isDateInToday(self){
            //判断是否是当天
            let comps = calendar.components([.Hour, .Second], fromDate: self, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
            if comps.hour > 1 {
                //多少小时前
                formatter.dateFormat = "HH小时前"
            }else if comps.minute > 1 {
                //多少分钟前
                formatter.dateFormat = "mm分钟以前"
            }else {
                //1分钟以前
                formatter.dateFormat = "刚刚"
            }

        }else if calendar.isDateInYesterday(self){
            //判断是否是昨天
            formatter.dateFormat = "昨天 HH:mm"
        }else {
            //判断是否为当年或其余年份
            let comp = calendar.components(.Year, fromDate: self, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
            if comp.year > 1 {
                //一年以外的时间
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
            }else {
                //一年以内
                formatter.dateFormat = "MM-dd HH:mm"
            }
        }
        //将时间转换为字符串
        return formatter.stringFromDate(self)
    }
    
}