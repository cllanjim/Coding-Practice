//
//  ViewController.m
//  1010 NSURLConnection综合练习
//
//  Created by 张思琦 on 15/10/10.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *passCodeLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginIn:(id)sender;

@end

@implementation ViewController

- (IBAction)loginIn:(id)sender{

    //1获取用户名和密码
    NSString *userName = self.nameLabel.text;
    NSString *passCode = self.passCodeLabel.text;
    
    //2判断用户名和密码的Label中是否有数据
    if (userName.length <= 0) {
        [SVProgressHUD showErrorWithStatus:self.nameLabel.placeholder];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        return;
    }else if(passCode.length <= 0){
        [SVProgressHUD showErrorWithStatus:self.passCodeLabel.text];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    
    //提示用户正在登陆
    [SVProgressHUD showWithStatus:@"正在拼命登陆中"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    //创建url
    NSString *urlstr = [NSString stringWithFormat:@"http://120.25.226.186:32812/login"];
    //转码
    //方法一 被废弃
    //    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //方法二 ios9后使用
    [urlstr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //根据NSString对象创建NSURL对象
    NSURL *url = [NSURL URLWithString:urlstr];
    
    //创建一个post请求
    //创建NSRequest对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求头的请求方式为post
    request.HTTPMethod = @"POST";
    //设置请求体
    NSString *content = [NSString stringWithFormat:@"username=%@&pwd=%@&type=JSON", userName, passCode];
    request.HTTPBody = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    //利用NSURLConnection发送请求
    //下面的方法已经被 - dataTaskWithRequest:completionHandler: 取代

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        [SVProgressHUD dismiss];
        
        //提取响应体
        NSString *reponseData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",reponseData);
        //从响应体里截取字符串
        NSUInteger start = [reponseData rangeOfString:@":\""].location + 2;
        NSUInteger length = [reponseData rangeOfString:@"\"" options:NSBackwardsSearch].location - start;
        NSRange range = NSMakeRange(start, length);
        NSString *res = [reponseData substringWithRange:range];
        NSLog(@"%@",res);
        
        if ([reponseData containsString:@"error"]) {
            [SVProgressHUD showErrorWithStatus:res maskType:SVProgressHUDMaskTypeBlack];
        } else{
            [SVProgressHUD showErrorWithStatus:res maskType:SVProgressHUDMaskTypeBlack];
        }
        
        
    }];
    
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameLabel resignFirstResponder];
    [self.passCodeLabel resignFirstResponder];

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
