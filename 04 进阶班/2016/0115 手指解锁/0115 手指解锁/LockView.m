//
//  LockView.m
//  0115 手指解锁
//
//  Created by 张思琦 on 16/1/15.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "LockView.h"

@interface LockView ()
//用于记录起始点的位置
@property (nonatomic, assign) CGPoint curPoint;
//用于记录选中的button按钮
@property (nonatomic, strong) NSMutableArray *selectedButtons;

@end


@implementation LockView

#pragma mark - lazy
- (NSArray *)selectedButtons{
    if (_selectedButtons == nil) {
        _selectedButtons = [NSMutableArray array];
    }
    return _selectedButtons;
}


/***********  构建软件框架  ************/
- (void)awakeFromNib{
    //创建9个UIButton
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        
        //注意点：
        //selected状态能一直秩序，而highlighted状态只能在点击button时触发
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        
        //因为使用自定义的监听方法，所以需要关于button的交互功能
        btn.userInteractionEnabled = NO;
        
        [self addSubview:btn];
        
        //当使用addTarget方法时，按钮背景图片的变化有延迟
        //btn addTarget:(nullable id) action:(nonnull SEL) forControlEvents:(UIControlEvents)
        //adjustsImageWhenHighlighted属性用于是否在高亮状态下改变图片
        //btn.adjustsImageWhenHighlighted
        
    }

}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    int col = 0;
    int row = 0;
    int colCount = 3;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 74;
    CGFloat height = 74;
    
    CGFloat margin = (self.bounds.size.width - colCount * width)/(colCount + 1);
    
    //布局九宫格
    for (int i = 0; i < 9; i++) {
        UIButton *button = self.subviews[i];
        //计算列
        col = i % colCount;
        //计算行
        row = i / colCount;
        
        x = margin + (margin + width) * col;
        y = margin + (margin + height) * row;
        
        button.frame = CGRectMake(x, y, width, height);
    }
}

/************* 处理点击事件业务 ************/
//用于判断触摸点是否在button上
- (void)selectedBtnWihtTouches:(NSSet *)touches withEvent:(UIEvent *)event{
    //获取UITouch对象
    UITouch *touch = [touches anyObject];
    //获取当前触摸点坐标
    CGPoint point = [touch locationInView:self];
    //保存手指当前的位置
    self.curPoint = point;

    
    //判断触摸点是否在button内部
    for (UIButton *button in self.subviews) {
        //将触摸点的坐标系转换为button的坐标系
        CGPoint pointInBtnCoordinateSystem = [self convertPoint:point toView:button];
        
        //判断是否将当前button的状态改为selected
        if([button pointInside:pointInBtnCoordinateSystem withEvent:event] && button.selected == NO){
            //将状态改为YES
            button.selected = YES;
            //将符合条件的button存入selectedButtons数组中
            [self.selectedButtons addObject:button];
        }
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self selectedBtnWihtTouches:touches withEvent:event];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [self selectedBtnWihtTouches:touches withEvent:event];
    
    //强制刷新界面，便于连接新的线段
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSMutableString *string = [NSMutableString string];
    
    //恢复所有button的状态
    for (UIButton *button in self.selectedButtons) {
        button.selected = NO;
        
        //拼接密码字符串
        [string appendFormat:@"%ld", button.tag];
    }
    
    //打印密码
    NSLog(@"%@", string);
    
    //当手指离开屏幕后，应当将保存button的数组清空
    [self.selectedButtons removeAllObjects];
    
    //强制刷新界面，用于清除旧的线段
    [self setNeedsDisplay];
}

/**************** 处理连线业务 ******************/
- (void)drawRect:(CGRect)rect{
    
    //如果没有选中的button，就不绘制连线
    if (self.selectedButtons.count == 0) {
        return;
    }
    
    //绘制曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    int i = 0;
    
    //循环selectedButtons中的button元素，并绘制连线
    for (UIButton *selBtn in self.selectedButtons) {
        if(i == 0){
            [path moveToPoint:selBtn.center];
        }else{
            [path addLineToPoint:selBtn.center];
        }
        i++;
    }
    //增加线段到触摸点所在的位置
    [path addLineToPoint:self.curPoint];
    //设置颜色
    [[UIColor greenColor] set];
    //设置线宽
    path.lineWidth = 10;
    //设置线段节点
    path.lineJoinStyle = kCGLineCapRound;
    //绘制线段
    [path stroke];
    
}


@end
