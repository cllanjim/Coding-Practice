//
//  ViewController.m
//  图片查看器
//
//  Created by 张思琦 on 15/7/12.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong)UIButton *newleftButton;//左
@property (nonatomic, strong)UIButton *newrightButton;//右
@property (nonatomic, strong)UILabel *newpictureNumber;//图片数字说明
@property (nonatomic, strong)UILabel *newpictureContent;//图片文字说明
@property (nonatomic, strong)UIImageView *newpicture;//图片

//保存图片索引
@property (nonatomic, assign)int index;
//保存图片和对应的文字信息
@property (nonatomic, strong)NSArray *pictureList;

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self showPhoto];
    // Do any additional setup after loading the view, typically from a nib.
}


- (UILabel *)newpictureNumber
{
    if (_newpictureNumber == nil) {
        UILabel *pictureNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 40)];
        pictureNumber.textAlignment = NSTextAlignmentCenter;
        
        //此处为调用setter方法,不影响
        self.newpictureNumber = pictureNumber;
        [self.view addSubview:self.newpictureNumber];
    }
    return _newpictureNumber;
}

- (UIImageView *)newpicture
{
    if (_newpicture == nil) {
        CGFloat imageWidth = 200;
        CGFloat imageHeight = 200;
        CGFloat imageX = (self.view.bounds.size.width - imageHeight) * 0.5;
        CGFloat imageY = CGRectGetMaxY(self.newpictureNumber.frame) + 20;
        UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageWidth, imageHeight)];
        
        picture.backgroundColor = [UIColor redColor];
        picture.image = [UIImage imageNamed:@"biaoqingdi"];
        
        self.newpicture = picture;
        [self.view addSubview:self.newpicture];
    }
    return _newpicture;
}



- (UILabel *)newpictureContent
{
    if (_newpictureContent == nil) {
        CGFloat pCY = CGRectGetMaxY(self.newpicture.frame) + 10;

        UILabel* pictureContent = [[UILabel alloc]
            initWithFrame:CGRectMake(0, pCY, self.view.bounds.size.width, 100)];

        pictureContent.textAlignment = NSTextAlignmentCenter;
        pictureContent.numberOfLines = 0;

        self.newpictureContent = pictureContent;
        [self.view addSubview:self.newpictureContent];
    }

    return _newpictureContent;
}

- (UIButton *)newleftButton
{
    if (_newleftButton == nil) {
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        CGFloat leftCenterY = self.newpicture.center.y;
        CGFloat leftCenterX = self.newpicture.frame.origin.x * 0.5;
        leftButton.center = CGPointMake(leftCenterX, leftCenterY);
        
        [leftButton setBackgroundImage:[UIImage imageNamed:@"left_normal"] forState:UIControlStateNormal];
        [leftButton setBackgroundImage:[UIImage imageNamed:@"left_disable"] forState:UIControlStateDisabled];
        [leftButton setBackgroundImage:[UIImage imageNamed:@"left_highlighted"] forState:UIControlStateHighlighted];
        [leftButton setTag: -1 ];
        
        self.newleftButton = leftButton;
        [self.view addSubview:self.newleftButton];
        
        [self.newleftButton addTarget:nil action:@selector(changePhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _newleftButton;
}

- (UIButton *)newrightButton
{
    if (_newrightButton == nil) {
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        
        CGFloat rightCenterY = self.newpicture.center.y;
        CGFloat rightCenterX = self.view.bounds.size.width - self.newleftButton.center.x;
        rightButton.center = CGPointMake(rightCenterX, rightCenterY);
        
        [rightButton setBackgroundImage:[UIImage imageNamed:@"right_normal"] forState:UIControlStateNormal];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"right_disable"] forState:UIControlStateDisabled];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"right_highlighted"] forState:UIControlStateHighlighted];
        [rightButton setTag: 1 ];
        
        self.newrightButton = rightButton;
        [self.view addSubview:self.newrightButton];
        
        [self.newrightButton addTarget:nil action:@selector(changePhoto:) forControlEvents:UIControlEventTouchUpInside];
    }
   
    return _newrightButton;

}

- (NSArray *)pictureList
{
    if (_pictureList == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"pictureList" ofType:@"plist"];
        _pictureList = [NSArray arrayWithContentsOfFile:path];
    }
    return _pictureList;
}

- (void)showPhoto
{
  self.newpictureNumber.text =
      [NSString stringWithFormat:@"%i/%i", self.index + 1, 5];
  self.newpictureContent.text = self.pictureList[self.index][@"desc"];
  self.newpicture.image =
      [UIImage imageNamed:self.pictureList[self.index][@"name"]];

  self.newleftButton.enabled = (self.index != 0);
  self.newrightButton.enabled = (self.index != 4);
}

- (void)changePhoto:(UIButton *)buttonDir
{
    self.index += (int)buttonDir.tag;

    NSArray *test = @[ @"1111", @"111", @"111" ];

    [self showPhoto];
}

@end
