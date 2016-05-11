//
//  SQIconView.m
//  0726购物车
//
//  Created by 张思琦 on 15/7/27.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQIconView.h"

@interface SQIconView  ()

//没有连线的情况
//@property (nonatomic, strong)UIImageView *iconImage;
//@property (nonatomic, strong)UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *iconLabel;

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
//************************* 使用代码创建视图模型 *************************/
//    self = [super init];
//    if(self){
//        //iconView中添加一个UIImageVIew
//        _iconImage = [[UIImageView alloc] init];
//        //_iconImage.frame = CGRectMake(0, 0, 60, 60);
//        //_iconImage.backgroundColor = [UIColor redColor];
//        [self addSubview:_iconImage];
//        self.iconImage.image  = iconDateModel.iconImage;
//        
//        //iconView中添加一个UILabel
//        _iconLabel = [[UILabel alloc] init];
//        //_iconLabel.frame = CGRectMake(0, 65, 65, 15);
//       // _iconLabel.backgroundColor = [UIColor yellowColor];
//        [self addSubview:_iconLabel];
//        self.iconLabel.text = iconDateModel.iconName;
//        NSLog(@"%s",__func__);
//    }
//    
//    return self;
//}
//************************* 使用xib中的视图模型 *************************/
    self = [super init];
    if (self) {
        //方法一
        //获取xib所在的bundle路径
        //NSBundle类型是代表程序在文件系统中的确切位置
        //mainBundle的返回值为NSBundle类型,该方法用于确定当前程序在系统中的准确位置
        NSBundle *locationOfxib = [NSBundle mainBundle];
        //使用loadNidNamed:方法取出xib
        //loadNibNamed的参数代表需要取出xib文件名,不需要带后缀名
        //owner参数
        //options参数代表
        NSArray *groupView = [locationOfxib loadNibNamed:@"SQIconView" owner:nil options:nil];
        
        //方法二
        //UINib *nib = [UINib nibWithNibName:@"SQIconView" bundle:nil];
        //NSArray *groupView = [nib instantiateWithOwner:nil options:nil];
 
        
        //取出数组中的视图模型,当前xib中只有一个视图模型
        //注意的是,由于我们在xib的构建过程中,已经设定当前视图模型的类属于SQIconView类
        //所以self本身就等于了SQIconView类,取出对应的视图模型赋值给self本身
        self = [groupView lastObject];
        
        //取出实例对象后,利用传递的数据模型为实例对象赋值
        //self.iconLabel.text = iconDateModel.iconName;
        //self.iconImage.image = iconDateModel.iconImage;
        
        //由于本例已经为类设置了数据模型的属性,所以可以重写数据模型的set方法
        //使用iconDateModel的set方法自动为控件赋值
        //[self  setIconDateModel:iconDateModel];
        self.iconDateModel = iconDateModel;
        
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


//使用xib时不存在这样的问题
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    _iconImage.frame = CGRectMake(0, 0, self.frame.size.width, 60);
//    _iconLabel.frame = CGRectMake(0, 60, self.frame.size.width, 15);
//    NSLog(@"%s",__func__);
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
