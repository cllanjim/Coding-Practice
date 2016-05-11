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
- (CGFloat)cellHeight{
    
    // 如果cell的高度已经计算过, 就直接返回
    if (_cellHeight) return _cellHeight;
    
    //头像部份控件
    //顶部留白 + 头像高度 + 头像底部留白
    _cellHeight = SQCommonMargin + 35 + SQCommonMargin;
    
    //文字部分控件
    //获取屏幕宽度
    CGFloat textMaxWidth = [UIScreen mainScreen].bounds.size.width - 2 * SQCommonMargin;
    //文字部分的预置size
    CGSize textMaxSize = CGSizeMake(textMaxWidth, MAXFLOAT);
    
    //方法一 已被废弃
//    CGSize textSize = [self.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:textMaxSize];
//    //文本控件的高度 + 文本控件底部的留白
//    _cellHeight += textSize.height + SQCommonMargin;
    
    //方法二
    CGRect textRect = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]} context:nil];
    //文本控件的高度 + 文本控件底部的留白
    _cellHeight += textRect.size.height + SQCommonMargin;
    
    //中间的控件部分
    if (self.type != SQTopicTypeWord) {//如果当前帖子是非纯文字帖时,需要加入中间部分的高度
        
//        CGFloat contentW = textMaxWidth;

        //按照图片原始尺寸比,计算在屏幕最大宽度下的图片高度
        CGFloat contentH = textMaxWidth * self.height / self.width;
        
        //如图图片尺寸超过设定值,就令其等于cell的最大高度,并标注其为bigPicture
        if(contentH > SQMaxCellHeight){
            contentH = 200;
            //如果超出预先设定值就将该图片设定为大图片
            self.bigPicture = YES;
        }
        
        //保存中间控件的frame值
        self.contentFrame = CGRectMake(SQCommonMargin, _cellHeight, textMaxWidth , contentH);
        //中间控件的高度 + 中间控件底部的留白
        _cellHeight += contentH + SQCommonMargin;

    }
    
    //最热评论部分
    if (self.top_cmt) {//如果不为空,就代表有最热评论数据
        //最热评论模块的标题
        _cellHeight += 20;
        //最热评论模块的内容
        NSString *username = self.top_cmt.user.username;
        NSString *content = (self.top_cmt.voiceuri.length != 0) ? @"语音评论": self.top_cmt.content;
        NSString *topComment = [NSString stringWithFormat:@"%@ : %@", username, content];
        
        //计算文本高度
        CGRect topCommentRect = [topComment boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil];
        
        //最热评论文字部分的内容 + 底部留白
        _cellHeight += topCommentRect.size.height + SQCommonMargin;
        
    }
    
    //底部工具条
    //由于在设定cell时减去了高度10,所以在设定高度的时候要加上10
    _cellHeight += 35 + SQCommonMargin;
    

    return _cellHeight;
}


@end
