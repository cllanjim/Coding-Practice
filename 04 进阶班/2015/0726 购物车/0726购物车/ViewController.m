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

@property (nonatomic, strong)NSArray *iconInfo;

@property (nonatomic, strong)UIView *groupIconView;

@property (nonatomic, assign)int index;

@property (nonatomic, strong)UIButton *addIcon;

@property (nonatomic, strong)UIButton *removeIcon;

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
        NSArray *array = @[
                           @{ @"name": @"单肩包",  @"imageName":@"danjianbao.png"},
                           @{ @"name": @"链条包",  @"imageName":@"liantiaobao.png"},
                           @{ @"name": @"钱包",   @"imageName":@"qianbao.png"},
                           @{ @"name": @"手提包",  @"imageName":@"shoutibao.png"},
                           @{ @"name": @"双肩包",  @"imageName":@"shuangjianbao.png"},
                           @{ @"name": @"斜挎包",  @"imageName":@"xiekuabao.png"}
                           ];
        _iconInfo = array;
    }
    
    return _iconInfo;
    

}


#pragma mark - 软件的界面加载

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = -1;
    
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
    
    
    //在groupIconView里生成iconView
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(iconViewX, iconViewY, iconWidth, iconHeight)];
    
    iconView.backgroundColor = [UIColor lightGrayColor];
    iconView.tag = i;
    //iconView.backgroundColor = [UIColor purpleColor];
    [self.groupIconView addSubview:iconView];
    
    
    //在iconView中生成imageView和Label
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconWidth, 60)];
    //iconImage.backgroundColor = [UIColor yellowColor];
    iconImage.image = [UIImage imageNamed:self.iconInfo[i][@"imageName"]];
    [iconView addSubview:iconImage];
    
    UILabel *iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, iconWidth, 15)];
    //iconLabel.backgroundColor = [UIColor greenColor];
    iconLabel.text = [NSString stringWithFormat:@"%@", self.iconInfo[i][@"name"]];
    [iconView addSubview:iconLabel];

    
    self.removeIcon.enabled = (self.groupIconView.subviews.count != 0);
    self.addIcon.enabled = (self.groupIconView.subviews.count != 6);



}

#pragma mark - remove键功能的实现
- (IBAction)removeIconView
{
    self.index--;
    [[self.groupIconView.subviews lastObject] removeFromSuperview];
    

    self.removeIcon.enabled = (self.groupIconView.subviews.count != 0);
    self.addIcon.enabled = (self.groupIconView.subviews.count != 6);

    
}

@end
