//
//  ViewController.m
//  0801 图片轮播器
//
//  Created by 张思琦 on 15/8/2.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
/*******************   Masonry的使用步骤    *****************/
    //Masonry的使用注意事项
    //1.创建控件
    //2.添加控件到父控件中
    //3.禁用控件的autoresizing功能
    //4.添加约束
/*********************************************************/
 
    //1.创建scrollView控件
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    self.scrollView.backgroundColor = [UIColor grayColor];
    //2.添加scrollView控件到view视图中
    [self.view addSubview:self.scrollView];
    //3.禁用scrollView的autoresizing功能
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //4.添加约束
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(20);
        make.left.equalTo(self.view.mas_left).with.offset(37.5);
        make.right.equalTo(self.view.mas_right).with.offset(-37.5);
        make.height.equalTo(@150);
    }];
    
   
    //2.为scrollView中添加imageView
    int photoNumber = 5;
    for (int i = 0; i < photoNumber; i++) {
    
    //2.1创建ImageView
    self.imageView = [[UIImageView alloc] init];;
    
    //2.2布局imageView
    CGFloat imageWidth = 300;
    CGFloat imageHeight = 150;
    CGFloat imageViewX = 0 + i * imageWidth;
    CGFloat imageViewY = 0;
    self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageWidth, imageHeight);
        //为什么使用self.scrollView.bounds.size时,width和height的值为0
        //同理frame的属性也不行
        //我估计如果要是重写了layoutSubviews就能生成!
        //但是尼玛都viewdidload了啊!!!!!!!!!!!
        //CGFloat imageWidth = self.scrollView.bounds.size.width;
        //CGFloat imageHeight =self.scrollView.bounds.size.height;
        
        
    //2.3为imageView中添加图像
    NSString *photoName = [NSString stringWithFormat:@"img_%02d",i];
    self.imageView.image = [UIImage imageNamed:photoName];
    
    //2.4将imageView放入ScrollView中
    [self.scrollView addSubview:self.imageView];
     
    }
    
    //设置ScrollView的滚动范围
    self.scrollView.contentSize = CGSizeMake(1500, 150);
    
    //设置ScrollView的分页功能
    self.scrollView.pagingEnabled = YES ;
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
