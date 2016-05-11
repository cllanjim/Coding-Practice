//
//  UIImage+SQImageExtension.h
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/4/14.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SQImageExtension)

- (instancetype)sq_circleImage;

+ (instancetype)sq_circleImageWithImageNamed:(NSString *)imageName;

@end
