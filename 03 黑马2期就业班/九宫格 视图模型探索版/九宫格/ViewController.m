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

        GroupView *exampleOfGroupView = [GroupView groupViewWithGroupViewInfo:_applist[i]];
        

        exampleOfGroupView.frame = CGRectMake(xPositionOfGroupView, yPositionOfGroupView,kViewWidth, kViewHeight);

        [self.view addSubview:exampleOfGroupView];

    }
}


@end
