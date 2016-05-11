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
    
    //非编辑状态下的多选模式
    self.tableView.allowsMultipleSelection = YES;
    //编辑状态下的多选模式
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - FunctionButton
- (IBAction)selectCell:(id)sender {
    //单选的编辑模式
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}


- (IBAction)removeCell:(id)sender {
    //创建数组用来保存需要删除的cell
    NSMutableArray *deleteArray = [NSMutableArray array];
    
    //遍历当前cell数据模型,并取出被选中的cell
    for (SQCellModel *modelData in self.groupOfModels) {
        if (modelData.isSelected == YES) {
            [deleteArray addObject:modelData];
        }
    }
    
    //移除选中的cell
    [self.groupOfModels removeObjectsInArray:deleteArray];
    
    //刷新数据
    [self.tableView reloadData];
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

#pragma mark - UITableViewDataSource
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
//        cell = [[SQCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    
    //读取自定义xib中的cell文件
    cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SQCell class]) owner:nil options:nil] lastObject];
    }
    cell.modelData = self.groupOfModels[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获得当前cell的模型
    SQCellModel *modelData = self.groupOfModels[indexPath.row];
    //为当前cell赋值
    modelData.selected = !modelData.isSelected;
    //刷新数据
    [self.tableView reloadData];
}



/*
#pragma mark - 左滑cell出现多个按钮的情况

//1. 只要实现了这个方法，左滑出现Delete按钮的功能就有了
//2. 点击了“左滑出现的Delete按钮”会调用这个方法
//UITableViewDataSource的方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView
                  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    //rowActionWithStyle rowAction的类型
    //title              rowAction的标题
    //handler            点击rowAction后执行的操作
    
    UITableViewRowAction *rowAction0 = [UITableViewRowAction
      rowActionWithStyle:UITableViewRowActionStyleDestructive
                   title:@"删除"
                 handler:^(UITableViewRowAction *_Nonnull action,
                           NSIndexPath *_Nonnull indexPath) {
                   [self.groupOfModels removeObjectAtIndex:indexPath.row];
                   [tableView
                       deleteRowsAtIndexPaths:@[ indexPath ]
                             withRowAnimation:UITableViewRowAnimationLeft];
                 }];

  UITableViewRowAction *rowAction1 = [UITableViewRowAction
      rowActionWithStyle:UITableViewRowActionStyleNormal
                   title:@"关注"
                 handler:^(UITableViewRowAction *_Nonnull action,
                           NSIndexPath *_Nonnull indexPath) {
                   NSLog(@"已关注");
                     //通过推出编辑模式让cell复原
                   tableView.editing = NO;
                 }];

  return @[ rowAction0, rowAction1 ];
}
*/



@end
