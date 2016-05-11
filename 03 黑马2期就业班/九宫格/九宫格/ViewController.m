//
//  ViewController.m
//  九宫格
//
//  Created by 张思琦 on 15/7/14.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "GroupViewInfo.h"


@interface ViewController ()

//applist里包含了所有app的图像和文字说明
@property (nonatomic, strong) NSArray *applist;

@end

@implementation ViewController

//懒加载方法
- (NSArray *)applist
{
/*
//    if (_applist == nil) {
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"app.plist" ofType:nil];
//        _applist = [NSArray arrayWithContentsOfFile:path];
//    plist---->NSArray----->applist属性
//        
    
//        //取出plist中类的信息
//        //将plist看成是一群实例对象的集合(NSArray),也就是某个类,字典中的键代表该类的属性
//        //将plist中每个字典看成是一个具体的对象,字典中的值代表对象的实际值
//        
//        NSArray *modelClass = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"app.plist" ofType:nil]];
//        NSDictionary *modelInstance;
//        
//        
//        NSMutableArray *arrayOfGroupViewInfo = [NSMutableArray array];
//        
//        for ( modelInstance in modelClass) {
//            
//            //1.建立一个对象(instance)用于保存plist中实例对象的信息
//            GroupViewInfo *groupViewInfo = [[GroupViewInfo alloc] init];
//            
//            //2.将modelInstanc中的信息赋值到实例对象groupViewInfo中
//            groupViewInfo.name = modelInstance[@"name"];
//            groupViewInfo.icon = modelInstance[@"icon"];
//            
//            //3.将plist中的数据保存到一个数组中,数组中保存的是groupViewInfo类型的对象
//            [arrayOfGroupViewInfo addObject:groupViewInfo];
//        }
//    
//        //注意 原先的方法是将存有字典的数组返回给_applist属性
//        //使用字典转模型的思维方法后,是将存有groupViewInfo对象的数组返回给_applist属性
//        _applist = arrayOfGroupViewInfo;
//}
*/
    if (_applist == nil) {
        //1.取出plist中的数据
       // NSArray *classOfPlist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"app.plist" ofType:nil]];
        //NSDictionary *instanceOfPlist;
        
        //2.生成用于保存instacnOfModel的数组
        //NSMutableArray *classOfModel = [NSMutableArray array];
        
        //3.将plist里的实例参数赋值到model中对应的对象
        //for (instanceOfPlist in classOfPlist) {

          //  GroupViewInfo *instanceOfMoedl = [GroupViewInfo groupViewInfo:instanceOfPlist];
//            GroupViewInfo *instanceOfMoedl = [[GroupViewInfo alloc] init];
//            instanceOfMoedl.name = instanceOfPlist[@"name"];
//            instanceOfMoedl.icon = instanceOfPlist[@"icon"];
             
            //[classOfModel addObject:instanceOfMoedl];
    //};
    
        NSArray *classofModel =[GroupViewInfo classOfGroupViewInfo];
        _applist = classofModel;
         
    }

    return _applist;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
/*
//#define kViewWidth 60
//#define kViewHeight 80
//    
//#define kColNumber 4
//    
//#define kViewNumber 22
//    
//#define kViewStartY 20
//    
//    int kRowNumber;
//    if (0 == kViewNumber % kColNumber ) {
//        kRowNumber = kViewNumber/kColNumber;
//    }else{
//        kRowNumber = kViewNumber/kColNumber + 1;
//    }
//    
//    CGFloat betweenCol = (self.view.bounds.size.width - kColNumber * kViewWidth) / (kColNumber + 1);
//    CGFloat betweenRow = (self.view.bounds.size.height - kViewStartY - kRowNumber * kViewHeight)/kRowNumber;
//    
//    for (int i = 0; i < kViewNumber; i++) {
//        int rowOfIconView = i / kColNumber;
//        
//        int colOfIconView = i % kColNumber;
//        
//        CGFloat xOfIconView = (colOfIconView + 1) * betweenCol + colOfIconView * kViewWidth;
//        CGFloat yOfIconView = kViewStartY + rowOfIconView * kViewHeight + rowOfIconView * betweenRow;
//        
//        UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(xOfIconView, yOfIconView, kViewWidth, kViewHeight)];
//        
//        [iconView setBackgroundColor:[UIColor redColor]];
//        [self.view addSubview:iconView];
//        
//        //添加UIImageView控件,用于显示icon图像
//        UIImageView *iconWindow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 50)];
//        [iconWindow setBackgroundColor:[UIColor blueColor]];
//        
//        [iconView addSubview:iconWindow];
//        
//        //添加UILaber控件,用于显示icon的文字
//        UILabel *iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconWindow.frame), kViewWidth, 15)];
//        [iconLabel setBackgroundColor:[UIColor greenColor]];
//        
//        [iconView addSubview:iconLabel];
//        
//        
//        
//        //添加UIButton控件,用于显示下载按钮
//        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconLabel.frame), kViewWidth, 15)];
//        
//        [iconButton setBackgroundColor:[UIColor yellowColor]];
//        
//        [iconView addSubview:iconButton];
//        
//        
//        
//    };
*/
//在这里人工设定了循环次数的上限
int n = (int)self.applist.count;

#define kViewWidth  80
#define kViewHeight 100
    
#define kColNumber 4

#define kViewNumber n

#define kStartOrginY 20
    
    int kRowNumber;

    if (0 == kViewNumber % kColNumber) {
        kRowNumber = kViewNumber / kColNumber;
    }else
    {
        kRowNumber =kViewNumber / kColNumber + 1;
    }

    CGFloat kBetweenCol = (self.view.bounds.size.width - kColNumber * kViewWidth) / (kColNumber + 1);
    CGFloat kBetweenRow = (self.view.bounds.size.height - kStartOrginY - kRowNumber * kViewHeight)/ (kRowNumber);


    
    for (int i = 0; i < kViewNumber; i++) {
      //判断行
      int rowNumberOfGroupView = i / kColNumber;
      //判断列
      int colNumberOfGroupView = i % kColNumber;

      CGFloat xPositionOfGroupView = (colNumberOfGroupView + 1) * kBetweenCol +
                                     colNumberOfGroupView * kViewWidth;
      CGFloat yPositionOfGroupView = kStartOrginY +
                                     rowNumberOfGroupView * kBetweenRow +
                                     rowNumberOfGroupView * kViewHeight;

      UIImageView *groupImageView = [[UIImageView alloc]
          initWithFrame:CGRectMake(xPositionOfGroupView, yPositionOfGroupView,
                                   kViewWidth, kViewHeight)];
        //groupImageView.backgroundColor = [UIColor grayColor];
        [self.view addSubview:groupImageView];
        
        GroupViewInfo *groupViewInfo = [[GroupViewInfo alloc] init];
        groupViewInfo = _applist[i];
        
        //内部界面
        
        //设置iconImageView
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 60)];
        //iconImageView.backgroundColor = [UIColor redColor];
