//
//  ViewController.m
//  0726帧动画-拳皇
//
//  Created by 张思琦 on 15/7/26.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//用于展现帧动画
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//用户播放声音
@property (strong, nonatomic)AVPlayer *sound;

@property (weak, nonatomic) IBOutlet UIButton *standButton;
@end




/******************************** 程序说明  ****************************/
//1.所有按钮对应一个动画
//2.大招,小招1,小招2,小招3按钮对应发出相应的声音
//3.登陆界面后,一直循环站立的帧动画
//4.在每个动画完毕后回到站立的帧动画


//当前版本中需要注意的有
//1.图片文件存储在NSBudle中
//2.占用内存较大

//???: 图片的设置?为什么在左侧后会统一大小

//TODO: 1.实现进入界面后就开始站立的动画
//TODO: 2.实现动作完成后继续进行站立的动画



//TODO: 3.实现内存图片的优化  ger
//TODO: 4.在实现一个动画的时候不被打断 get
/********************************          ****************************/



@implementation ViewController

#pragma mark - 界面载入方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self playAnimationWithName:@"stand" andNumber:9];
    //[self playAnimationWithName:@"dazhao" andNumber:87];
    
    
    NSLog(@"%@",[NSBundle mainBundle]);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 按钮的具体实现

//写按钮动作事件
- (IBAction)click:(UIButton *)button
{
    
    //在实现动画的时候不被打断
    if([self.imageView isAnimating])
    {
        return ;
    }
    
    //根据button的标签生成动画名和图片数量
    NSString *name = [NSString stringWithFormat:@"%@",button.currentTitle];
    int number = (int)button.tag;
    //执行动画和声音
    [self playAnimationWithName:name andNumber:number];
    
    if ([name  isEqual: @"dazhao"]     ||
        [name  isEqual: @"xiaozhao1"]  ||
        [name  isEqual: @"xiaozhao2"]  ||
        [name  isEqual: @"xiaozhao3"] )
    {
        [self playSoundWihtName:name];
    }


}


- (void)stand
{
    //[self playAnimationWithName:@"stand" andNumber:9];
    NSMutableArray *groupImage = [NSMutableArray array];
    for (int i = 1; i <= 9; i++) {
        //1.imageName为图片名
        NSString *pictureName = [NSString stringWithFormat:@"stand_%i", i];
        //2.找到动画图片的path
        NSString *path = [[NSBundle mainBundle] pathForResource:pictureName ofType:@"png"];
        //3.image为图片
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        //4.将图片存到动画数组
        [groupImage addObject:image];
    }
    
    
    //5.将动画数组赋值给imageView
    self.imageView.animationImages = groupImage;
    
    _imageView.animationDuration = 0.045 * 9;
    
    self.imageView.animationRepeatCount = 0;
    
    //6.开始动画
    [self.imageView startAnimating];

}


#pragma mark - 载入动画的方法
//写一个方法判断当前按钮应该使用哪个动画
//播放动画
- (void)playAnimationWithName:(NSString *)name andNumber:(int)number
{
    
    NSMutableArray *groupImage = [NSMutableArray array];
    for (int i = 1; i <= number; i++) {
        //1.imageName为图片名
        NSString *pictureName = [NSString stringWithFormat:@"%@_%i", name, i];
        //2.找到动画图片的path
        NSString *path = [[NSBundle mainBundle] pathForResource:pictureName ofType:@"png"];
        //3.image为图片
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        //4.将图片存到动画数组
        [groupImage addObject:image];
    }

    
    //5.将动画数组赋值给imageView
    self.imageView.animationImages = groupImage;
    
    _imageView.animationDuration = 0.045 * number;
    
    self.imageView.animationRepeatCount = 1;
    //self.imageView.animationRepeatCount = ([name isEqualToString:@"stand"])?0:1;

    //6.开始动画
    [self.imageView startAnimating];
    
    //7.判断当前动画
    //if ([name isEqualToString:@"stand"])return;
   // [self performSelector:@selector(stand) withObject:nil afterDelay:0.045 * number];


}


#pragma mark - 界面声音方法
//写一个方法判断当前按钮应该使用哪个声音
//播放声音
- (void)playSoundWihtName:(NSString *)name
{
    //播放声音
    //1.找到声音文件的路径
    NSURL *urlSound = [[NSBundle mainBundle] URLForResource:name withExtension:@"mp3"];
    //2.将声音文件交给sound
    self.sound = [AVPlayer playerWithURL:urlSound];
    //3.开始播放
    [self.sound play];
}



@end
