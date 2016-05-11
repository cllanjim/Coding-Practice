//
//  DrawView.m
//  0118 绘画板
//
//  Created by 张思琦 on 16/1/18.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "DrawView.h"

#import "DrawPath.h"

@interface DrawView ()

@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) NSMutableArray *paths;

@property (nonatomic, strong) UIImage *image;

@end


@implementation DrawView

- (void)clear{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

- (void)undo{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}


#pragma mark - lazy
- (NSMutableArray *)paths{
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

#pragma mark - path的初始化
//在UIImagePickerController选择完image后会重新加载stroyboard,因此会调用该方法
- (void)awakeFromNib{
    //在初始化时，就设定好lineWidth和lineColor属性
    self.lineWidth = 1;
    self.lineColor = [UIColor redColor];
    
    
    //移除监听者的标准方法
    //注意点 __block表示在block内部也能修改当前被__block关键字修饰的参数
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:@"handleViewImage" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        //从通知对象中取出image
        UIImage *image = note.userInfo[@"image"];
        self.image = image;
        NSLog(@"Hello World");
        //移除Observer
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
        observer = nil;
    }];
}

#pragma mark - image属性的set方法
- (void)setImage:(UIImage *)image{
    _image = image;
    //在paths中添加image对象
    [self.paths addObject:image];
    //当image对象被赋值后,需要重新绘制
    [self setNeedsDisplay];
    
}



#pragma mark - touch相关的方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取触摸点
    UITouch *touch = [touches anyObject];
    CGPoint curPoint = [touch locationInView:self];
    
    /*********  用于保存线段的基本属性   **********/
    //当没有给path的lineWidth赋值前，系统默认的lineWidth值为1，
    //同理默认的path颜色为黑色
    //创建DrawPath路线
    DrawPath *path = [DrawPath drawPathWithLineColor:self.lineColor];
    //设定路径线段的宽度
    path.lineWidth = self.lineWidth;
    
    //保存当前路径到DrawView的path属性中
    self.path = path;
    
    //保存当前路径到路径数组中
    [self.paths addObject:self.path];
    //设置路径的起点
    [path moveToPoint:curPoint];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取触摸点
    UITouch *touch = [touches anyObject];
    CGPoint curPoint = [touch locationInView:self];
    //添加路径通过的点
    [self.path addLineToPoint:curPoint];
    //重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    for (DrawPath *path in self.paths) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)path;
            [image drawInRect:rect];
        }else{
            //设定线条的颜色
            [path.lineColor set];
            //绘制线条
            [path stroke];
        }
    }
}




@end
