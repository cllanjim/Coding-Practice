//
//  ViewController.m
//  0726购物车
//
//  Created by 张思琦 on 15/7/26.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

#define iconNumber 6
#define iconHeight 80
#define iconWidth  60
#define colNumber 3
#define betweenRow 20

@interface ViewController ()

//保存图标的名字和图片名字
//@property (nonatomic,strong)NSArray *iconInfo;
@property (nonatomic, strong)NSMutableArray *iconInfo;

//保存当前的图片的序列号
@property (nonatomic, assign)int index;

//视图集合
@property (nonatomic, strong)UIView *groupIconView;

//addButton按钮
@property (nonatomic, strong)UIButton *addIcon;

//removeButton按钮
@property (nonatomic, strong)UIButton *removeIcon;

//作为指示器的Label控件
@property (strong, nonatomic) UILabel *coverLabel;

@end


/***************************   主要任务     *************************************/
//1.用代码生成界面
    //左右两个button图标
    //一个子view视图

//2.按钮的功能是
    //当点加号时,子view视图中增加一个视图集合
    //当点减号时,子view视图中减少一个视图集合

//3.注意点
    //按钮的禁止功能

/***************************        *************************************/

@implementation ViewController

#pragma mark - iconInfo的懒加载
- (NSArray *)iconInfo
{
    if (_iconInfo == nil) {

/******************************** 方法一 ***************************/
// 直接加载数据
//        NSArray *array = @[
//                           @{ @"name": @"单肩包",  @"imageName":@"danjianbao.png"},
//                           @{ @"name": @"链条包",  @"imageName":@"liantiaobao.png"},
//                           @{ @"name": @"钱包",   @"imageName":@"qianbao.png"},
//                           @{ @"name": @"手提包",  @"imageName":@"shoutibao.png"},
//                           @{ @"name": @"双肩包",  @"imageName":@"shuangjianbao.png"},
//                           @{ @"name": @"斜挎包",  @"imageName":@"xiekuabao.png"}
//                           ];
//        _iconInfo = array;
/********************************************************************/
   
/******************************** 方法二 ***************************/
////使用plist文件加载
////1.获取plist文件
//        //获取路径
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"iconInfo" ofType:@"plist"];
//        //根据路径生成Array
//        NSArray *classOfDict = [NSArray arrayWithContentsOfFile:path];
//        
////2.初始化参数
//        //用于接收根据模型转换后的对象的集合
//        NSMutableArray *classOfModel = [NSMutableArray array];
//        //plist中的对象
//        NSMutableDictionary *instanceOfDict =[NSMutableDictionary dictionary];
//        
//        //以下内容放到这里会出错的原因是:
//        //用于接收根据模型转换后的对象
//        //SQIconDateModel *instanceOfModel = [[SQIconDateModel alloc] init];
//
////3.读取plist文件的dict元素并赋值给SQIconDateModel模型中的实例对象
//        for (instanceOfDict in classOfDict)
//        {
//            //用于接收根据模型转换后的对象
//            SQIconDateModel *instanceOfModel = [[SQIconDateModel alloc] init];
//            
//            instanceOfModel.iconName = instanceOfDict[@"name"];
//            instanceOfModel.imageName = instanceOfDict[@"icon"];
//            
//            [classOfModel addObject:instanceOfModel];
//        }
//        
////4.将可变数组传递给自身属性iconInfo
//        _iconInfo = classOfModel;
        
/********************************************************************/

/******************************** 方法三 ***************************/
//        //不使用classOfModel直接将对象赋值给属性iconInfo
//        
//        //使用plist文件加载
//        //1.获取plist文件
//        //获取路径
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"iconInfo" ofType:@"plist"];
//        //根据路径生成Array
//        NSArray *classOfDict = [NSArray arrayWithContentsOfFile:path];
//        
//        //2.初始化参数
//        //plist中的对象
//        NSMutableDictionary *instanceOfDict =[NSMutableDictionary dictionary];
//        
//        //用于接收根据模型转换后的对象的集合
//        //一定要将自身属性先初始化才能使用,否则无法存储数据
//        self.iconInfo = [NSMutableArray array];
//        
//        
//        //3.读取plist文件的dict元素并赋值给SQIconDateModel模型中的实例对象
//        for (instanceOfDict in classOfDict)
//        {
//            //用于接收根据模型转换后的对象
//            SQIconDateModel *instanceOfModel = [[SQIconDateModel alloc] init];
//            
//            instanceOfModel.iconName = instanceOfDict[@"name"];
//            instanceOfModel.imageName = instanceOfDict[@"icon"];
//            
//            [_iconInfo addObject:instanceOfModel];
//        }
        
