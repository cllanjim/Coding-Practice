//
//  SQMainTabBar.m
//  0825 案例 - 彩票
//
//  Created by 张思琦 on 15/8/25.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQMainTabBar.h"

@interface SQMainTabBar()

@property (nonatomic, strong) UIButton *btn;

@end


@implementation SQMainTabBar

- (void)setItems:(NSMutableArray *)items{
    
    _items = items;
    
    for (int i = 0 ; i < _items.count; i++) {
        UITabBarItem *tabBarItem = _items[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //设置button的背景图片
        [btn setBackgroundImage:tabBarItem.image forState:UIControlStateNormal];
        [btn setBackgroundImage:tabBarItem.selectedImage forState:UIControlStateSelected];
//        //注意设置backGroudImage能填充整个背景
//        [btn setImage:tabBarItem.image forState:UIControlStateNormal];
//        [btn setImage:tabBarItem.selectedImage forState:UIControlStateHighlighted];

        //设置tag值
        btn.tag = i;
        
        
        //设置监听功能,使其能够完成页面跳转的功能
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:btn];
        
    }
}

//监听方法
- (void)btnClick:(UIButton *)btn
{
    self.btn.selected = NO;
    btn.selected = YES;
    self.btn = btn;

    if ([self.delegate respondsToSelector:@selector(tabBar:changeViewControllerWithTag:)]) {
        [self.delegate tabBar:btn changeViewControllerWithTag:btn.tag];
    }
    
}

//用于布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
        //确定button的位置
    CGFloat btnW = self.bounds.size.width / _items.count;
    CGFloat btnH = self.bounds.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    //循环布局button
    for (int i = 0; i < _items.count; i++) {
        UIButton *btn = self.subviews[i];
        btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
