//
//  SQTopicPictureView.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/27.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQTopicPictureView.h"
#import "SQSeeBigViewController.h"

#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import <DALabeledCircularProgressView.h>
#import <SVProgressHUD.h>

@interface SQTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *processView;
@end


@implementation SQTopicPictureView
- (void)setTopicModel:(SQTopicModel *)topicModel{
    _topicModel = topicModel;
    
    //判断当前网络状态
    //获取当前的网络状态
    //    AFNetworkReachabilityStatusUnknown          = -1,
    //    AFNetworkReachabilityStatusNotReachable     = 0,
    //    AFNetworkReachabilityStatusReachableViaWWAN = 1,
    //    AFNetworkReachabilityStatusReachableViaWiFi = 2,
    //    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    //
    //    if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
    //        //手机网络,下载小图
    //        //下载图片
    //        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.small_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    //            //计算下载进度
    //            CGFloat progress = 1.0 * receivedSize / expectedSize;
    //            //下载过程中显示进度条
    //            self.processView.hidden = NO;
    //            //为progressView进度条赋值
    //            self.processView.progress = progress;
    //            self.processView.progressLabel.text = [NSString stringWithFormat:@"%.2f%%", progress];
    //        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //            //下载完毕后隐藏进度条
    //            self.processView.hidden = YES;
    //        }];
    //
    //    }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
    //        //无线网络下载大图
    //        //下载图片
    //        [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    //            //计算下载进度
    //            CGFloat progress = 1.0 * receivedSize / expectedSize;
    //            //下载过程中显示进度条
    //            self.processView.hidden = NO;
    //            //为progressView进度条赋值
    //            self.processView.progress = progress;
    //            self.processView.progressLabel.text = [NSString stringWithFormat:@"%.2f%%", progress];
    //        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //            //下载完毕后隐藏进度条
    //            self.processView.hidden = YES;
    //        }];
    //
    //    }else if(status == AFNetworkReachabilityStatusNotReachable){
    //        //网络有问题,提示网络没有连接
    //        [SVProgressHUD showErrorWithStatus:@"没有网络连接啊" maskType:SVProgressHUDMaskTypeBlack];
    //
    //    }else if(status == AFNetworkReachabilityStatusUnknown){
    //        //网络有问题,提示网络有错误
    //        [SVProgressHUD showErrorWithStatus:@"网络连接出问题啦" maskType:SVProgressHUDMaskTypeBlack];
    //    }else {
    //        //牛了逼了
    //        [SVProgressHUD showErrorWithStatus:@"这个问题比较屌..." maskType:SVProgressHUDMaskTypeBlack];
    //    }

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        //计算下载进度
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        //下载过程中显示进度条
        self.processView.hidden = NO;
        //为progressView进度条赋值
        self.processView.progress = progress;
        self.processView.progressLabel.text = [NSString stringWithFormat:@"%.2f%%", progress];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        //下载完毕后隐藏进度条
        self.processView.hidden = YES;
        
    }];
    
    //右上角的gif表示是否显示
    //方法一 判断图片地址中是否包含gif的字段
    //self.gifView.hidden = ![self.topicModel.large_image.lowercaseString hasSuffix:@"gif"];
    //方法二 判断图片地址的后缀名是否为GIF
    //self.gifView.hidden = ![self.topicModel.large_image.pathExtension.lowercaseString isEqualToString:@"gif"];
    //方法三 利用SDWebImage框架提供的拓展方法
    //NSDate的扩展方法sd_contentTypeForImageData方法获取图片类型
    //+ (NSString *)sd_contentTypeForImageData:(NSData *)data;
    //方法四
    self.gifView.hidden = ! topicModel.is_gif;
    
    //判定底部的button是否需要显示
    if (topicModel.isBigPicture) {
        self.seeBigButton.hidden = NO;
#warning 此处图片的显示模式应该为Top
//        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
    }else {
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = NO;
    }
}



- (void)awakeFromNib{
//    NSLog(@"%@ - %zd", [self class], self.autoresizingMask);
    self.autoresizingMask = UIViewAutoresizingNone;
    self.processView.roundedCorners = 5;
    self.processView.progressLabel.textColor = [UIColor whiteColor];
    
    //在imageView中添加手势识别器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
    
}


- (void)seeBigPicture{
    
    SQSeeBigViewController *vc = [[SQSeeBigViewController alloc] init];
    vc.topicModel = self.topicModel;
    
//    NSLog(@"%@",[[UIApplication sharedApplication].keyWindow.rootViewController  class]);
    //利用模态方式推出该控制器
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    
//    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    
}


@end
