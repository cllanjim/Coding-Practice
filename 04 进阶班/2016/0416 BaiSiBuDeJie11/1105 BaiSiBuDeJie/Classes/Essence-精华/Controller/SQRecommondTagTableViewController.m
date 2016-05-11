//
//  SQRecommondTagTableViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 16/4/14.
//  Copyright © 2016年 SQ Software Group. All rights reserved.
//

#import "SQRecommondTagTableViewController.h"
#import "SQHTTPSessionManager.h"
#import "SQRecommondTagModel.h"
#import "SQRecommondTagCell.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface SQRecommondTagTableViewController ()

@property (nonatomic, strong) SQHTTPSessionManager *manager;
@property (nonatomic, strong) NSArray *groupOfRecommondTagModel;

@end

@implementation SQRecommondTagTableViewController
#pragma mark - lazy
- (SQHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [SQHTTPSessionManager manager];
    }
    return _manager;
}

- (NSArray *)groupOfRecommondTagModel{
    if (_groupOfRecommondTagModel == nil) {
        _groupOfRecommondTagModel = [NSArray array];
    }
    return _groupOfRecommondTagModel;
}


static NSString * const recommondTagCellID = @"recommondTag";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设定标题
    self.navigationItem.title = @"推荐标签";
    //注册cell的类型
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SQRecommondTagCell class]) bundle:nil]forCellReuseIdentifier:recommondTagCellID];
    //设定cell的高度
    self.tableView.rowHeight = 70;
    //设定背景色
    self.tableView.backgroundColor = SQCommonBgColor;
    //设定分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadNewRecommondTag];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载数据
- (void)loadNewRecommondTag{
    
    //[SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    
    //设置发送请求的参数
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"a"] = @"tag_recommend";
    parameter[@"action"] = @"sub";
    parameter[@"c"] = @"topic";
    

    __weak typeof(self) weakSelf = self;
    [self.manager GET:SQCommonURL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //将获取的字典数据转换为模型数据
            weakSelf.groupOfRecommondTagModel = [SQRecommondTagModel mj_objectArrayWithKeyValuesArray:responseObject ];
            //重新加载数据
            [weakSelf.tableView reloadData];
            //取消HUD
            [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //如果是用户取消网络请求,就直接弹出
        if (error.code == NSURLErrorCancelled) {
            return ;
        }
        //如果是其他原因就弹出网络出现问题的弹框
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络出现问题"];
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //隐藏HUD
    [SVProgressHUD dismiss];
    
    //取消网络请求
    //方法一
    //[self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //方法二
    [self.manager invalidateSessionCancelingTasks:YES];
}

//- (void)dealloc{
//    SQLOGFUNC;
//    //dismiss
//    //取消网络请求
//}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupOfRecommondTagModel.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    SQRecommondTagCell *cell = [tableView dequeueReusableCellWithIdentifier:recommondTagCellID];
    cell.tagModel = self.groupOfRecommondTagModel[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
