//
//  SQTopicCell.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/3/19.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQTopicCell.h"
#import "SQTopicModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+SQViewExtension.h"

#import "SQTopicPictureView.h"
#import "SQTopicVideoView.h"
#import "SQTopicVoiceView.h"

@interface SQTopicCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

//中间部分的控件
@property (nonatomic, strong) SQTopicPictureView *pictureView;
@property (nonatomic, strong) SQTopicVideoView *videoView;
@property (nonatomic, strong) SQTopicVoiceView *voiceView;

@end

@implementation SQTopicCell

#pragma mark - lazy of property
- (SQTopicPictureView *)pictureView{
    if (!_pictureView) {
        SQTopicPictureView *pictureView = [SQTopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (SQTopicVideoView *)videoView{
    if (!_videoView) {
        SQTopicVideoView *videoView = [SQTopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (SQTopicVoiceView *)voiceView{
    if(!_voiceView){
        SQTopicVoiceView *voiceView = [SQTopicVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}


#pragma mark - 生命周期类方法
- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 设置背景图片
    UIImage *image = [UIImage imageNamed:@"mainCellBackground"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch];
    self.backgroundView = [[UIImageView alloc] initWithImage:image];
}


#pragma mark - 重写topic的set方法
- (void)setTopicModel:(SQTopicModel *)topicModel{
    
    _topicModel = topicModel;
    
    //设置头像
    [self.profileImageView setHeader:topicModel.profile_image];
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    //设置昵称
    self.nameLabel.text = topicModel.name;
    //设置创建时间
    self.createdAtLabel.text = topicModel.created_at;
    //设置正文文本内容
    self.text_Label.text= topicModel.text;
    
    //设置底部工具栏的button
    
    [self setupButton:self.dingButton number:topicModel.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:topicModel.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:topicModel.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:topicModel.comment placeholder:@"评论"];
    
    //当数组中的对象为字典时
//    //最热评论模块
//    //@property (nonatomic, strong) NSArray *top_cmt;
//    //设置最热评论模块
//    NSDictionary *commentModel = topicModel.top_cmt.firstObject;
//
//    if (commentModel == nil) {
//        //如果字典为空就隐藏该模块
//        self.topCmtView.hidden = YES;
//    }else{
//        //如果字典不为空就显示该模块
//        self.topCmtView.hidden = NO;
//        //向topCmtContentLabel中添加文字
//        NSString *username = commentModel[@"user"][@"username"];
//        NSString *content = commentModel[@"content"];
//        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
//    }
    
    //当数组中的对象不为字典时
    //@property (nonatomic, strong) NSArray <SQUserModel *> *top_cmt;
    
    
    //使用MJExtension将数组中的元素更换为SQCommentModel类
//    SQCommentModel *commentModel = topicModel.top_cmt.firstObject;
//    
//    if (commentModel == nil) {
//        //如果字典为空就隐藏该模块
//        self.topCmtView.hidden = YES;
//    }else{
//        //如果字典不为空就显示该模块
//        self.topCmtView.hidden = NO;
//        //向topCmtContentLabel中添加文字
//        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", commentModel.user.username, commentModel.content];
//    }
    
    
    SQCommentModel *commentModel = topicModel.top_cmt;
    
    if (commentModel == nil) {
        //如果字典为空就隐藏该模块
        self.topCmtView.hidden = YES;
    }else{
        //如果字典不为空就显示该模块
        self.topCmtView.hidden = NO;
        //向topCmtContentLabel中添加文字
        NSString *username = commentModel.user.username;
        NSString *content = (topicModel.top_cmt.voiceuri.length != 0) ? @"语音评论": topicModel.top_cmt.content;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    }
    
    
    //用于判断当前代码中间部分是何种控件
    if(topicModel.type == SQTopicTypeVideo){//中间为视频帖子
        self.videoView.hidden = NO;
        self.videoView.frame = self.topicModel.contentFrame;
        self.videoView.topicModel = topicModel;

        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }else if (topicModel.type == SQTopicTypeWord){//中间为文字帖子
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    }else if(topicModel.type == SQTopicTypeVoice){//中间为声音帖子
        self.voiceView.hidden = NO;
        self.voiceView.frame = self.topicModel.contentFrame;
        self.voiceView.topicModel = topicModel;

        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    }else if(topicModel.type == SQTopicTypePicture){//中间为图片帖子
        self.pictureView.hidden = NO;
        self.pictureView.frame = self.topicModel.contentFrame;
        self.pictureView.topicModel = topicModel;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
}


- (void)setupButton:(UIButton *)button number:(NSUInteger)number placeholder:(NSString *)placeholder{

    if (number > 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    }else{
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

#pragma mark - setFrame方法来调整cell大小
- (void)setFrame:(CGRect)frame{
    //调整上下间距
    frame.size.height -= SQCommonMargin;
    frame.origin.y += SQCommonMargin;
    //调整左右间距
//    frame.origin.x += SQCommonMargin;
//    frame.size.width -= 2 * SQCommonMargin;
    
    [super setFrame:frame];
}


#pragma mark - 点击更多按钮时候的操作
- (IBAction)moreButtonClick:(id)sender {
    //创建alertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    //添加alertController的选项
    [alertController addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SQLOG(@"收藏");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SQLOG(@"举报");
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SQLOG(@"取消");
    }]];
    //弹出UIAlertController
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end
