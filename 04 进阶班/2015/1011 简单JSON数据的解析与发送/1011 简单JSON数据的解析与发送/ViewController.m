//
//  ViewController.m
//  1011 简单JSON数据的解析与发送
//
//  Created by 张思琦 on 15/10/11.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self jsonTOobj];
    [self objTOjson];
}

- (void)jsonTOobj{
    //根据网址创建NSString
    NSString *urlstr = [NSString stringWithFormat:@"http://120.25.226.186:32812/login?username=520it&pwd=520it&type=JSON"];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //data 是指包含JSON数据的二进制码
        //option 是指读取JSON数据的方式和创建JSON数据的方式
            //NSJSONReadingMutableContainers 返回可变容器，NSMutableDictionary或NSMutableArray
            //NSJSONReadingMutableLeaves = 返回的JSON对象中字符串的值为NSMutableString,
            //NSJSONReadingAllowFragments = 允许JSON字符串最外层既不是NSArray也不是NSDictionary，但必须是有效的JSON Fragment。例如使用这个选项可以解析 @“123” 这样的字符串。
        //error 是指读取JSON数据失败时,能够返回一个NSError对象,用来描述错误信息

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //dict中获取的中文代码为乱码
        NSLog(@"%@",dict);
    }];
}


- (void)objTOjson{
    NSDictionary *dict = @{
                           @"name" : @"lnj",
                           @"age" : @10,
                           @"gender" : @"man"
                           };
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    //obj 指需要转换为JSON二进制码的OC对象
    //options 是指将OC对象转换为二进制码的方法
        //NSJSONWritingPrettyPrinted
    //error 是指转换JSON数据失败时,能够返回一个NSError对象,用来描述错误信息

    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", str);
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
