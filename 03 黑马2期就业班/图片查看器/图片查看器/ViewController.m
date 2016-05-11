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
    
    //对界面进行布局,从上至下进行布局
/////////////////////////////////////////////////////////////////////
    //1.设置最上端的UILabel(图片数字说明)
//    UILabel *picture = [[UILabel alloc] init];
//    [picture setFrame:CGRectMake(0, 20, self.view.bounds.size.width, 40)];
    UILabel *pictureNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 40)];
    
    //[pictureNumber setText:@"1/5"];
    //pictureNumber.text = @"1/5";
    //[pictureNumber setTextAlignment:NSTextAlignmentCenter];
    pictureNumber.textAlignment = NSTextAlignmentCenter;
    
    self.newpictureNumber = pictureNumber;
    //[self.view addSubview:pictureNumber];
    [self.view addSubview:self.newpictureNumber];
/////////////////////////////////////////////////////////////////////
    //2.设置中央的UIImageView
    CGFloat imageWidth = 200;
    CGFloat imageHeight = 200;
    CGFloat imageX = (self.view.bounds.size.width - imageHeight) * 0.5;
    //CGFloat imageX = 0.5 * (self.view.bounds.size.width - self.newpicture.bounds.size.width);
    CGFloat imageY = CGRectGetMaxY(self.newpictureNumber.frame) + 20;
    //CGFloat imageY = CGRectGetMaxY(pictureNumber.frame) + 20;
    UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageWidth, imageHeight)];
    
    //[picture setBackgroundColor:[UIColor redColor]];
    picture.backgroundColor = [UIColor redColor];
    //[picture setImage:[UIImage imageNamed:@"biaoqingdi"]];
    picture.image = [UIImage imageNamed:@"biaoqingdi"];
    
    self.newpicture = picture;
    [self.view addSubview:self.newpicture];

/////////////////////////////////////////////////////////////////////
  
    //3.设置左边的button
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    CGFloat leftCenterY = picture.center.y;
    CGFloat leftCenterX = picture.frame.origin.x * 0.5;
    //[leftButton setCenter:CGPointMake(leftCenterX, leftCenterY)];
    leftButton.center = CGPointMake(leftCenterX, leftCenterY);
    
    [leftButton setBackgroundImage:[UIImage imageNamed:@"left_normal"] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"left_disable"] forState:UIControlStateDisabled];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"left_highlighted"] forState:UIControlStateHighlighted];
    [leftButton setTag: -1 ];
    
    self.newleftButton = leftButton;
    [self.view addSubview:self.newleftButton];
    //[self.view addSubview:leftButton];

/////////////////////////////////////////////////////////////////////
    //4.设置右边的button
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    CGFloat rightCenterY = picture.center.y;
    CGFloat rightCenterX = (self.view.bounds.size.width - (picture.frame.origin.x * 0.5));
    rightButton.center = CGPointMake(rightCenterX, rightCenterY);
    
    [rightButton setBackgroundImage:[UIImage imageNamed:@"right_normal"] forState:UIControlStateNormal];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"right_disable"] forState:UIControlStateDisabled];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"right_highlighted"] forState:UIControlStateHighlighted];
    [rightButton setTag: 1 ];
    
    self.newrightButton = rightButton;
    [self.view addSubview:self.newrightButton];
    //[self.view addSubview:rightButton];

/////////////////////////////////////////////////////////////////////
    //5.设置说明文字
    //CGFloat pCY = CGRectGetMaxY(self.newpicture.frame) + 10;
    CGFloat pCY = CGRectGetMaxY(picture.frame) + 10;

    UILabel *pictureContent = [[UILabel alloc] initWithFrame:CGRectMake(0, pCY, self.view.bounds.size.width, 100)];
    
    //pictureContent.text = @"神马表情?";
    pictureContent.textAlignment = NSTextAlignmentCenter;
    //[pictureContent setNumberOfLines:0];
    pictureContent.numberOfLines = 0;
    
    self.newpictureContent = pictureContent;
    [self.view addSubview:self.newpictureContent];
    
/////////////////////////////////////////////////////////////////////
    //将按钮与方法相关联
    //addTarget是选择将当前控件或当前属性的动作信息发送给谁? nil是默认将该信息发送给默认的控制器
    //例如知乎
    [self.newrightButton addTarget:nil action:@selector(changePhoto:) forControlEvents:UIControlEventTouchUpInside];

    [self.newleftButton addTarget:nil action:@selector(changePhoto:) forControlEvents:UIControlEventTouchUpInside];

/////////////////////////////////////////////////////////////////////
    
    
/////////////////////////////////////////////////////////////////////
//    NSDictionary *dict1 = @{@"name": @"biaoqingdi", @"desc": @"看神马1?"};
//    NSDictionary *dict2 = @{@"name": @"bingli",     @"desc": @"这是病历1?"};
//    NSDictionary *dict3 = @{@"name": @"chiniupa",   @"desc": @"吃牛排1?"};
//    NSDictionary *dict4 = @{@"name": @"danteng",    @"desc": @"蛋疼1?"};
//    NSDictionary *dict5 = @{@"name": @"wangba",     @"desc": @"王八1?"};
//    _pictureList = @[dict1, dict2, dict3, dict4, dict5];

    //将picturelist数组直接加载时,需要先加载后调用,否则会出现错误
