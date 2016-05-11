//
//  ViewController.m
//  1207 文件的压缩与解压缩
//
//  Created by 张思琦 on 15/12/7.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

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
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/upload"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //设置请求头
    request.HTTPMethod = @"POST";
    //content-type为multipart/form-data时代表需要上传文件
    [request setValue:@"multipart/form-data; boundary=----SQ" forHTTPHeaderField:@"Content-Type"];
    
    //设置请求体
    //创建二进制对象并拼接该对象
    NSMutableData *data = [NSMutableData data];
    
    //设置文件参数
    [data appendData:[@"------SQ" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //name:对应服务端接受的字段类型
    //fileName:告诉服务端当前上传文件的名称
    [data appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"Life is a Dance.xlsx\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [data appendData:[@"Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
 dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"Snip20151209_5"]);
    [data appendData:imageData];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    //设置非文件参数
    [data appendData:[@"------SQ" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [data appendData:[@"Content-Disposition:form-data; name=\"username\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"zsq" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

    //设置结束符号
    [data appendData:[@"------SQ--" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //将二进制对象赋值给请求体
    
//    NSString *length = [NSString stringWithFormat:@"%zd",data.length];
//    [request setValue:length forHTTPHeaderField:@"Content-Length"];
    
    request.HTTPBody = data;
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //将服务器返回的响应体打印出来
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
}

@end
