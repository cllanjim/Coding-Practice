//
//  SQModelOfShop.m
//  0805 自定义等高cell - atuolayout方法
//
//  Created by 张思琦 on 15/8/8.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "SQModelOfShop.h"
#import "Masonry.h"
#import "SQModelOfShopInfo.h"

@implementation SQModelOfShop

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //初始化shopPhotoImageView
        UIImageView *shopPhotoImageView = [[UIImageView alloc] init];
        shopPhotoImageView.backgroundColor = [UIColor lightGrayColor];
        self.shopPhotoImageView = shopPhotoImageView;
        [self.contentView addSubview:shopPhotoImageView];
        
        //初始化shopNameLabel
        UILabel *shopNameLabel = [[UILabel alloc] init];
        shopNameLabel.backgroundColor = [UIColor lightGrayColor];
        self.shopNameLabel = shopNameLabel;
        [self.contentView addSubview:shopNameLabel];
        
        //初始化shopPriceLabel
        UILabel *shopPriceLabel = [[UILabel alloc] init];
        shopPriceLabel.backgroundColor = [UIColor lightGrayColor];
        self.shopPriceLabel = shopPriceLabel;
        [self.contentView addSubview:shopPriceLabel];
        
        //初始化shopBuyCountLabel
        UILabel *shopBuyCountLabel = [[UILabel alloc] init];
        shopBuyCountLabel.backgroundColor = [UIColor lightGrayColor];
        self.shopBuyCountLabel = shopBuyCountLabel;
        [self.contentView addSubview:shopBuyCountLabel];
        
        //取消autoresizing功能
        self.shopPhotoImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.shopNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.shopPriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.shopBuyCountLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        //布局shopPhotoImageView
        [self.shopPhotoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-10);
            make.left.equalTo(self.contentView.mas_left).with.offset(10);
            make.width.equalTo(@80);
        }];
        
        //布局shopNameLabel
        [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shopPhotoImageView.mas_top);
            make.left.equalTo(self.shopPhotoImageView.mas_right).with.offset(10);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.height.equalTo(@20);
        }];
        
        //布局shopPriceLabel
        [self.shopPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shopNameLabel.mas_bottom).with.offset(10);
            make.bottom.equalTo(self.shopPhotoImageView);
            make.left.equalTo(self.shopNameLabel);
            make.width.equalTo(@100);
        }];
        
        //布局shopBuyCountLabel
        [self.shopBuyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shopPriceLabel.mas_top);
            make.bottom.equalTo(self.shopPhotoImageView);
            make.right.equalTo(self.shopNameLabel.mas_right);
            make.width.equalTo(@80);
        }];
        
    }
    
    return self;
}


- (void)setShopInfo:(SQModelOfShopInfo *)shopInfo{
    _shopInfo = shopInfo;
    
    self.shopPhotoImageView.image = shopInfo.image;
    self.shopNameLabel.text = shopInfo.title;
    self.shopPriceLabel.text = shopInfo.price;
    self.shopBuyCountLabel.text = shopInfo.buyCount;

}




@end
