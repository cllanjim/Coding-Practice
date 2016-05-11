//
//  ViewController.m
//  计算器
//
//  Created by 张思琦 on 15/7/24.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (nonatomic, assign)double num1;
@property (nonatomic, assign)double num2;
@property (nonatomic, assign)char symbol;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;


@end



//1. 搭建UI界面
    //  1.1 部分使用storyboard搭建 get

    //  1.2 部分使用代码实现 (最后完善)

//2. 设计交互方式
    //  2.1 数字使用Tag返回值
        //  加减乘除使用11 12 13 14
        //  数字使用0-9
        //  c使用99
    //  2.2 加减乘除使用switch进行判断

//3. 实现功能
    // 3.1 实现数据的传递
    // 3.2 判断数字是否输入完毕
    // 3.3 将两个数保存在属性中
    // 3.4 完善功能




@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

//用于保存提取当前的数字
- (IBAction)getTheNumber:(UIButton *)sender
{
    
 
    //判断当前输入的符号是否为 计算符号
    //如果当前符号为计算符号,将之后的数据赋值给num2,否则赋值给1
    if(sender.tag == 11 || sender.tag == 12 || sender.tag == 13 || sender.tag == 14 ){
        self.num2 = self.num1;
        self.num1 = 0;
        
    
    }else{
        //将button里的tag标签设定为当前的数值并提取,强制转换为double型
        double realNumber= (double)sender.tag;
        //计算实际的数值
        double temp = self.num1 * 10 + realNumber;
        //将数值赋值给num
        self.num1 = temp;
    
    }
    
    
    //将数值反馈的Label上
    self.resultLabel.text = [NSString stringWithFormat:@"%f-------%f",self.num1, self.num2];
    
}


- (IBAction)result:(id)sender {
    
    float result = self.num1 * self.num2;
    self.resultLabel.text = [NSString stringWithFormat:@"%f",result];
    
    [self clear];



}

- (IBAction)clearAllData:(id)sender
{
    [self clear];
    self.resultLabel.text = [NSString stringWithFormat:@"0"];

}

- (void)clear
{
    self.num1 = 0;
    self.num2 = 0;
    self.symbol = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
