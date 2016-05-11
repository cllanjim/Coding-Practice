//
//  SQIconView.m
//  0726购物车
//
//  Created by 张思琦 on 15/7/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQIconView.h"

@interface SQIconView  ()

@property (nonatomic, strong)UIImageView *iconImage;
@property (nonatomic, strong)UILabel *iconLabel;

@end


@implementation SQIconView

//重写init方法(因为要传入参数后赋值,生成的对象才有意义,所以重写init方法没有意义可忽略)
//- (instancetype)init{
//    self = [super init];
//    if(self)
//    {
///*************************************************************************************************/
////虽然这样可以初始化控件,但以后没法对控件里的属性进行操作
////应该给属性赋值
////        //iconView中添加一个UIImageVIew
////        UIImageView *iconImage = [[UIImageView alloc] init];
////        iconImage.frame = CGRectMake(0, 0, 60, 60);
////        iconImage.backgroundColor = [UIColor redColor];
////        //添加图片
////        
////        [self addSubview:iconImage];
////        
////        //iconView中添加一个UILabel
////        UILabel *iconLabel = [[UILabel alloc] init];
////        iconLabel.frame = CGRectMake(0, 65, 60, 15);
////        iconLabel.backgroundColor = [UIColor yellowColor];
////        //添加文字
////        
////        [self addSubview:iconLabel];
///*************************************************************************************************/
//        //iconView中添加一个UIImageVIew
//        _iconImage = [[UIImageView alloc] init];
//        _iconImage.frame = CGRectMake(0, 0, 60, 60);
//        _iconImage.backgroundColor = [UIColor redColor];
//        [self addSubview:_iconImage];
//        
//        //iconView中添加一个UILabel
//        _iconLabel = [[UILabel alloc] init];
//        _iconLabel.frame = CGRectMake(0, 65, 65, 15);
//        _iconLabel.backgroundColor = [UIColor yellowColor];
//        [self addSubview:_iconLabel];
///*************************************************************************************************/
//        
//    }
//    return self;
//}

- (instancetype)initWithIconDateModel:(SQIconDateModel *)iconDateModel
{
    self = [super init];
    if(self){
        //iconView中添加一个UIImageVIew
        _iconImage = [[UIImageView alloc] init];
        //_iconImage.frame = CGRectMake(0, 0, 60, 60);
        //_iconImage.backgroundColor = [UIColor redColor];
        [self addSubview:_iconImage];
        self.iconImage.image  = iconDateModel.iconImage;
        
        //iconView中添加一个UILabel
        _iconLabel = [[UILabel alloc] init];
        //_iconLabel.frame = CGRectMake(0, 65, 65, 15);
       // _iconLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:_iconLabel];
        self.iconLabel.text = iconDateModel.iconName;
        NSLog(@"%s",__func__);

    }
    
    return self;
}

//重写类工厂方法
+ (instancetype)iconViewWithIconDateMoedl:(SQIconDateModel *)iconDateModel
{
    return [[self alloc] initWithIconDateModel:iconDateModel];
}


//重写iconDateModel的set方法,使其能够被赋值的同时,给其余的两个属性赋值,将关键属性封装
- (void)setIconDateModel:(SQIconDateModel *)iconDateModel
{
    _iconDateModel = iconDateModel;
    
    self.iconImage.image  = iconDateModel.iconImage;
    self.iconLabel.text = iconDateModel.iconName;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _iconImage.frame = CGRectMake(0, 0, self.frame.size.width, 60);
    _iconLabel.frame = CGRectMake(0, 60, self.frame.size.width, 15);
    NSLog(@"%s",__func__);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
