//
//  ViewController.m
//  九宫格
//
//  Created by 张思琦 on 15/7/14.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "GroupViewInfo.h"       //groupView的数据模型
#import "GroupView.h"           //groupView的视图模型

#define kViewWidth  80
#define kViewHeight 100
#define kColNumber 4
#define kStartOrginY 20

@interface ViewController ()

@property (nonatomic, strong) NSArray *applist;

@end

@implementation ViewController

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
      int rowNumberOfGroupView = i / kColNumber;
      int colNumberOfGroupView = i % kColNumber;

      CGFloat xPositionOfGroupView = (colNumberOfGroupView + 1) * kBetweenCol +
                                     colNumberOfGroupView * kViewWidth;
      CGFloat yPositionOfGroupView = kStartOrginY +
                                     rowNumberOfGroupView * kBetweenRow +
                                     rowNumberOfGroupView * kViewHeight;

        //XLB里保存的是各种UI元素的信息
        NSArray *classOfUIElementInXLB = [[NSBundle mainBundle] loadNibNamed:@"GroupView" owner:nil options:nil];
        //当前问题中,第一个UI元素的属性是UIView,所以用UIView接受,这个UIView是当前问题中的标准模板
        GroupView *exampleOfGroupView = [classOfUIElementInXLB firstObject];
        //UIView *exampleOfGroupView= [classOfUIElementInXLB firstObject];
        
        //将模板赋值给groupViews
        //UIView *groupViews = exampleOfGroupView;
        //groupViews.frame = CGRectMake(xPositionOfGroupView, yPositionOfGroupView,kViewWidth, kViewHeight);
        exampleOfGroupView.frame = CGRectMake(xPositionOfGroupView, yPositionOfGroupView,kViewWidth, kViewHeight);

        
        //将groupView添加到view中
        //[self.view addSubview:groupViews];
        [self.view addSubview:exampleOfGroupView];

        
//        GroupViewInfo *groupViewInfo = _applist[i];
//        exampleOfGroupView.groupViewInfo = groupViewInfo;
        exampleOfGroupView.groupViewInfo = _applist[i];
        
        
        //生成UIImageView
        //在界面生成一个UIImageView,该控件与example中的View下的UIImageVIew属性相同
        //UIImageView *iconImageView = exampleOfGroupView.subviews[0];
        
        //UIImageView *iconImageView = exampleOfGroupView.iconImageView;
        
        //iconImageView.image = groupViewInfo.iconImage;
        
        //XLB模型
       // exampleOfGroupView.iconImageView.image = groupViewInfo.iconImage;
        
        //UILabel
        //在界面生成一个UILabel,该控件与example中的View下的UILabel属性相同
//        UILabel *iconLabel = exampleOfGroupView.subviews[1];
//        iconLabel.text = groupViewInfo.name;
        
        //XLB模型
       // exampleOfGroupView.iconLabel.text = groupViewInfo.name;
        
        //UIButton
        //在界面生成一个UIButten,该控件与example中的View下的UIButten属性相同
        
        
        
        //UIButton *iconButton = exampleOfGroupView.subviews[2];
        
//        [iconButton setTag:i];
//        [iconButton addTarget:self action:@selector(clickIconButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//- (void)clickIconButton:(UIButton *)iconbutton
//{
//    
//    NSLog(@"%s    %i", __func__, (int)iconbutton.tag);
//    UILabel *labelOfLoading = [[UILabel alloc] initWithFrame:CGRectMake(80, 400, 200, 50)];
//    labelOfLoading.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
//    
//    GroupViewInfo *groupViewInfo = self.applist[iconbutton.tag];
//    
//    labelOfLoading.text = groupViewInfo.name;
//    labelOfLoading.textAlignment = NSTextAlignmentCenter;
//    
//    [self.view addSubview:labelOfLoading];
//    
//    iconbutton.enabled = NO;
//    
//    labelOfLoading.alpha = 0.2;
//    
//    [UIView animateWithDuration:2.0f animations:^{
//        labelOfLoading.alpha = 1.0;
//    } completion:^(BOOL finished) {
//                [UIView animateWithDuration:1.0f animations:^{
//            labelOfLoading.alpha = 0.0;
//        } completion:^(BOOL finished) {
//            [labelOfLoading removeFromSuperview];
//        }];
//    }];
//}
@end
