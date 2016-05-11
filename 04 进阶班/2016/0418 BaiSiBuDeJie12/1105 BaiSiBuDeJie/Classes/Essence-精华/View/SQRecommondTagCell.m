//
//  SQRecommondTagCell.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/4/14.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQRecommondTagCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface SQRecommondTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *recommondImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end


@implementation SQRecommondTagCell

- (void)awakeFromNib{
    
//    NSLog(@"%f",self.recommondImageView.sq_width);
//    self.recommondImageView.layer.cornerRadius = self.recommondImageView.sq_width * 0.5;
}


- (void)setTagModel:(SQRecommondTagModel *)tagModel{
    //将传入的模型数值赋值
    _tagModel = tagModel;
    
    //设置recommondImageView的头像为圆形
    [self.recommondImageView sq_setHeader:tagModel.image_list];
//    UIImage *placeholderImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
//    //为recommondImageView赋值
//    [self.recommondImageView sd_setImageWithURL:[NSURL URLWithString: tagModel.image_list] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
////        //使用Quartz2D绘制圆形
////        NSLog(@"%@",NSStringFromCGSize(image.size));
////        //开启图形上下文
////        UIGraphicsBeginImageContext(image.size);
////        //获取上下文
////        CGContextRef ctx = UIGraphicsGetCurrentContext();
////        //设定矩形框
////        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
////        //在指定的图形上下文中,根据矩形框添加圆形
////        CGContextAddEllipseInRect(ctx, rect);
////        //裁剪
////        CGContextClip(ctx);
////        //绘制图片
////        [image drawInRect:rect];
////        //获取图片对象,并赋值
////        self.recommondImageView.image = UIGraphicsGetImageFromCurrentImageContext();
////        //关闭上下文
////        UIGraphicsEndImageContext();
//        
//        if (image == nil) {
//            return ;
//        }
//        
//        self.recommondImageView.image = [image circleImage];
//        
//    } ];
    
    //设置nameLabel的文字内容
    self.nameLabel.text = tagModel.theme_name;
    
    if (tagModel.sub_number >= 10000) {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f人订阅", tagModel.sub_number / 10000.0];
    } else {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅", tagModel.sub_number];
    }
    
}

- (void)setFrame:(CGRect)frame{
    //高度减少1后,利用背景色,制造出分割线
    frame.size.height -= 1;
    [super setFrame:frame];
}


@end
