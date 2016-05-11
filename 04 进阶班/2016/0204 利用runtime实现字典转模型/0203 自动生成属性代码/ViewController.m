//
//  ViewController.m
//  0203 自动生成属性代码
//
//  Created by 张思琦 on 16/2/3.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+GetPropertyList.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //获取文件位置
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status" ofType:@"plist"];
    NSDictionary *statuses = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *dictArray = statuses[@"statuses"];
//    NSLog(@"%@",dictArray[0]);
    //创建属性列表数组
//    [NSObject creatPropertyListWithDict:dictArray[0]];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
