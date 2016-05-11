//
//  SQPerson.h
//  MJExtension的映射机制
//
//  Created by 张思琦 on 16/3/25.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQClothes.h"
#import "SQBook.h"

@interface SQPerson : NSObject


@property (nonatomic, strong) NSString *personID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, strong) NSArray<SQClothes *> *clothes;
@property (nonatomic, strong) NSArray<SQBook *> *books;
@property (nonatomic, strong) NSString *other;

@end
