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


@end

@implementation SQTopicCell

- (void)awakeFromNib {
    // 设置背景图片
    
    UIImage *image = [UIImage imageNamed:@"mainCellBackground"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:image];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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


#pragma mark - 重写topic的set方法
- (void)setTopicModel:(SQTopicModel *)topicModel{
    
    _topicModel = topicModel;
    
    //设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
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
    frame.origin.x += SQCommonMargin;
    frame.size.width -= 2 * SQCommonMargin;
    
    [super setFrame:frame];
}



@end