/********************************************************************/
  
/******************************** 方法四 ***************************/
//将类工厂方法和自定义构造方法封装到模型中后进行调用
    
        //不使用classOfModel直接将对象赋值给属性iconInfo
        
        //使用plist文件加载
        //1.获取plist文件
        //获取路径
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"iconInfo" ofType:@"plist"];
//        //根据路径生成Array
//        NSArray *classOfDict = [NSArray arrayWithContentsOfFile:path];
//        
//        //2.初始化参数
//        //plist中的对象
//        NSMutableDictionary *instanceOfDict =[NSMutableDictionary dictionary];
        //****************************************//
        //用于接收根据模型转换后的对象的集合
        //一定要将自身属性先初始化才能使用,否则无法存储数据
        //为什么一定要初始化??????????
        //self.iconInfo = [NSMutableArray array];
        //如果要在自身的属性里面添加值或者变量,一定要完成初始化
        //如果是将其他对象赋值的给自身的话,可以不初始化,但不建议这么做.
        //****************************************//
        
        
//        //3.读取plist文件的dict元素并赋值给SQIconDateModel模型中的实例对象
//        for (instanceOfDict in classOfDict)
//        {
//            //类工厂方法
//            //SQIconDateModel *instanceOfModel = [SQIconDateModel iconDateModel:instanceOfDict];
//            //自定义构造方法
//            SQIconDateModel *instanceOfModel = [[SQIconDateModel alloc] initWithDict:instanceOfDict];
//
//            [_iconInfo addObject:instanceOfModel];
//        }
/********************************************************************/
        
/******************************** 方法五 ***************************/
        
        //self.iconInfo = [NSMutableArray array];
        self.iconInfo = [SQIconDateModel groupOfModel];
        
        
/********************************************************************/
    }
    
    return _iconInfo;
    

}


#pragma mark - 软件的界面加载

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = -1;

    
//-------------------------------利用代码生成了两个Button按钮和view视图----------------------------//
//生成界面的两个button
    self.addIcon = [[UIButton alloc] initWithFrame:CGRectMake(30, 40, 60, 60)];
    [self.addIcon setImage:[UIImage imageNamed:@"add"]forState:UIControlStateNormal];
    [self.addIcon setImage:[UIImage imageNamed:@"add_disabled"] forState:UIControlStateDisabled];
    [self.addIcon setImage:[UIImage imageNamed:@"add_highlighted"] forState:UIControlStateHighlighted];
    [self.view addSubview:self.addIcon];
    //增加监听方法
    [self.addIcon addTarget:self action:@selector(addIconView) forControlEvents:UIControlEventTouchUpInside];
    
    self.removeIcon = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 90 , 40, 60, 60)];
    [self.removeIcon setImage:[UIImage imageNamed:@"remove"]forState:UIControlStateNormal];
    [self.removeIcon setImage:[UIImage imageNamed:@"remove_disabled"] forState:UIControlStateDisabled];
    [self.removeIcon setImage:[UIImage imageNamed:@"remove_highlighted"] forState:UIControlStateHighlighted];
    [self.view addSubview:self.removeIcon];
    //增加监听方法
    [self.removeIcon addTarget:self action:@selector(removeIconView) forControlEvents:UIControlEventTouchUpInside];
    
//生成界面的子view视图
    self.groupIconView = [[UIView alloc] initWithFrame:CGRectMake(30, 150, self.view.bounds.size.width - 60, self.view.bounds.size.width - 60)];
    
    self.groupIconView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.groupIconView];

//-----------------------------------------------------------------------------------------//

//循环生成i个iconView
    
