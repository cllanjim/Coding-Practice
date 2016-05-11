//
//  SQCommentCell.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/4/17.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQCommentCell.h"

@interface SQCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likecountLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;


@end

@implementation SQCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];

    UIImage *image = [UIImage imageNamed:@"mainCellBackground"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch];
    self.backgroundView = [[UIImageView alloc] initWithImage:image];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 重写commentModel的set方法
- (void)setCommentModel:(SQCommentModel *)commentModel{
    _commentModel = commentModel;
    
    //设置头像
    [self.profileImage setHeader:commentModel.user.profile_image];
    
    //设置性别标识
    NSString *imageName = [commentModel.user.sex isEqualToString:SQUserSexMale] ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexImage.image = [UIImage imageNamed:imageName];
    
    //设置用户名
    self.usernameLabel.text = commentModel.user.username;
    
    //设置赞的数量
    self.likecountLabel.text = [NSString stringWithFormat:@"%zd", commentModel.like_count] ;
    
    //设置内容
    self.countLabel.text = commentModel.content;
    
    //设置声音
    if (commentModel.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", commentModel.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
    }
}

@end
