//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


var string = "周四 3月 24 14:44:00 +0800 2016"
var fmt = NSDateFormatter();
fmt.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
fmt.timeZone = NSTimeZone(name: "CCT")
fmt.locale = NSLocale(localeIdentifier:"zh")
fmt.dateFromString(string);
let date = fmt.dateFromString(string)!
print(date)