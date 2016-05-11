//
//  ViewController.m
//  1013 复杂JSON数据解析
//
//  Created by 张思琦 on 15/10/13.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import <MediaPlayer/MPMoviePlayerViewController.h>

@interface ViewController ()

@property (nonatomic, strong) NSArray *videos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设定行高
    self.tableView.rowHeight = 150;
    
    //创建URL对象
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/video?type=JSON"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //将服务器响应的数据返回到self.videos中
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        self.videos = dict[@"videos"];
        [dict writeToFile:@"/Users/SketchK/Desktop/videos.plist" atomically:YES];
        //获取数据后刷新tableView
        [self.tableView reloadData];
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UITableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary *dict = self.videos[indexPath.row];
    
    cell.textLabel.text = dict[@"name"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时长: %@", dict[@"length"]];
    
    NSString *url = [NSString stringWithFormat:@"http://120.25.226.186:32812/%@", dict[@"image"]];
    url  = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取出视频的url信息
    NSDictionary *dict = self.videos[indexPath.row];
    
    //拼接地址
    NSString *str = [NSString stringWithFormat:@"http://120.25.226.186:32812/%@", dict[@"url"]];
    //转换NSString中的中文字符
    [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //生成url
    NSURL *url = [NSURL URLWithString:str];
    
    //播放视频
    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

@end