//    //在x轴上将图片水平放置
//    int betweenCol = (_groupIconView.bounds.size.width - (colNumber * iconWidth))/(colNumber + 1);
    
    
//    for (int i = 0; i < iconNumber ; i++) {
//        //计算当前iconView的行和列
//        int row = i / colNumber;//0 1 2
//        int col = i % colNumber;//1 2 3
//        
//        
//        float iconViewX = betweenCol * (col + 1) + iconWidth * col ;
//        float iconViewY = betweenRow * (row + 1) + iconHeight * row;
//        
//        
//        //在groupIconView里生成iconView
//        UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(iconViewX, iconViewY, iconWidth, iconHeight)];
//        
//        iconView.backgroundColor = [UIColor lightGrayColor];
//        //iconView.backgroundColor = [UIColor purpleColor];
//        [_groupIconView addSubview:iconView];
//        
//        
//        //在iconView中生成imageView和Label
//        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconWidth, 60)];
//        //iconImage.backgroundColor = [UIColor yellowColor];
//        iconImage.image = [UIImage imageNamed:self.iconInfo[i][@"imageName"]];
//        [iconView addSubview:iconImage];
//                                  
//        UILabel *iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, iconWidth, 15)];
//        //iconLabel.backgroundColor = [UIColor greenColor];
//        iconLabel.text = [NSString stringWithFormat:@"%@", self.iconInfo[i][@"name"]];
//        [iconView addSubview:iconLabel];
//    }
    
    
//*****************************增加指示器*****************************//
    self.coverLabel = [[UILabel alloc] init];
    self.coverLabel.center = self.view.center;
    self.coverLabel.bounds = CGRectMake(0, 0, 150, 50);
    
    self.coverLabel.backgroundColor = [UIColor purpleColor];
    self.coverLabel.text = [NSString stringWithFormat:@"这是一个测试!"];
    self.coverLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [self.view addSubview:self.coverLabel];
    
    
    //首先将指示器调为隐藏
    self.coverLabel.hidden = YES;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - add键功能的实现
- (IBAction)addIconView
{
    //获取当前groupView中icon的数量
    self.index ++;
    int i = self.index;
    
    //在x轴上将图片水平放置
    int betweenCol = (self.groupIconView.bounds.size.width - (colNumber * iconWidth))/(colNumber + 1);
    
    //计算当前iconView的行和列
    int row = i / colNumber;//0 1 2
    int col = i % colNumber;//1 2 3
    
    
    float iconViewX = betweenCol * (col + 1) + iconWidth * col ;
    float iconViewY = betweenRow * (row + 1) + iconHeight * row;

    
    
/*************************************************************************************************/
//    //在代码中生成iconView和iconLabel
    //在groupIconView里生成iconView
    //UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(iconViewX, iconViewY, iconWidth, iconHeight)];
//
//    iconView.backgroundColor = [UIColor lightGrayColor];
//    iconView.tag = i;
//    //iconView.backgroundColor = [UIColor purpleColor];
//    [self.groupIconView addSubview:iconView];
//    
//    
//    //先初始化后赋值
////    SQIconDateModel *iconInfo = [[SQIconDateModel alloc] init];
////    iconInfo = self.iconInfo[i];
//    
//    //未初始化,直接赋值
//    //也可以使用
//    SQIconDateModel *iconInfo = self.iconInfo[i];
//    
//    //在iconView中生成imageView和Label
//    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconWidth, 60)];
//    //iconImage.backgroundColor = [UIColor yellowColor];
//    //方法一
//    //iconImage.image = [UIImage imageNamed:self.iconInfo[i][@"imageName"]];
//    //方法二
//    //iconImage.image = [UIImage imageNamed:iconInfo.imageName];
//    iconImage.image = iconInfo.iconImage;
//    
//    [iconView addSubview:iconImage];
//    
//    UILabel *iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, iconWidth, 15)];
//    //iconLabel.backgroundColor = [UIColor greenColor];
//    //方法一
//    //iconLabel.text = [NSString stringWithFormat:@"%@", self.iconInfo[i][@"name"]];
//    //方法二
//    iconLabel.text = iconInfo.iconName;
//    
//    [iconView addSubview:iconLabel];
/*************************************************************************************************/
    
/*************************************************************************************************/
//纯代码的情况下
//使用SQIconView生成视图
    //SQIconView *iconView = [[SQIconView alloc] init];
    
    
    SQIconView *iconView = [[SQIconView alloc] initWithIconDateModel:self.iconInfo[i]];

    iconView.frame =CGRectMake(iconViewX, iconViewY, iconWidth, iconHeight);
    [self.groupIconView addSubview:iconView];

    
//使用xib的情况下
    
    
    
    
/*************************************************************************************************/

//判断按钮的失效
    self.removeIcon.enabled = (self.groupIconView.subviews.count != 0);
    self.addIcon.enabled = (self.groupIconView.subviews.count != 6);
    
/*************************************************************************************************/
//判断指示器是否出现
    if (self.index == 5){
        self.coverLabel.hidden = NO ;
    }else{
        self.coverLabel.hidden = YES;
    }
    

}

#pragma mark - remove键功能的实现
- (IBAction)removeIconView
{
    if (self.index == 0){
        self.coverLabel.hidden = NO;
    }else{
        self.coverLabel.hidden = YES;
    }
    
    self.index--;
    [[self.groupIconView.subviews lastObject] removeFromSuperview];
    

    self.removeIcon.enabled = (self.groupIconView.subviews.count != 0);
    self.addIcon.enabled = (self.groupIconView.subviews.count != 6);
    
    
   
    
}

@end
