//
//  SQModelOfView.h
//  0802 图片轮播器(功能封装)
//
//  Created by 张思琦 on 15/8/6.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQModelOfData.h"

@interface SQModelOfView : UIView <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;



@property (nonatomic, strong) NSArray *classOfImageView;



+ (instancetype)modelOfView;
+ (instancetype)modelOfViewWithArray:(NSArray *)classOfImageView;

@end
