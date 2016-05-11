//
//  ViewController.m
//  0921 数据刷新-全局刷新
//
//  Created by 张思琦 on 15/9/21.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "SQCell.h"
#import "SQCellModel.h"
#import "MJExtension.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *groupOfModels;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    NSLog(@"%@",self.groupOfModels);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - FunctionButton
- (IBAction)remove:(id)sender {
    
    [self.groupOfModels removeObjectAtIndex:0];
    [self.groupOfModels removeObjectAtIndex:0];
    
    
    //生成对应的序号数组
    NSArray *indexPaths = @[
                            [NSIndexPath indexPathForRow:0 inSection:0],
                            [NSIndexPath indexPathForRow:1 inSection:0]
                            ];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
    
    
}

#pragma mark - groupOfModels Lazy
- (NSMutableArray *)groupOfModels{
    if (_groupOfModels == nil ) {
        
        [SQCellModel setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"winePicture" :@"image",
                     @"winePrice" :@"money",
                     @"wineName" :@"name"
                     };
        }];
        
      _groupOfModels = [SQCellModel objectArrayWithFilename:@"wine.plist"];
        
    }
    return _groupOfModels;
}

#pragma mark - UITableViewDataSource Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.groupOfModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    SQCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SQCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.modelData = self.groupOfModels[indexPath.row];
    return cell;
}


#pragma mark - 左滑cell出现单个按钮的情况

//1. 只要实现了这个方法，左滑出现Delete按钮的功能就有了
//2. 点击了“左滑出现的Delete按钮”会调用这个方法
//UITableViewDataSource的方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除对应的模型
    [self.groupOfModels removeObjectAtIndex:indexPath.row];
    //刷新数据
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

//修改Delete按钮文字为指定文字
//UITableViewDelegate的方法
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

@end
