//
//  DrawView.h
//  0118 绘画板
//
//  Created by 张思琦 on 16/1/18.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

//lineColor和lineWidth属性通过ViewController传入
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;

- (void)clear;
- (void)undo;

@end
