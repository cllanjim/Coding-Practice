//
//  ViewController.m
//  0731 ScrollView的使用
//
//  Created by 张思琦 on 15/7/31.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.加载UIImageView并将movie图像放入到imageView中
    //方法1
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"movie_jf"]];
    //方法2
       // 生成图片
//    UIImage *image = [UIImage imageNamed:@"movie_jf"];
//     //创建imageView
//    CGFloat x = 0;
//    CGFloat y = 0;
//    CGFloat width = 320;
//    CGFloat height = 360;
//    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
//    imageView1.image = image;
    //2.将图片放入到scrollView中
    [self.scrollView addSubview:imageView1];
    
    //3.设置scrollView的contentsize
    self.scrollView.contentSize = CGSizeMake(1000, 1000);
    


    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
