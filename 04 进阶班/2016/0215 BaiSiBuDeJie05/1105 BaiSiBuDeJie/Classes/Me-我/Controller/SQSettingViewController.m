//
//  SQSettingViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/7.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQSettingViewController.h"
#import "SQTestViewController.h"

@interface SQSettingViewController () 

@end

@implementation SQSettingViewController

#pragma mark - 重写init方法
- (instancetype)init{
    self = [super init];
    if (self) {
        self = [self initWithStyle:UITableViewStyleGrouped];
    }
    return self;
}


#pragma mark - 生命周期相关
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SQCommonBgColor;
    self.navigationItem.title = @"设置";
    // Do any additional setup after loading the view.
    [self getCacheSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//      //测试NavigationController时使用的代码
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    SQLOGFUNC;
//    SQTestViewController *vc = [[SQTestViewController alloc] init];
////    vc.view.backgroundColor = SQRandomColor;
////    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
//    
//}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建标示符
    static NSString *identify = @"settingCell";
    //从缓存池中取出带有标示符的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify ];
    
    //创建cell
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
    }
    
    cell.textLabel.text = @"清除缓存";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma mark - 计算缓存大小
- (void)getCacheSize
{
    // 总大小
    unsigned long long size = 0;
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 获得缓存文件夹路径
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    //获取全部子文件的路径
    NSArray *subpaths = [mgr subpathsAtPath:cachesPath];
    for (NSString *subpath in subpaths) {
        // 方法一
        // 补全路径,获取文件的全路径
        NSString *fullSubpath = [cachesPath stringByAppendingPathComponent:subpath];
        // 获取文件属性字典
        NSDictionary *attrs = [mgr attributesOfItemAtPath:fullSubpath error:nil];
        // 累加文件大小
        size += attrs.fileSize;
        
        //方法二
//        // 补全路径,获取文件的全路径
//        NSString *fullSubpath = [cachesPath stringByAppendingPathComponent:subpath];
//        // 获取文件属性字典
//        NSDictionary *attrs = [mgr attributesOfItemAtPath:fullSubpath error:nil];
//        // 累加文件大小
//        size += [attrs[NSFileSize] unsignedIntegerValue];
    }
    
    SQLOG(@"%zd", size);
}


@end
