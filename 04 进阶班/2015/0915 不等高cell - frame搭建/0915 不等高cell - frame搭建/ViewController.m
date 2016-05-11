//
//  ViewController.m
//  0915 不等高cell - frame搭建
//
//  Created by 张思琦 on 15/9/15.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQCell.h"
#import "MJExtension.h"


@interface ViewController ()


@property (nonatomic, strong) NSArray *groupOfModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - groupOfModel Lazy
- (NSArray *)groupOfModel{
    if (_groupOfModel == nil) {
        
        //MJExtension中是哪个模型要获取字典中的数据就哪个模型使用对应的方法
        //下面的方法是将  模型中的属性  与  字典的key  值对应起来
        [SQCellModel setupReplacedKeyFromPropertyName:^NSDictionary *{
           return @{
                    @"text_Label_text"              : @"text",
                    @"name_Label_text"              : @"name",
                    @"user_ImageView_ImageName"     : @"icon",
                    @"text_ImageView_ImageName"     : @"picture",
                    @"isVIP"                        : @"vip"
                    };
        }];
        _groupOfModel = [SQCellModel objectArrayWithFilename:@"statuses.plist"];
        
    }
    return _groupOfModel;
}


#pragma mark - viewControllerDataDelegate

//tableView的section数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//tableView的row数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.groupOfModel.count;
}

//cell的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1从缓存池中取出相应的cell
    static NSString *ID = @"cell";
    SQCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //2判断cell是否为空并创建cell
    if (cell == nil) {
        cell = [[SQCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    //3为cell设置数据
    SQCellModel *modelData = self.groupOfModel[indexPath.row];
    cell.modelData = modelData;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SQCellModel *modelData = self.groupOfModel[indexPath.row];
    return modelData.cellHeight;
}

@end