/////////////////////////////////////////////////////////////////////

    [self showPhoto];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSArray *)pictureList
//{
//    if (self.pictureList == nil) {
//        NSDictionary *dict1 = @{@"name": @"biaoqingdi", @"desc": @"看神马?"};
//        NSDictionary *dict2 = @{@"name": @"bingli",     @"desc": @"这是病历?"};
//        NSDictionary *dict3 = @{@"name": @"chiniupai",  @"desc": @"吃牛排?"};
//        NSDictionary *dict4 = @{@"name": @"danteng",    @"desc": @"蛋疼?"};
//        NSDictionary *dict5 = @{@"name": @"wangba",     @"desc": @"王八?"};
//        self.pictureList = @[dict1, dict2, dict3, dict4, dict5];
//    }
//    return self.pictureList;
//
//}


- (NSArray *)pictureList
{
    if (_pictureList == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"pictureList" ofType:@"plist"];
        _pictureList = [NSArray arrayWithContentsOfFile:path];
        
    }
    return _pictureList;
}

//使用懒加载方法获取picturelist
//- (NSArray *)pictureList
//{
//    if (_pictureList == nil) {
//        NSDictionary *dict1 = @{@"name": @"biaoqingdi", @"desc": @"看神马?"};
//        NSDictionary *dict2 = @{@"name": @"bingli",     @"desc": @"这是病历?"};
//        NSDictionary *dict3 = @{@"name": @"chiniupa",  @"desc": @"吃牛排?"};
//        NSDictionary *dict4 = @{@"name": @"danteng",    @"desc": @"蛋疼?"};
//        NSDictionary *dict5 = @{@"name": @"wangba",     @"desc": @"王八?"};
//        _pictureList = @[dict1, dict2, dict3, dict4, dict5];
//    }
//    return _pictureList;
//}
/////////////////////////////////////////////////////////////////////////////////////
//- (NSArray *)pictureList
//{
//    if (self.pictureList == nil) {
//        NSDictionary *dict1 = @{@"name": @"biaoqingdi", @"desc": @"看神马?"};
//        NSDictionary *dict2 = @{@"name": @"bingli",     @"desc": @"这是病历?"};
//        NSDictionary *dict3 = @{@"name": @"chiniupa",  @"desc": @"吃牛排?"};
//        NSDictionary *dict4 = @{@"name": @"danteng",    @"desc": @"蛋疼?"};
//        NSDictionary *dict5 = @{@"name": @"wangba",     @"desc": @"王八?"};
//        self.pictureList = @[dict1, dict2, dict3, dict4, dict5];
//    }
//    return self.pictureList;
//}
//在get方法中调用self会引起循环引用,必须进行属性赋值

- (void)showPhoto
{
    self.newpictureNumber.text = [NSString stringWithFormat:@"%i/%i", self.index + 1, 5];
    
    self.newpictureContent.text = self.pictureList[self.index][@"desc"];
    self.newpicture.image =[UIImage imageNamed:self.pictureList[self.index][@"name"]];
    
    
    self.newleftButton.enabled = (self.index != 0);
    self.newrightButton.enabled = (self.index != 4);
}

/*
//该方法为配合数组加载到启动界面时的情况而设定,需要注意的是,index初始值为0,数组的初始值为0,需要调整button的界限判断
- (void)showPhoto
{
    self.newpictureNumber.text = [NSString stringWithFormat:@"%i/%i", self.index, 5];
    
    self.newpictureContent.text = self.pictureList[self.index][@"desc"];
    self.newpicture.image =[UIImage imageNamed:self.pictureList[self.index][@"name"]];
    
    
    self.newleftButton.enabled = (self.index != 0);
    self.newrightButton.enabled = (self.index != 4);
}
*/

/*
- (void)showPhoto
{
    self.newpictureNumber.text = [NSString stringWithFormat:@"%i/%i", self.index, 5];
    
    switch (self.index) {
        case 1:
            self.newpicture.image = [UIImage imageNamed:@"biaoqingdi"];
            self.newpictureContent.text = @"看神马?";
            break;
        case 2:
            self.newpicture.image = [UIImage imageNamed:@"bingli"];
            self.newpictureContent.text = @"这是病历?";
            break;
        case 3:
            self.newpicture.image = [UIImage imageNamed:@"chiniupa"];
            self.newpictureContent.text = @"吃牛排?";
            break;
        case 4:
            self.newpicture.image = [UIImage imageNamed:@"danteng"];
            self.newpictureContent.text = @"蛋疼?";
            break;
        case 5:
            self.newpicture.image = [UIImage imageNamed:@"wangba"];
            self.newpictureContent.text = @"王八?";
            break;
    }
    self.newleftButton.enabled = (self.index != 1);
    self.newrightButton.enabled = (self.index != 5);
}
*/
 
