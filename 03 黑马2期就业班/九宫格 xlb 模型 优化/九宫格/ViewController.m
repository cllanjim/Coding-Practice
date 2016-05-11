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
        
        
        //NSArray *classOfUIElementInXLB = [[NSBundle mainBundle] loadNibNamed:@"GroupView" owner:nil options:nil];
        //当前问题中,第一个UI元素的属性是UIView,所以用UIView接受,这个UIView是当前问题中的标准模板
        //GroupView *exampleOfGroupView = [classOfUIElementInXLB firstObject];
        //UIView *exampleOfGroupView= [classOfUIElementInXLB firstObject];
        
//        GroupView *exampleOfGroupView = [GroupView groupView];
//        exampleOfGroupView.groupViewInfo = _applist[i];
        
        GroupView *exampleOfGroupView = [GroupView groupViewWithGroupViewInfo:_applist[i]];
        
        //将模板赋值给groupViews
        //UIView *groupViews = exampleOfGroupView;
        //groupViews.frame = CGRectMake(xPositionOfGroupView, yPositionOfGroupView,kViewWidth, kViewHeight);
        exampleOfGroupView.frame = CGRectMake(xPositionOfGroupView, yPositionOfGroupView,kViewWidth, kViewHeight);

        
        //将groupView添加到view中
        //[self.view addSubview:groupViews];
        [self.view addSubview:exampleOfGroupView];

        
        

    }
}


@end
