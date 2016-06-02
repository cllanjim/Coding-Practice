//
//  StatusViewModel.swift
//  0518 新浪微博(Swift)
//
//  Created by 张思琦 on 16/5/27.
//  Copyright © 2016年 SketchK. All rights reserved.
//

import UIKit

class StatusViewModel {
    
    //数据模型
    var statusModel: Status
    
    //构造方法
    init(status: Status){
        statusModel = status
    }
    
    //获取头像
    // 1.设置头像
    var avatarURL: NSURL?{
        return NSURL(string: statusModel.user?.profile_image_url ?? "")
    }
    
    //获取认证图标
    var verifiedImage: UIImage? {
        let type = statusModel.user?.verified_type ?? -1
        
        switch type {
        case 0:
            return UIImage(named: "avatar_vip")
        case 2, 3, 5:
            return UIImage(named: "avatar_enterprise_vip")
        case 220:
            return UIImage(named: "avatar_grassroot")
        default:
            return nil
        }
    }
    
    //获取会员昵称
    var screenNameStr: String? {
        return statusModel.user?.screen_name
    }
    
    //获取会员图标
    var vipImage: UIImage? {
        let rank = statusModel.user?.mbrank ?? 0
        if  rank > 0 && rank < 7 {
            return UIImage(named: "common_icon_membership_level\(rank)")
            //nameLabel.textColor = UIColor.orangeColor()
        }else {
            return nil
            //nameLabel.textColor = UIColor.lightGrayColor()
        }
    }
    
    //获取时间
    var timeStr: String? {
        //获取字符串
        guard let temp = statusModel.created_at else {
            return nil
        }
            //转换字符串为NSDate
        guard let createDate = NSDate.createDateWithString(temp) else {
            return nil
        }
        //根据NSDate与当前Date的情况,返回String
        return createDate.describeDate()
    }
    
    //获取来源
    var sourceStr: String? {
        
        guard let nsText: NSString = statusModel.source where nsText != "" else {
            return nil
        }
        // 1. 查找开始的位置
        let startIndex = nsText.rangeOfString(">").location + 1
        // 2.计算截取长度
        // 注意: rangeOfString方法默认是从前往后找, 只要找到一个就不继续查找了
        let length = nsText.rangeOfString("<", options: .BackwardsSearch).location - startIndex
        // 3.截取字符串
        let result = nsText.substringWithRange(NSMakeRange(startIndex, length))
        
        return "来自: " + (result as String)
    }
    
    
    //获取正文
    var contentStr: String? {
        return statusModel.text
    }
    
    /// 当前微博所有配图URL数组
    var thumbnail_urls: [NSURL]? {
        
        //安全校验
        //当有转发微博时,就返回转发微博的图像数组
        //当没有转发微博是,就返回微博的图像数组
        guard let array = statusModel.retweeted_status?.pic_urls ?? statusModel.pic_urls else {
            return nil
        }
        
        var models = [NSURL]()
        for pic in array {
            let url = NSURL(string: pic.thumbnail_pic ?? "")!
            models.append(url)
        }
        return models
    }
    
    var large_urls: [NSURL]? {
        //安全校验
        guard let array = statusModel.retweeted_status?.pic_urls ?? statusModel.pic_urls else {
            return nil
        }
        //创建用于保存转换后的url数组
        var large_url_Array = [NSURL]()
        //将原有小图的url转换成大图的url地址
        for pic in array {
            // 取出当前配图的url字符串
            guard var temp = pic.thumbnail_pic else {
                continue
            }
            
            //将当前url中的thumbnail替换为large
            temp = temp.stringByReplacingOccurrencesOfString("thumbnail", withString: "large")
            let large_url = NSURL(string: temp)!
            large_url_Array.append(large_url)
        }
        return large_url_Array
    }
}