/*
   //方法1 ok
//        NSString *path = [NSString stringWithFormat:@"icon_%02i",i];
//        iconImageView.image = [UIImage imageNamed:path];
        
   //方法2 ok
        //一定要记住,循环次数不能超过app.plist里的数据数量
//        NSDictionary *iconInfo = self.applist[i];
//        iconImageView.image = [UIImage imageNamed:iconInfo[@"icon"]];
*/
//方法3 ok
        //iconImageView.image = [UIImage imageNamed:self.applist[i][@"icon"]];
        //iconImageView.image = [UIImage imageNamed:groupViewInfo.icon];
        iconImageView.image = groupViewInfo.iconImage;
        
        [iconImageView setContentMode:UIViewContentModeScaleAspectFit];
        
        [groupImageView addSubview:iconImageView];
        
     

        //设置iconLabel
        UILabel *iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconImageView.frame), kViewWidth, 20)];
        //iconLabel.backgroundColor = [UIColor blueColor];
        //[iconLabel setText:[NSString stringWithFormat:@"%@",self.applist[i][@"name"]]];
        
        iconLabel.text = groupViewInfo.name;
        [iconLabel setFont:[UIFont systemFontOfSize:13]];
        [iconLabel setTextAlignment:NSTextAlignmentCenter];
        
        [groupImageView addSubview:iconLabel];
        
        //设置iconButton
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconLabel.frame), kViewWidth, 20)];
        // iconButton.backgroundColor = [UIColor purpleColor];
        
        [iconButton setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
        [iconButton setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
        [iconButton setTitle:@"下载" forState:UIControlStateNormal];
        [iconButton setTitle:@"下载" forState:UIControlStateHighlighted];
        
        [iconButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [iconButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
         
        [groupImageView addSubview:iconButton];
        
        [iconButton addTarget:self action:@selector(clickIconButton:) forControlEvents:UIControlEventTouchDown];
    }
    
    
/*
//利用双for循环生成九宫格
 //#define kViewWidth 60
 //#define kViewHeight 80
 //
 //#define kColNumber 4
 //#define kRowNumber 3
 //
 //#define kViewNumber 10
 //
 //#define kViewStartY 20
 
//x轴上等间距
//CGFloat betweenCol = (self.view.bounds.size.width - kColNumber * kViewWidth) / (kColNumber + 1);
//CGFloat betweenRow = 10;
//    
//    for (int i = 0; i < kRowNumber; i++) {
//        
//        for (int j = 0; j < kColNumber; j++) {
//            
//            CGFloat xOfIconView = (j+1) * betweenCol + j * kViewWidth;
//            CGFloat yOfIconView = kViewStartY + i * kViewHeight + i * betweenRow;
//            
//            UIView *iconview = [[UIView alloc] initWithFrame:CGRectMake(xOfIconView, yOfIconView, 80, 90)];
//            
//            [iconview setBackgroundColor:[UIColor redColor]];
//            [self.view addSubview:iconview];
//        }
//       
//    }
 
//Y轴上等间距
//    CGFloat betweenCol = 10;
//    CGFloat betweenRow = (self.view.bounds.size.height - kViewStartY - kRowNumber * kViewHeight) / kRowNumber;
//    
//    for ( int i = 0; i < kRowNumber; i++) {
//        for (int j = 0; j < kColNumber; j++) {
//            
//            CGFloat xOfIconView = (j+1) * betweenCol + j * kViewWidth;
//            CGFloat yOfIconView = kViewStartY + i * kViewHeight + i * betweenRow;
//            
//            UIView *iconview = [[UIView alloc] initWithFrame:CGRectMake(xOfIconView, yOfIconView, 80, 90)];
//            
//            [iconview setBackgroundColor:[UIColor redColor]];
//            [self.view addSubview:iconview];
//            
//        }
//    }

//X,Y轴同时等间距
CGFloat betweenCol = (self.view.bounds.size.width - kColNumber * kViewWidth) / (kColNumber + 1);
//CGFloat betweenRow = (self.view.bounds.size.height - kViewStartY - kRowNumber * kViewHeight) / kRowNumber;
CGFloat betweenRow = (self.view.bounds.size.height - kViewStartY - kRowNumber * kViewHeight) / (kRowNumber + 1);
        for ( int i = 0; i < kRowNumber; i++) {
            for (int j = 0; j < kColNumber; j++) {
    
                CGFloat xOfIconView = (j+1) * betweenCol + j * kViewWidth;
                //CGFloat yOfIconView = kViewStartY + i * kViewHeight + i * betweenRow;
                CGFloat yOfIconView = kViewStartY + (i + 1) * betweenRow + i * kViewHeight;

                UIView *iconview = [[UIView alloc] initWithFrame:CGRectMake(xOfIconView, yOfIconView, kViewWidth, kViewHeight)];
    
                [iconview setBackgroundColor:[UIColor redColor]];
                [self.view addSubview:iconview];
                
            }
        }

//利用标准循环制作九宫格
//#define kViewWidth 60
//#define kViewHeight 80
//    
//#define kColNumber 4
//    
//#define kViewNumber 10
//    
//#define kViewStartY 20
//    
//    int kRowNumber;
//    if (0 == kViewNumber % kColNumber ) {
//        kRowNumber = kViewNumber/kColNumber;
//    }else{
//        kRowNumber = kViewNumber/kColNumber + 1;
//    }
//    
//    CGFloat betweenCol = (self.view.bounds.size.width - kColNumber * kViewWidth) / (kColNumber + 1);
//    //CGFloat betweenRow = (self.view.bounds.size.height - kViewStartY - kRowNumber * kViewHeight)/kRowNumber;
//    CGFloat betweenRow = (self.view.bounds.size.height - kViewStartY - kRowNumber * kViewHeight)/(kRowNumber + 1);
//    
//    for (int i = 0; i < kViewNumber; i++) {
//        int rowOfIconView = i / kColNumber;
//        
//        int colOfIconView = i % kColNumber;
//        
//        CGFloat xOfIconView = (colOfIconView + 1) * betweenCol + colOfIconView * kViewWidth;
//        //CGFloat yOfIconView = kViewStartY + rowOfIconView * kViewHeight + rowOfIconView * betweenRow;
//        CGFloat yOfIconView = kViewStartY + (rowOfIconView + 1) * betweenRow + rowOfIconView * kViewHeight;
//        
//        UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(xOfIconView, yOfIconView, kViewWidth, kViewHeight)];
//        
//        [iconView setBackgroundColor:[UIColor redColor]];
//        [self.view addSubview:iconView];
//
//    };

//人工生成方法
//方法一
//类工厂方法
//自定义构造方法
//UIView 只有一个自定义构造方法 initWithFrame:
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 80, 90)];
//    [view1 setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:view1];
*/
    
// Do any additional setup after loading the view, typically from a nib.

}



- (void)clickIconButton:(UIButton *)iconbutton
{
    //点击后生成一个Laber
    
    
    
    //禁用iconButton按钮
    
    
    
    //Label做动画
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
