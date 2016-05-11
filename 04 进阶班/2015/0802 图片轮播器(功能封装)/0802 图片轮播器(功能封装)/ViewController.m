//
//  ViewController.m
//  0802 图片轮播器(功能封装)
//
//  Created by 张思琦 on 15/8/6.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQModelOfData.h"
#import "SQModelOfView.h"
#import "Masonry.h"

@interface ViewController ()

//@property (nonatomic, strong) UIScrollView *scrollView;
//@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, copy) NSArray *classOfDataModel;
@end

@implementation ViewController

- (NSArray *)classOfDataModel{
    if (_classOfDataModel == nil) {
        _classOfDataModel = [SQModelOfData groupOfImageView];
    }
    return _classOfDataModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];

//    SQModelOfView *groupView = [SQModelOfView modelOfView];
//    groupView.classOfImageView = self.classOfDataModel;
    
    SQModelOfView *groupView =[SQModelOfView modelOfViewWithArray:self.classOfDataModel];
    

    [self.view addSubview:groupView];
    
    groupView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [groupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 150));
    }];
    
    NSLog(@"%@", self.classOfDataModel);


}


@end
