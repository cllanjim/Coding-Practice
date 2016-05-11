//
//  ViewController.m
//  0113 图片剪裁
//
//  Created by 张思琦 on 16/1/13.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+clipImageWithCircleShape.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.imageView.image = [UIImage clipImage:@"阿狸头像" withCircleWidth:5 withCircleColor:[UIColor greenColor]];
    
}




@end
