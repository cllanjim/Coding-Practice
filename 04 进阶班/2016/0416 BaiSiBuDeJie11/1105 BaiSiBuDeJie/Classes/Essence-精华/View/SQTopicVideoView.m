//
//  SQTopicVideoView.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/27.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQTopicVideoView.h"
#import "SQSeeBigViewController.h"

#import <AFNetworking.h>
#import <UIImageView+WebCache.h>


@interface SQTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;

@end

@implementation SQTopicVideoView


- (void)awakeFromNib{
    //    NSLog(@"%@ - %zd", [self class], self.autoresizingMask);
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //在imageView中添加手势识别器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];

}

- (void)setTopicModel:(SQTopicModel *)topicModel{
    _topicModel = topicModel;

    
    [self.imageView sd_setImageWithURL:[NSURL  URLWithString:topicModel.large_image]];
    
    //设置播放次数的lable
    self.playCountLabel.text =  [NSString stringWithFormat:@"%zd播放", topicModel.playcount];
    
    //设置播放时间的lable
    NSInteger minute = topicModel.voicetime / 60;
    NSInteger second = topicModel.voicetime % 60;
    
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
}


- (void)seeBigPicture{
    
    SQSeeBigViewController *vc = [[SQSeeBigViewController alloc] init];
    vc.topicModel = self.topicModel;
    
    //利用模态方式推出该控制器
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    
}

- (IBAction)playVIdeo:(id)sender {
    SQLOGFUNC;

}
@end
