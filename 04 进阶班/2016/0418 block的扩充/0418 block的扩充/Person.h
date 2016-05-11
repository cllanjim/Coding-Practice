//
//  Person.h
//  0418 block的扩充
//
//  Created by 张思琦 on 16/4/18.
//  Copyright © 2016年 SketchK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) void (^eatFood) (NSString *, NSString *) ;
@property (nonatomic, copy) void (^playBall) (NSString *, NSString *) ;

@end
