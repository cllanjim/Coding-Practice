//
//  SQCommentHeaderFooterView.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/4/17.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQCommentHeaderFooterView.h"

@implementation SQCommentHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        //设置字体颜色
        self.textLabel.textColor = [UIColor lightGrayColor];
        self.contentView.backgroundColor = SQCommonBgColor;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //设置字体
    self.textLabel.font = SQCommentSectionHeaderFont;
    //设置文本框的frame
    self.textLabel.sq_x = SQCommonMargin;
}


@end
