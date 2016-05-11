//
//  ViewController.m
//  0726 简易计算器
//
//  Created by 张思琦 on 15/7/26.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

//实现的功能有
//1.计算两个数的关系
//2.实现加减乘除计算
//3.Label框里展示出计算的过程
//4.尝试使用autolayout




#import "ViewController.h"




@interface ViewController ()





//用于保存用户输入的数值
//num1代表后输入的数字
@property (nonatomic, assign)float num1;
//num2代表先输入的数字
@property (nonatomic, assign)float num2;

//用于保存用户输入的符号
@property (nonatomic, assign)char symbol;

//用于保存界面上生成的字符串
@property (nonatomic, copy)NSString *information;

//UI界面上的显示窗口
@property (weak, nonatomic) IBOutlet UILabel *LabelInfomation;

@end

@implementation ViewController

/************************************  完成情况汇总  *************************************/
//已完成
    //当前完成了正整数的加减乘除
    //重置功能
//未完成
    //小数点功能
    //百分号功能
    //正负号功能


/************************************    *************************************/

#pragma mark - 界面登陆
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 数字按钮的输入实现

/**
 *  用于接收用户输入的数字
 tag设置参数为
 0 -> 0
 1 -> 1
 2 -> 2
 ......
 9 -> 9
 */

- (IBAction)clickNumber:(UIButton *)buttonNumber
{
    NSLog(@"%li", buttonNumber.tag);
    //当前的tag值即为用户输入的数字
        //输入的数字为正整数时
    int temp = (int)buttonNumber.tag;
    self.num1 = self.num1 * 10 + temp;
    self.LabelInfomation.text = [NSString stringWithFormat:@"%f", self.num1];
}


#pragma mark - 加减乘除号按钮的输入实现
/**
 *  用于接收用户选择的计算符号
 tag设置参数为
 / -> 47
 * -> 42
 - -> 45
 + -> 43
 这样设置可以方便计算器直接输出运算符号
 */

- (IBAction)clickSymbol:(UIButton *)buttonSymbol
{
    NSLog(@"%li", buttonSymbol.tag);
 
    self.num2 = self.num1;
    self.symbol = buttonSymbol.tag;
    self.num1 = 0;
    self.LabelInfomation.text = [NSString stringWithFormat:@"%c", self.symbol];
}


#pragma mark - 等号按钮的输入实现
/**
 *  用于计算结果
 根据num1,num2及symbol还原计算公式计算即可
 tag设置参数为
 = -> 88
 tag设置参数为
 / -> 47
 * -> 42
 - -> 45
 + -> 43
 */
- (IBAction)clickResult:(UIButton *)buttonResult
{
    NSLog(@"%li", buttonResult.tag);
    
    //生成用于保存计算结果的数值
    float temp = [self judge];
    self.LabelInfomation.text = [NSString stringWithFormat:@"%f", temp];
    [self clean];

    
}

#pragma mark - 四则运算的实现
//判断
- (float)judge
{
    switch (self.symbol) {
        case 43:
        {
            return (self.num2 + self.num1);
        }
            break;
        case 45:
        {
            return (self.num2 - self.num1);
        }
            break;
        case 42:
        {
            return (self.num2 * self.num1);
        }
            break;
        case 47:
        {
            return (self.num2 / self.num1);
        }
   }
    return 1;
}



#pragma mark - 重置按钮的输入实现
/**
 *  用于清除所有数字并重置计算器
 tag设置参数为
 AC -> 99
 
 */

- (IBAction)clikckClean:(UIButton *)buttonClean
{
    NSLog(@"%li",buttonClean.tag);
    
    [self clean];
    self.LabelInfomation.text = @"0";
    
}

- (void)clean
{
    self.num1 = 0;
    self.num2 = 0;
    self.symbol = 0;
}

@end
