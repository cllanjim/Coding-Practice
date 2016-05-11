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

@interface ViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *groupOfModels;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    NSLog(@"%@",self.groupOfModels);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - FunctionButton
- (IBAction)addButton:(id)sender {
    SQCellModel *newModel = [[SQCellModel alloc] init];
    newModel.winePrice = @"20.5";
    newModel.wineName = @"百年牛栏山";
    newModel.winePicture = @"new_wine";
    [self.groupOfModels insertObject:newModel atIndex:0];
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

@end
