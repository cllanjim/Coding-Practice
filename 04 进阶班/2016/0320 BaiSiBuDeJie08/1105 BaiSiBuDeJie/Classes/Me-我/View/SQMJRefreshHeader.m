//
//  SQMJRefreshHeader.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/18.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQMJRefreshHeader.h"

@implementation SQMJRefreshHeader

- (void)prepare{
    
    [super prepare];
    //自动调整文字的透明度
    self.automaticallyChangeAlpha = YES;

    self.stateLabel.textColor = [UIColor redColor];
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    
    //stateLabel在不同状态下的文字设置
    
    //MJRefreshStateIdle        普通闲置状态
    //MJRefreshStatePulling     松开就可以进行刷新的状态
    //MJRefreshStateRefreshing  正在刷新中的状态
    //MJRefreshStateWillRefresh 即将刷新的状态
    //MJRefreshStateNoMoreData  所有数据加载完毕，没有更多的数据
    [self setTitle:@"下拉状态" forState:MJRefreshStateIdle];
    [self setTitle:@"松开就可以刷新啦" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新呢" forState:MJRefreshStateRefreshing];
    [self setTitle:@"即将刷新呢" forState:MJRefreshStateWillRefresh];
    [self setTitle:@"数据刷新完毕了" forState:MJRefreshStateNoMoreData];


}




@end
