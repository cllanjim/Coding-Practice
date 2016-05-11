//
//  SQCell.m
//  0915 不等高cell - frame搭建
//
//  Created by 张思琦 on 15/9/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQCell.h"


@interface SQCell ()

@property (nonatomic, strong) UILabel *name_Label;
@property (nonatomic, strong) UIImageView *user_ImageView;
@property (nonatomic, strong) UILabel *text_Label;
@property (nonatomic, strong) UIImageView *text_ImageView;
@property (nonatomic, strong) UIImageView *vip_ImageView;

@end


@implementation SQCell


//当tableView创建新的cell时会调用该方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     //创建子控件
        //用户名
        UILabel *name_Label = [[UILabel alloc] init];
        self.name_Label = name_Label;
        self.name_Label.font =[UIFont systemFontOfSize:17];
        [self.contentView addSubview:self.name_Label];
        //头像
        UIImageView *user_imageView = [[UIImageView alloc] init];
        self.user_ImageView = user_imageView;
        [self.contentView addSubview:self.user_ImageView];
        //文章
        UILabel *text_Label = [[UILabel alloc] init];
        self.text_Label = text_Label;
        self.text_Label.font = [UIFont systemFontOfSize:15];
        self.text_Label.numberOfLines = 0;
        [self.contentView addSubview:self.text_Label];
        //文章配图
        UIImageView *text_ImageView = [[UIImageView alloc] init];
        self.text_ImageView = text_ImageView;
        [self.contentView addSubview:self.text_ImageView];
        //VIP图像
        UIImageView *vip_ImageView = [[UIImageView alloc] init];
        self.vip_ImageView = vip_ImageView;
        [self.contentView addSubview:self.vip_ImageView];
    }
    return self;
}

//布局界面时调用
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.name_Label.frame = self.modelData.name_Label_frame;
    self.user_ImageView.frame = self.modelData.user_ImageView_frame;
    self.text_Label.frame = self.modelData.text_Label_frame;
    self.text_ImageView.frame = self.modelData.text_ImageView_frame;
    self.vip_ImageView.frame = self.modelData.vip_ImageView_frame;
}

//设置cell的模型数据
- (void)setModelData:(SQCellModel *)modelData{
    
    _modelData = modelData;
    
    self.name_Label.text = modelData.name_Label_text;
    self.user_ImageView.image = [UIImage imageNamed:modelData.user_ImageView_ImageName];
    self.text_Label.text = modelData.text_Label_text;
    
    //对VIP头像进行判断再进行赋值
    if (modelData.isVIP == YES) {
        self.vip_ImageView.hidden = NO;
        //设置VIP的字体和图像
        self.name_Label.textColor = [UIColor orangeColor];
        self.vip_ImageView.image = [UIImage imageNamed:@"vip"];
    }else{
        self.vip_ImageView.hidden =YES;
        //设置VIP的字体和图像
        self.name_Label.textColor = [UIColor blackColor];
        self.vip_ImageView.image = nil;
    }
    
    if (modelData.text_ImageView_ImageName) {
        self.text_ImageView.hidden = NO;
        self.text_ImageView.image = [UIImage imageNamed:modelData.text_ImageView_ImageName];
    }else{
        self.text_ImageView.hidden = YES;
    }
    
}


@end
