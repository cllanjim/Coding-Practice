//
//  SQSettingViewController.m
//  1105 BaiSiBuDeJie
//
//  Created by 张思琦 on 15/11/7.
//  Copyright © 2015年 SQ Software Group. All rights reserved.
//

#import "SQSettingViewController.h"
#import "SQTestViewController.h"
#import "SQClearCacheCell.h"
#import "SQNormalCell.h"
#import "SQSpecialCell.h"
#import <SDWebImage/SDImageCache.h>

@interface SQSettingViewController () 



@end

@implementation SQSettingViewController

//cell的标示符
static NSString * const SQClearCacheCellID = @"SQClearCacheCell";
static NSString * const SQNormalCellID = @"SQNormalCellID";
static NSString * const SQSpecialCellID = @"SQSpecialCellID";

#pragma mark - 生命周期相关的方法
- (void)dealloc{
    SQLOGFUNC;
}

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

    //利用注册的方式循环利用cell
    
    //注册缓存cell
    [self.tableView registerClass:[SQClearCacheCell class] forCellReuseIdentifier:SQClearCacheCellID];

    //注册普通cell
    [self.tableView registerClass:[SQNormalCell class] forCellReuseIdentifier:SQNormalCellID];
    
    //注册特定cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SQSpecialCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:SQSpecialCellID];
    
//    //用于验证缓存计算方法的代码
//    // 获得缓存文件夹路径
//    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//    NSString *fullPath = [cachesPath stringByAppendingPathComponent:@"default"];
//    fullPath = [fullPath stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
//    NSLog(@"%lu",[fullPath fileSiez01]);
//    NSLog(@"%lu",[fullPath fileSiez02]);
//    NSLog(@"%lu",(unsigned long)[SDImageCache sharedImageCache].getSize);


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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //用于返回section中cell数量的变量
    NSInteger number = 0;
    //判断条件
    if(section == 0){
        number = 1;
    }else if(section == 1){
        number = 8;
    }
    
    return number;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //用于返回section内容的字符串
    NSString *title = [NSString string];
    //判断条件
    if(section == 0){
        title = @"功能设置";
    }else if(section == 1){
        title = @"其他";
    }
    
    return title;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    //使用原始方法获取cell
//    //创建标示符
//    static NSString *identify = @"settingCell";
//    //从缓存池中取出带有标示符的cell
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify ];
//    
//    //创建cell
//    if(cell == nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
//        
//    }
    
    
    //使用注册方法获取cell
    UITableViewCell *cell;
    
    if (indexPath.section == 0 ) {
        //此时返回SQSpecialCell
        cell = [tableView dequeueReusableCellWithIdentifier:SQSpecialCellID];
    } else if(indexPath.section == 1 && indexPath.row == 0){
        //此时返回SQClearCacheCell
        cell = [tableView dequeueReusableCellWithIdentifier:SQClearCacheCellID];
    } else if(indexPath.section == 1 && indexPath.row == 1){
        //推荐给朋友
        cell = [tableView dequeueReusableCellWithIdentifier:SQNormalCellID];
        cell.textLabel.text = @"推荐给朋友";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if(indexPath.section == 1 && indexPath.row == 2){
        
        cell = [tableView dequeueReusableCellWithIdentifier:SQNormalCellID];
        cell.textLabel.text = @"帮助";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if(indexPath.section == 1 && indexPath.row == 3){
        
        cell = [tableView dequeueReusableCellWithIdentifier:SQNormalCellID];
        cell.textLabel.text = @"当前版本: 4.0";
        
    }else if(indexPath.section == 1 && indexPath.row == 4){
        
        cell = [tableView dequeueReusableCellWithIdentifier:SQNormalCellID];
        cell.textLabel.text = @"关于我们";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if(indexPath.section == 1 && indexPath.row == 5){
        
        cell = [tableView dequeueReusableCellWithIdentifier:SQNormalCellID];
        cell.textLabel.text = @"设备信息";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if(indexPath.section == 1 && indexPath.row == 6){
        
        cell = [tableView dequeueReusableCellWithIdentifier:SQNormalCellID];
        cell.textLabel.text = @"隐私政策";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if(indexPath.section == 1 && indexPath.row == 7){
        
        cell = [tableView dequeueReusableCellWithIdentifier:SQNormalCellID];
        cell.textLabel.text = @"打分支持不得姐";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    

    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SQLOGFUNC;
}

#pragma mark - 计算缓存大小 此处代码已经封装到NSString的分类中
//- (void)getCacheSize
//{
//    // 总大小
//    unsigned long long size = 0;
//    
//    // 文件管理者
//    NSFileManager *mgr = [NSFileManager defaultManager];
//    // 获得缓存文件夹路径
//    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//    //获取全部子文件的路径
//    NSArray *subpaths = [mgr subpathsAtPath:cachesPath];
//    for (NSString *subpath in subpaths) {
//        // 方法一
//        // 补全路径,获取文件的全路径
//        NSString *fullSubpath = [cachesPath stringByAppendingPathComponent:subpath];
//        // 获取文件属性字典
//        NSDictionary *attrs = [mgr attributesOfItemAtPath:fullSubpath error:nil];
//        // 累加文件大小
//        size += attrs.fileSize;
//        
//        //方法二
////        // 补全路径,获取文件的全路径
////        NSString *fullSubpath = [cachesPath stringByAppendingPathComponent:subpath];
////        // 获取文件属性字典
////        NSDictionary *attrs = [mgr attributesOfItemAtPath:fullSubpath error:nil];
////        // 累加文件大小
////        size += [attrs[NSFileSize] unsignedIntegerValue];
//    }
//    
//    SQLOG(@"%zd", size);
//}


//- (void)getCacheSizeUesNSDirectoryEnumerator{
//    //用于保存文件大小的参数
//    unsigned long long size = 0;
//   
//    //创建文件管理者
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    //获取指定文件夹路径
//    //获取沙盒中的cache文件夹
//    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//    //获取沙盒中cache文件夹里指定的缓存文件路径
//    NSString *filePath = [cachePath stringByAppendingString:@"default"];
//    
//    //NSDirectoryEnumerator是一个文件夹枚举器,用来描述文件夹中文件的相对路径
//    NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:filePath];
//    for (NSString *subPath in enumerator) {
//        //组成绝对路径
//        NSString *fullPath = [filePath stringByAppendingPathComponent:subPath];
//        //stringByAppending方法有多种
//        //stringByAppendingPathComponent    返回的字符串符合路径格式
//        //stringByAppendingFormat           返回的字符串是指定格式的字符串
//        //stringByAppendingString           返回的字符串后面添加指定的字符串
//        //stringByAppendingPathExtension
//
//        //计算文件大小
//        //获取文件特性的字典,然后调用fileSize方法计算大小
//        size += [fileManager attributesOfItemAtPath:fullPath error:nil].fileSize;
//    }
//}


@end
