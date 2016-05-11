//
//  SQCellModel.m
//  0915 不等高cell - frame搭建
//
//  Created by 张思琦 on 15/9/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQCellModel.h"

@implementation SQCellModel

- (CGFloat)cellHeight{
    if (_cellHeight == 0) {
        
        
        //设置边距
        int margin = 10;
        
        //设置头像
        CGFloat user_ImageView_X = margin;
        CGFloat user_ImageView_Y = margin;
        CGFloat user_ImageView_W = 40;
        CGFloat user_ImageView_H = 40;
        self.user_ImageView_frame = CGRectMake(user_ImageView_X, user_ImageView_Y, user_ImageView_W, user_ImageView_H);
        
        //设置姓名
        CGFloat name_Label_X = CGRectGetMaxX(self.user_ImageView_frame) + margin;
        CGFloat name_Label_Y = margin;
        //姓名字体的属性
        NSDictionary *attr1 = @{
                                NSFontAttributeName :[UIFont systemFontOfSize:17],
                                };
        //根据设定的字体属性,计算一段NSString的Size值
        CGSize name_Label_Size = [self.name_Label_text sizeWithAttributes:attr1];
        self.name_Label_frame = CGRectMake(name_Label_X, name_Label_Y, name_Label_Size.width, name_Label_Size.height);
        
        //设置会员图标
        if (self.isVIP) {
            CGFloat vip_ImageView_X = CGRectGetMaxX(self.name_Label_frame) + margin;
            CGFloat vip_ImageView_Y = margin;
            CGFloat vip_ImageView_W = 14;
            CGFloat vip_ImageView_H = self.name_Label_frame.size.height;
            self.vip_ImageView_frame = CGRectMake(vip_ImageView_X, vip_ImageView_Y, vip_ImageView_W, vip_ImageView_H);
        }
        
        
        //设置正文
        CGFloat text_Label_X = margin;
        CGFloat text_Label_Y = CGRectGetMaxY(self.user_ImageView_frame) + margin;
        CGFloat text_Label_W = [UIScreen mainScreen].bounds.size.width - 2 * margin;
        //先假定一个最大的文本框
        CGSize text_Label_MAXSize = CGSizeMake(text_Label_W, MAXFLOAT);
        //姓名字体的属性
        NSDictionary *attr2 = @{
                                NSFontAttributeName :[UIFont systemFontOfSize:15],
                                };
        //boundingRectWithSize: options: attributes: context:方法是根据设定的字体属性,选项等参数,返回NSString的CGRect值
        //在初始化操作过程中,将该lable的行数设定为0,能够实现自动换行
        CGFloat text_Label_H = [self.text_Label_text boundingRectWithSize:text_Label_MAXSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr2 context:nil].size.height;
        self.text_Label_frame = CGRectMake(text_Label_X, text_Label_Y, text_Label_W, text_Label_H);
        
        
        //设置图片的位置
        if (self.text_ImageView_ImageName) {
            
            CGFloat text_imageView_X = margin;
            CGFloat text_imageView_Y = CGRectGetMaxY(self.text_Label_frame) + margin;
            CGFloat text_imageView_W = 100;
            CGFloat text_imageView_H = 100;
            self.text_ImageView_frame = CGRectMake(text_imageView_X, text_imageView_Y, text_imageView_W, text_imageView_H);
            
            _cellHeight = CGRectGetMaxY(self.text_ImageView_frame);
        }else{
            
            _cellHeight = CGRectGetMaxY(self.text_Label_frame);
            
        }
        
        _cellHeight += margin;
        
    }
    return _cellHeight;
    
}



@end
