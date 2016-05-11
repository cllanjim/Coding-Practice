//
//  SQMeCell.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/12/3.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQMeCell.h"

@implementation SQMeCell

//初始化操作
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //初始化的操作
        self.textLabel.textColor = [UIColor darkGrayColor];
//        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}
//布局操作
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //如果当前cell的图片为空就不进行调整
    if(self.imageView.image == nil){
        return;
    }
    
    //如果当前cell的图片存在的话,就会进入到下面的代码片段中
    self.imageView.sq_y = SQSmallCommonMargin;
    self.imageView.sq_height = self.contentView.sq_height - 2 * SQSmallCommonMargin;
    self.imageView.sq_width = self.imageView.sq_height;
    
    self.textLabel.sq_x = self.imageView.sq_right + SQCommonMargin;
}


@end
