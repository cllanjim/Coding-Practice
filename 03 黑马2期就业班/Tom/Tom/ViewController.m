//
//  ViewController.m
//  Tom
//
//  Created by 张思琦 on 15/7/14.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageOfTom;

@end

@implementation ViewController


//方法三
- (IBAction)clickButton:(UIButton *)button
{
    
    if([self.imageOfTom isAnimating])
    {
        return;
    }

    //1.创建一个用于保存图片地址的数组
    NSMutableArray *imageGallery = [NSMutableArray array];
    
    //2.设置循环,用于把图片地址添加到数组当中
    for (int i = 0; i < button.tag; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%@_%02i",button.titleLabel.text, i];
//        NSString *imageName = [NSString stringWithFormat:@"%@_%02i",button.currentTitle, i];
//        UIImage *imageToShow = [UIImage imageNamed:imageName];
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
        
        UIImage *imageToShow = [UIImage imageWithContentsOfFile:path];
        
        
        [imageGallery addObject:imageToShow];
    }
    
    
    
    //将imageGallery赋值给UIImageView中的animationImages属性
    [self.imageOfTom setAnimationImages:imageGallery];
    
    //设置循环次数
    [self.imageOfTom setAnimationRepeatCount:1];
    
    //设置循环时间
    [self.imageOfTom setAnimationDuration:self.imageOfTom.animationImages.count * 0.06];
    
    [self.imageOfTom startAnimating];
    
    [self.imageOfTom performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:self.imageOfTom.animationImages.count * 0.6];
}


/*
//方法二
- (void)actionWithName:(NSString *)name count:(NSInteger)count
{
    //判断动画是否进行
    if([self.imageOfTom isAnimating])
    {
        return;
    }
    
    //1.创建一个用于保存图片地址的数组
    NSMutableArray *imageGallery = [NSMutableArray array];
    
    //2.设置循环,用于把图片地址添加到数组当中
    for (int i = 0; i < count; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%@_%02i.jpg",name, i];
        UIImage *imageToShow = [UIImage imageNamed:imageName];
        [imageGallery addObject:imageToShow];
    }
    
    //将imageGallery赋值给UIImageView中的animationImages属性
    [self.imageOfTom setAnimationImages:imageGallery];
    
    //设置循环次数
    [self.imageOfTom setAnimationRepeatCount:1];
    
    //设置循环时间
    [self.imageOfTom setAnimationDuration:self.imageOfTom.animationImages.count * 0.06];
    
    [self.imageOfTom startAnimating];

}
- (IBAction)eat
{
    [self actionWithName:@"eat" count:40];
}
- (IBAction)knockout
{
    [self actionWithName:@"knockout" count:81];
}
*/




/*
//方法一
- (IBAction)eat
{
    //1.创建一个用于保存图片地址的数组
    NSMutableArray *imageGallery = [NSMutableArray array];
    
    //2.设置循环,用于把图片地址添加到数组当中
    for (int i = 0; i < 40; i++) {
        NSString *imageName = [NSString stringWithFormat:@"eat_%02i.jpg",i];
        UIImage *imageToShow = [UIImage imageNamed:imageName];
        [imageGallery addObject:imageToShow];
    }
    
    //将imageGallery赋值给UIImageView中的animationImages属性
    [self.imageOfTom setAnimationImages:imageGallery];
    
    //设置循环次数
    [self.imageOfTom setAnimationRepeatCount:1];
    
    //设置循环时间
    [self.imageOfTom setAnimationDuration:self.imageOfTom.animationImages.count * 0.06];
    
    [self.imageOfTom startAnimating];
}

- (IBAction)knockout
{
    NSMutableArray *imageGallery = [NSMutableArray array];
    
    for (int i = 0; i < 80; i++) {
        NSString *imageName = [NSString stringWithFormat:@"knockout_%02i.jpg", i];
        UIImage *imageToShow = [UIImage imageNamed:imageName];
        [imageGallery addObject:imageToShow];
    }

    //将imageGallery赋值给UIImageView中的animationImages属性
    [self.imageOfTom setAnimationImages:imageGallery];
    
    //设置循环次数
    [self.imageOfTom setAnimationRepeatCount:1];
    
    //设置循环时间
    [self.imageOfTom setAnimationDuration:self.imageOfTom.animationImages.count * 0.06];
    
    [self.imageOfTom startAnimating];
}
*/

 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
