//
//  HandleView.m
//  0118 绘画板
//
//  Created by 张思琦 on 16/1/19.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "HandleView.h"

@interface HandleView()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HandleView

//    该类创建后自身是一个view,同时一个imageView属性
//    对imageView进行手势操作,最后保存handleView的layer即可

#pragma mark -

- (void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = image;
    self.imageView.frame = self.bounds;
}

#pragma mark - lazy

- (UIImageView *)imageView{
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        _imageView = imageView;
        
        imageView.userInteractionEnabled = YES;
        
        [self addSubview:imageView];
        
        [self addGestures];
        
    }
    return _imageView;
}


#pragma mark - addGesture
- (void)addGestures{
    //添加移动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.imageView addGestureRecognizer:pan];
    
    //添加旋转手势
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [self.imageView addGestureRecognizer:rotation];
    
    //添加缩放手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.imageView addGestureRecognizer:pinch];
    
    //添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.imageView addGestureRecognizer:longPress];
    
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    //获取偏移量
    CGPoint transform = [pan translationInView:self];
    //根据之前的偏移量进行移动
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, transform.x, transform.y);
    //对pan手势的Transform归零
    [pan setTranslation:CGPointZero inView:self];
    
}

- (void)rotation:(UIRotationGestureRecognizer *)rotation{
    
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotation.rotation);
    rotation.rotation = 0;

}

- (void)pinch:(UIPinchGestureRecognizer *)pinch{
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
    
}

#pragma mark - 保存图片到当前桌面
- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    //当长按手势被激活时
    if(longPress.state == UIGestureRecognizerStateBegan){
        //通过imageView的alpha值的改变模拟图片被保存到画板上
        [UIView animateWithDuration:0.25 animations:^{
            self.imageView.alpha = 0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 animations:^{
                self.imageView.alpha = 1;
            } completion:^(BOOL finished) {
                //创建imageContext
                UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
                //渲染当前layer内容到imageContext中
                [self.layer renderInContext:UIGraphicsGetCurrentContext()];
                //从imageContext中获取image对象
                UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                //关闭上下文
                UIGraphicsEndImageContext();
                
                //利用通知将image对象发送到drawView中
                NSDictionary *userInfo = @{
                                           @"image": image
                                           };
                [[NSNotificationCenter defaultCenter] postNotificationName:@"handleViewImage" object:nil userInfo:userInfo];
                
                //在发送完通知后移除自身
                [self removeFromSuperview];
            }];
        }];
    }
}


@end
