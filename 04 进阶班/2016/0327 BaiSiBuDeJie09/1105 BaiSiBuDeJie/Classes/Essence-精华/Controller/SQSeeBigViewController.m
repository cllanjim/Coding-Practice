//
//  SQSeeBigViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/29.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQSeeBigViewController.h"
#import <UIImageView+WebCache.h>

@interface SQSeeBigViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SQSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //创建ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;

    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    //创建imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topicModel.large_image]];
    [scrollView addSubview:imageView];
    
    //计算imageView的尺寸
    imageView.sq_width = scrollView.sq_width;
    imageView.sq_height = self.topicModel.height * imageView.sq_width / self.topicModel.width;
    imageView.sq_x = 0;
    
    //根据imageView的height决定其Y值
    if(imageView.sq_height > scrollView.sq_height){
        //如果图片超出屏幕,就从头显示
        imageView.sq_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.sq_height);
    }else{
        //如果图片没有超出屏幕,就居中显示
        imageView.sq_y = (scrollView.sq_height - imageView.sq_height) * 0.5;
    }

    //计算缩放比例
    CGFloat scale = self.topicModel.width / scrollView.sq_width;
    NSLog(@"%lf",scale);
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }
    
}




#pragma mark - button功能键
- (IBAction)clickBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)clickSaveButton:(id)sender {
    SQLOG(@"保存功能马上就有了");
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
