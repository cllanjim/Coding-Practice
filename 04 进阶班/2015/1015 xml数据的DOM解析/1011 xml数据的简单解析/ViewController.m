//
//  ViewController.m
//  1011 xml数据的简单解析
//
//  Created by 张思琦 on 15/10/14.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import <MJExtension/MJExtension.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoDataModel.h"
#import "GDataXML/GDataXMLNode.h"

@interface ViewController ()
//<NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *videos;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [VideoDataModel setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID" : @"id"};
    }];
    
    self.tableView.rowHeight = 150;
    
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/video?type=XML"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
       
        
        /***************************** SAX的解析方式  *******************************/
//        //获得的响应体中的数据为XML数据
//        //利用响应体数据data创建NSXMLParser对象
//        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
//        //设置data的代理
//        NSLog(@"%@",parser);
//        parser.delegate = self;
//        //开始解析数据
//        [parser parse];
        
        
        /*************************** DOM解析方式 ********************************/
        //创建解析器,获取整个XML文档
        GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data options:kNilOptions error:nil];
        //获取根元素
        GDataXMLElement *rootElement = document.rootElement;
        //从根元素中获取所有指定名称的元素并存入数组
        NSArray *groupOfElement = [rootElement elementsForName:@"video"];
        //遍历取出的元素数组并进行转换
        for (GDataXMLElement *element in groupOfElement) {
            VideoDataModel *dataModel = [[VideoDataModel alloc] init];
            //attributeForName: 取属性结点,返回GDataXMLNode对象,再调stringValue即可取到属性值
            //stringValue： 取标签间的字符串值
            dataModel.ID  = [[element attributeForName:@"id"] stringValue];
            dataModel.name  = [[element attributeForName:@"name"] stringValue];
            dataModel.length  = [[element attributeForName:@"length"] stringValue];
            dataModel.image  = [[element attributeForName:@"image"] stringValue];
            dataModel.url  = [[element attributeForName:@"url"] stringValue];

            //将赋值好的元素添加到模型数组中
            [self.videos addObject:dataModel];
        }
        
        //当获得所有数据后刷新表格
        [self.tableView reloadData];
    }];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    VideoDataModel *dataModel = self.videos[indexPath.row];
    
    cell.textLabel.text = dataModel.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时间:%@", dataModel.length];
    
    NSString *imageURL = [NSString stringWithFormat:@"http://120.25.226.186:32812/%@", dataModel.image];
    imageURL = [imageURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:nil];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    VideoDataModel *dataModel = self.videos[indexPath.row];
   
    NSString *videoStr = [NSString stringWithFormat:@"http://120.25.226.186:32812/%@", dataModel.url];
    NSURL *videoURL = [NSURL URLWithString:videoStr];
    
//    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:videoURL options:nil];
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
//    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    
    
    AVPlayer *player = [AVPlayer playerWithURL:videoURL];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerLayer.frame = self.view.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    self.player = player;
    self.playerLayer = playerLayer;
    [self.player play];
    
    
}

#pragma mark - lazy
- (NSArray *)videos{
    if (_videos == nil) {
        _videos = [NSMutableArray array];
    }
    return _videos;
}

#pragma mark - NSXMLParserDelegate
/*
//开始解析xml文档时调用
- (void)parserDidStartDocument:(NSXMLParser *)parser{
//    NSLog(@"parserDidStartDocument");
}

//结束解析xml文档时调用
- (void)parserDidEndDocument:(NSXMLParser *)parser{
//    NSLog(@"parserDidEndDocument");
    //当获得所有数据后,刷新界面
    [self.tableView reloadData];
}

//开始解析元素时调用
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
//    NSLog(@"%@",elementName);
//    NSLog(@"%@",attributeDict);
    
    //elementName 元素名称
    //attributeDict 元素中的属性
    //A dictionary that contains any attributes associated with the element. Keys are the names of attributes, and values are attribute values.
    if ([elementName isEqualToString:@"videos"]) {
        return;
    }
    //将获取的元素转换为dataModel
    VideoDataModel *dataModel = [VideoDataModel objectWithKeyValues:attributeDict];
    [self.videos addObject:dataModel];
}

//结束解析元素时调用
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
//    NSLog(@"didEndElement");
}


- (void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError{
//    NSLog(@"validationErrorOccurred");
}
*/
@end
