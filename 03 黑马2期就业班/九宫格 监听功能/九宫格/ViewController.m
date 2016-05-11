//
//  ViewController.m
//  九宫格
//
//  Created by 张思琦 on 15/7/14.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "GroupViewInfo.h"


#define kViewWidth  80
#define kViewHeight 100
#define kColNumber 4
#define kStartOrginY 20

@interface ViewController ()

//applist里包含了所有app的图像和文字说明
@property (nonatomic, strong) NSArray *applist;

@end

@implementation ViewController

//懒加载方法
- (NSArray *)applist
{

    if (_applist == nil) {
        NSArray *classofModel =[GroupViewInfo classOfGroupViewInfo];
        _applist = classofModel;
    }
    return _applist;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//在这里人工设定了循环次数的上限


    
    int kRowNumber;

    if (0 == (int)self.applist.count % kColNumber) {
        kRowNumber = (int)self.applist.count / kColNumber;
    }else
    {
        kRowNumber =(int)self.applist.count / kColNumber + 1;
    }

    CGFloat kBetweenCol = (self.view.bounds.size.width - kColNumber * kViewWidth) / (kColNumber + 1);
    CGFloat kBetweenRow = (self.view.bounds.size.height - kStartOrginY - kRowNumber * kViewHeight)/ (kRowNumber);


    
    for (int i = 0; i < (int)self.applist.count; i++) {
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
        
        //UIImageView的交互功能默认是关闭的
       groupImageView.userInteractionEnabled = YES;
        
        [self.view addSubview:groupImageView];
        
        GroupViewInfo *groupViewInfo = [[GroupViewInfo alloc] init];
        groupViewInfo = _applist[i];
        
        //内部界面
        
        //1.设置iconImageView
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 60)];

        iconImageView.image = groupViewInfo.iconImage;
        
        [iconImageView setContentMode:UIViewContentModeScaleAspectFit];
        
        [groupImageView addSubview:iconImageView];
        
     

        //2.设置iconLabel
        UILabel *iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconImageView.frame), kViewWidth, 20)];
        
        iconLabel.text = groupViewInfo.name;
        [iconLabel setFont:[UIFont systemFontOfSize:13]];
        [iconLabel setTextAlignment:NSTextAlignmentCenter];
        
        [groupImageView addSubview:iconLabel];
        
        //3.设置iconButton
        UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconLabel.frame), kViewWidth, 20)];
        
        [iconButton setTag:i];
        
        [iconButton setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
        [iconButton setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
        
        [iconButton setTitle:@"下载" forState:UIControlStateNormal];
        [iconButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        
        [groupImageView addSubview:iconButton];
        
       [iconButton addTarget:self action:@selector(clickIconButton:) forControlEvents:UIControlEventTouchUpInside];
    }

}



- (void)clickIconButton:(UIButton *)iconbutton
{
    
    //测试
    NSLog(@"%s    %i", __func__, (int)iconbutton.tag);
    //点击后生成一个Laber
    UILabel *labelOfLoading = [[UILabel alloc] initWithFrame:CGRectMake(80, 400, 200, 50)];
    //labelOfLoading.backgroundColor = [UIColor redColor];
    labelOfLoading.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    
    
    GroupViewInfo *groupViewInfo = self.applist[iconbutton.tag];
    
    labelOfLoading.text = groupViewInfo.name;
    labelOfLoading.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:labelOfLoading];
    
    //禁用iconButton按钮
    //iconbutton
    
    //Label做动画
    
    //开始动画
    
    //首尾式动画
    //首尾式动画的启动条件是什么?
    //是不是必须要有一个相同的语句来启动?
//    labelOfLoading.alpha = 0.2;

//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.0f];
//    labelOfLoading.alpha = 1;
//    [UIView commitAnimations];
    
    iconbutton.enabled = NO;
    
    labelOfLoading.alpha = 0.2;
    
    [UIView animateWithDuration:2.0f animations:^{
        //动画最终达到的效果要求
        labelOfLoading.alpha = 1.0;
    } completion:^(BOOL finished) {     //该括号里是完成动画的动作
        
        [UIView animateWithDuration:1.0f animations:^{
            labelOfLoading.alpha = 0.0;
        } completion:^(BOOL finished) {
            [labelOfLoading removeFromSuperview];
            //如果将该button的交互关闭功能写在这里是,则是当动画完毕后才关闭交互,在动画期间还能交互
            //iconbutton.enabled = NO;

        }];
        
    }];
    
    
    
    
    //移除labelOfLoading
    
}



@end