- (void)changePhoto:(UIButton *)buttonDir
{
    self.index += (int)buttonDir.tag;
    
    [self showPhoto];
    
}

/*
//方法二
- (void)changePhoto:(UIButton *)buttonDir
{
    self.index += (int)buttonDir.tag;
    self.newpictureNumber.text = [NSString stringWithFormat:@"%i/%i", self.index, 5];

    
    switch (self.index) {
        case 1:
            self.newpicture.image = [UIImage imageNamed:@"biaoqingdi"];
            self.newpictureContent.text = @"看神马?";
            break;
        case 2:
            self.newpicture.image = [UIImage imageNamed:@"bingli"];
            self.newpictureContent.text = @"这是病历?";
            break;
        case 3:
            self.newpicture.image = [UIImage imageNamed:@"chiniupa"];
            self.newpictureContent.text = @"吃牛排?";
            break;
        case 4:
            self.newpicture.image = [UIImage imageNamed:@"danteng"];
            self.newpictureContent.text = @"蛋疼?";
            break;
        case 5:
            self.newpicture.image = [UIImage imageNamed:@"wangba"];
            self.newpictureContent.text = @"王八?";
            break;
    }
            self.newleftButton.enabled = (self.index != 1);
            self.newrightButton.enabled = (self.index != 5);
}
*/

/*
 //方法一
- (void)nextPhoto
{
    self.index += 1;
    
    //设置点击后带来的界面变化
    switch (self.index) {
        case 1:
            //修改图片序列号
            self.newpictureNumber.text = @"1/5";
            //修改图片
            self.newpicture.image = [UIImage imageNamed:@"biaoqingdi"];
            //修改图片文字
            self.newpictureContent.text = @"看神马?";
            break;
        case 2:
            self.newpictureNumber.text = @"2/5";
            self.newpicture.image = [UIImage imageNamed:@"bingli"];
            self.newpictureContent.text = @"这是病历?";
            break;
        case 3:
            self.newpictureNumber.text = @"3/5";
            self.newpicture.image = [UIImage imageNamed:@"chiniupa"];
            self.newpictureContent.text = @"吃牛排?";
            break;
        case 4:
            self.newpictureNumber.text = @"4/5";
            self.newpicture.image = [UIImage imageNamed:@"danteng"];
            self.newpictureContent.text = @"蛋疼?";
            break;
        case 5:
            self.newpictureNumber.text = @"5/5";
            self.newpicture.image = [UIImage imageNamed:@"wangba"];
            self.newpictureContent.text = @"王八?";
            break;
    }
    
    //必须两个判断同时存在,否则会出现当点左边或者右边至极限值时,按键的功能被关闭,无法在开启
    //判断rightButton键是否继续有效
    if( 5 == self.index)
    {
        self.newrightButton.enabled = NO;
    }else {
        self.newrightButton.enabled = YES;
    }
    //判断leftButton键是否继续有效
    if( 1 == self.index)
    {
        self.newleftButton.enabled = NO;
    }else {
        self.newleftButton.enabled = YES;
    }
}

- (void)prePhoto
{
    self.index -= 1;
    
    //设置点击后带来的界面变化
    switch (self.index) {
        case 1:
            //修改图片序列号
            self.newpictureNumber.text = @"1/5";
            //修改图片
            self.newpicture.image = [UIImage imageNamed:@"biaoqingdi"];
            //修改图片文字
            self.newpictureContent.text = @"看神马?";
            break;
        case 2:
            self.newpictureNumber.text = @"2/5";
            self.newpicture.image = [UIImage imageNamed:@"bingli"];
            self.newpictureContent.text = @"这是病历?";
            break;
        case 3:
            self.newpictureNumber.text = @"3/5";
            self.newpicture.image = [UIImage imageNamed:@"chiniupa"];
            self.newpictureContent.text = @"吃牛排?";
            break;
        case 4:
            self.newpictureNumber.text = @"4/5";
            self.newpicture.image = [UIImage imageNamed:@"danteng"];
            self.newpictureContent.text = @"蛋疼?";
            break;
        case 5:
            self.newpictureNumber.text = @"5/5";
            self.newpicture.image = [UIImage imageNamed:@"wangba"];
            self.newpictureContent.text = @"王八?";
            break;
    }
    
    
    //判断rightButton键是否继续有效
    
    if( 5 == self.index)
    {
        self.newrightButton.enabled = NO;
    }else {
        self.newrightButton.enabled = YES;
    }
    //判断leftButton键是否继续有效
    if( 1 == self.index)
    {
        self.newleftButton.enabled = NO;
    }else {
        self.newleftButton.enabled = YES;
    }
}
*/
@end
