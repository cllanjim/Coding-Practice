//
//  SQTabBar.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/6.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQTabBar.h"

@interface SQTabBar ()

//@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) UIButton *addButton;

@end

@implementation SQTabBar

#pragma mark - lazy of button
- (UIButton *)addButton{
    if (_addButton == nil) {
        //创建对象
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置不同状态下的图像
        [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        //监听点击事件
        [button addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        //将button添加到TabBar中
        [self addSubview:button];
        _addButton = button;
    }
    return _addButton;
}

- (void)addClick
{
    NSLog(@"%@",self.subviews);
    SQLOGFUNC;
}


#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    return self;
}


//重新排布TabBarItem
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //设置基本参数
    CGFloat itemW = self.sq_width / 5;
    CGFloat itemH = self.sq_height;
    CGFloat itemY = 0;
    
    int index = 0;
    
    //利用forin循环遍历TabBar中所有的子控件
    for (UIView *subView in self.subviews) {
        
        //判断当前的subView是否为UITabBarItem
        //因为TabBarButton不是一个公开的类,所以无法使用isKindOf的方法
        if(subView.class != NSClassFromString(@"UITabBarButton")) {
            //如果当前类不属于UITabBarButton就跳出此次循环
            //即直接跳到下一个子控件中
            continue;
        }
        
        CGFloat itemX = index * itemW;
        if (index >= 2) {//在第2个控件后面,要增加一个addButton
            itemX = ( index + 1 ) * itemW;
        }
        //布局UITabBarButton的位置
        subView.frame = CGRectMake(itemX, itemY, itemW, itemH);
        
        //增加index的索引
        index++;
        
//        //监听tabBar的点击
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            UIControl *tabBarButton = (UIControl *)subView;
//            [tabBarButton addTarget:self action:@selector(tabBarClick) forControlEvents:UIControlEventTouchUpInside];
//        });
       
    }
    
    //添加自定义的addButton
//    self.addButton.frame = CGRectMake(0, 0, self.bounds.size.width / 5, self.bounds.size.height);
//    self.addButton.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    self.addButton.sq_width = self.sq_width / 5;
    self.addButton.sq_height = self.sq_height;
    self.addButton.sq_centerX = self.sq_width / 2;
    self.addButton.sq_centerY = self.sq_height / 2;

}

@end
