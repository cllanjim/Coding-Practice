//
//  ViewController.m
//  1230 自定义imageView的制作
//
//  Created by 张思琦 on 15/12/30.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQImageView.h"

@interface ViewController ()

@property (nonatomic, strong) SQImageView *imageView;

@end

@implementation ViewController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.imageView.image = [UIImage imageNamed:@"2"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //创建方法一
//    SQImageView *imageView = [[SQImageView alloc] init];
//    imageView.frame = CGRectMake(60, 60, 200, 200);
//    imageView.image = [UIImage imageNamed:@"1"];
    
    //创建方法二
//    SQImageView *imageView = [[SQImageView alloc] initWithFrame:CGRectMake(60, 60, 200, 200)];
//    imageView.image = [UIImage imageNamed:@"1"];
    
    //创建方法三
    SQImageView *imageView = [[SQImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    self.imageView = imageView;
    [self.view addSubview:self.imageView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
