//
//  ViewController.m
//  0904 多图片下载的优化
//
//  Created by 张思琦 on 15/9/4.
//  Copyright (c) 2015年 SQ Software Group. All rights reserved.
//

#import "ViewController.h"
#import "CellModel.h"

@interface ViewController ()
/**
 *  用来保存cell的所有模型
 */
@property (nonatomic, strong) NSArray *groupOfCellModel;

/**
 *  用来缓存cell中所有的image数据
 */
@property (nonatomic, strong) NSMutableDictionary *imageCache;

/**
 *  用来缓存cell中所有下载操作的数据
 */
@property (nonatomic, strong) NSMutableDictionary *operationCache;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 120;
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    self.groupOfCellModel = nil;
    self.imageCache = nil;
    self.operationCache = nil;
    // Dispose of any resources that can be recreated.
}

#pragma mark - TabelView的dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.groupOfCellModel.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //1.从缓存池中取出带有标示符的cell
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    //2.如果cell为空就创建cell
    //由于在storyboard中已经设置了cell的标示符,所以不用代码创建
    //3.设置cell
    //3.1 取出模型
    CellModel *modle = self.groupOfCellModel[indexPath.row];
    
    cell.textLabel.text = modle.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"已经被下载%@",modle.download];
    
/******************************* 原始解决方案 ********************************/
//    //最原始的解决思路:
//    //下载图片的思路
//    //获取url
//    NSURL *url = [NSURL URLWithString:modle.icon];
//    //获取data
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    //获取image
//    UIImage *image = [UIImage imageWithData:data];
//    //更新UI
//    cell.imageView.image = image;
    
/******************************* 优化方案一 ********************************/
//
//    //当前存在的问题
//    //1.在不关闭app的情况下,随着cell的滚动,会重复下载图片,浪费用户的流量
//    //解决方案:保存下载的图片到tableView中
//    
//    //从图片缓存字典组里取出当前cell的图片
//    //存储图片时,字典中的key是model的icon, value是对应的UIImage
//    UIImage *image = self.imageCache[modle.icon];
//    
//    if(image == nil){
//    //如果图片为空,就进入到此处
//        NSLog(@"下载图片");
//        //获取url
//        NSURL *url = [NSURL URLWithString:modle.icon];
//        //获取data
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        //获取image
//        image = [UIImage imageWithData:data];
//        //存储image到imageCache中
//        self.imageCache[modle.icon] = image;
//        //更新UI
//        cell.imageView.image = image;
//    }else{
//    //如果图片不为空,就进入到此处
//        NSLog(@"使用缓存图片");
//        //更新UI
//        cell.imageView.image = image;
//    }

    
/******************************* 优化方案二 ********************************/
//
//    //当前存在的问题
//    //1.在不关闭app的情况下,随着cell的滚动,会重复下载图片,浪费用户的流量
//    //解决方案:保存下载的图片到tableView中的某个容器属性中(NSMutableDictionary)
//    //2.在关闭app的情况下,图片缓存会自动销毁,会重复下载图片,浪费用户的流量
//    //解决方案:保存下载的图片到沙盒中
//    
//    //从图片缓存字典里取出当前cell的图片
//    //图片缓存字典中,字典的key值为model的icon,value值是对应的UIImage
//    UIImage *image = self.imageCache[modle.icon];
//    
//    //判断当前图片的内存缓存是否为空
//    if(image == nil){
//    //进入到此处,说明图片为空,缓存中没有对应的图片
//        
//        //从缓存中获取图片信息
//        
//        //1.获得缓存图片的名称
//        //获得图片名
//        NSString *imageName = [modle.icon lastPathComponent];
//        
//        //2.获取当前应用沙盒的cache文件路径
//        //利用NSSearchPathForDirectoriesInDomains获取当前的搜索集合
//        NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//        //搜索集合中只有一个结果,即为cache的文件路径
//        NSString *filePath = [array lastObject];
//        
//        //3.拼接cache文件夹路径和图片名称获得图片的完整路径
//        //注意点:     使用正确的方法拼接路径
//        NSString *imagePath = [filePath stringByAppendingPathComponent:imageName];
//        
//        //获取图片的Data数据
//        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
//        
//        //判断当前图片的磁盘缓存是否为空
//        if(imageData == nil){
//        //进入到此处,说明当前图片的内存缓存为空,磁盘缓存也为空,所以肯定要下载图片
//            NSURL *url = [NSURL URLWithString:modle.icon];
//            imageData = [NSData dataWithContentsOfURL:url];
//            image = [UIImage imageWithData:imageData];
//            
//            //为内存缓存添加图片
//            self.imageCache[modle.icon] = image;
//            //为磁盘缓存添加图片
//            //注意点:    写入的路径为图片的全路径
//            [imageData writeToFile:imagePath atomically:YES];
//            
//            //更新UI
//            cell.imageView.image = image;
//            
//            NSLog(@"从网上下载");
//            
//        }else{
//        //进入到此处,说明当前图片的内存缓存为空,磁盘缓存不为空,可以直接使用磁盘缓存中保存的图片
//            //加载磁盘缓存中的图片
//            image = [UIImage imageWithData:imageData];
//            
//            //为内存缓存添加图片
//            self.imageCache[modle.icon] = image;
//            
//            //更新UI
//            cell.imageView.image = image;
//
//            NSLog(@"从磁盘缓存中获取");
//        }
//        
//    }else{
//    //进入到此处,说明图片不为空,缓存中有对应的图片
//        cell.imageView.image = image;
//        NSLog(@"从内存缓存中获取");
//    }
    
/******************************* 优化方案三 ********************************/
//    //当前存在的问题
//    //1.在不关闭app的情况下,随着cell的滚动,会重复下载图片,浪费用户的流量
//    //解决方案:保存下载的图片到tableView中的某个容器属性中(NSMutableDictionary)
//    //2.在关闭app的情况下,图片缓存会自动销毁,会重复下载图片,浪费用户的流量
//    //解决方案:保存下载的图片到沙盒中
//    //3.在主线程中进行耗时操作会降低app运行的流畅度
//    //解决方案:将耗时操作放到子线程,更新UI的操作放到主线程中
//    
//    //获取缓存内存中的图片
//    __block UIImage *image = self.imageCache[modle.icon];
//
//    //判断缓存内存中的图片是否为空
//    if (image == nil) {
//    //进入到这,说明内存缓存中的图片为空
//        
//        //获取沙盒目录中磁盘内存中的图像数据
//        
//        //1.获取当前图片的图片名
//        NSString *imageName = [modle.icon lastPathComponent];
//        
//        //2.获取当前图片的绝对存储路径
//        //获取目录文件的路径集合
//        NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//        //获取当前文件的路径
//        NSString *filePath = [array lastObject];
//        //获取当前图片的路径
//        NSString *imagePath =[filePath stringByAppendingPathComponent:imageName];
//        
//        //3.获取当前图片的data数据
//        __block NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
//        
//        //判断磁盘缓存中的数据是否为空
//        if(imageData == nil){
//        //进入到这说明内存缓存中的图片为空,磁盘缓存中的图片也为空,需要下载图片
//            NSLog(@"从网上获取图片");
//        
//        /************************* 方法一 *******************/
//            //创建自定义队列,默认为并发队列
//            NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
//            //创建一个操作,里面的任务为下载图片
//            NSBlockOperation *operation1 =[NSBlockOperation blockOperationWithBlock:^{
//                //下载图片
//                NSURL *url = [NSURL URLWithString:modle.icon];
//                imageData = [NSData dataWithContentsOfURL:url];
//                image = [UIImage imageWithData:imageData];
//                
//                //给内存缓存添加数据
//                self.imageCache[modle.icon] = image;
//                
//                //给磁盘缓存添加数据
//                //磁盘里只能存数据,不能存图片
//                [imageData writeToFile:imagePath atomically:YES];
//                
//                //创建主队列
//                NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
//                //创建一个操作,里面的任务为刷新UI
//                NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
//                    //刷新UI
//                    cell.imageView.image = image;
//                }];
//                //将操作方法主队列中
//                [mainQueue addOperation:operation2];
//               
//            }];
//            //将操作放到队列中
//            [queue1 addOperation:operation1];
    
        /************************* 方法二 *******************/
//            //创建自定义队列,默认为并发队列
//            NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
//            //创建一个操作,里面的任务为下载图片
//            NSBlockOperation *operation1 =[NSBlockOperation blockOperationWithBlock:^{
//                //下载图片
//                NSURL *url = [NSURL URLWithString:modle.icon];
//                imageData = [NSData dataWithContentsOfURL:url];
//                image = [UIImage imageWithData:imageData];
//                
//                //给内存缓存添加数据
//                self.imageCache[modle.icon] = image;
//                
//                //给磁盘缓存添加数据
//                //磁盘里只能存数据,不能存图片
//                [imageData writeToFile:imagePath atomically:YES];
//            }];
//            //将操作放到队列中
//            [queue1 addOperation:operation1];
//
//            //创建主队列
//            NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
//            //创建一个操作,里面的任务为刷新UI
//            NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
//                //刷新UI
//                cell.imageView.image = image;
//            }];
//            //将操作方法主队列中
//            [mainQueue addOperation:operation2];
//            
//            [operation2 addDependency:operation1];
//           
//        }else{
//        //进入到这说明内存缓存中的图片为空,磁盘缓存中的图片不为空,需要加载磁盘缓存中的图片
//            NSLog(@"从磁盘获取图片");
//
//            //加载图片
//            image = [UIImage imageWithData:imageData];
//            
//            //给内存缓存添加数据
//            self.imageCache[modle.icon] = image;
//            
//            //刷新UI
//            cell.imageView.image = image;
//        }
//    }else{
//    //进入到这,说明内存缓存中的图片不为空
//        NSLog(@"从内存获取图片");
//        cell.imageView.image = image;
//    }
//    return cell;
//}

    /******************************* 优化方案四 ********************************/
    //当前存在的问题
    //1.在不关闭app的情况下,随着cell的滚动,会重复下载图片,浪费用户的流量
    //解决方案:保存下载的图片到tableView中的某个容器属性中(NSMutableDictionary)
    
    //2.在关闭app的情况下,图片缓存会自动销毁,会重复下载图片,浪费用户的流量
    //解决方案:保存下载的图片到沙盒中
    
    //3.在主线程中进行耗时操作会降低app运行的流畅度
    //解决方案:将耗时操作放到子线程,更新UI的操作放到主线程中
    
        //加入主线程后带来的问题
        //3.0 加入子线程后,在首次启动时,cell中的图片不显示
        //解决方案:
        //        方案一 在赋值后进行全局刷新
        //        方案二 设置占位图片
    
        //3.1 快速下拉tableView会导致被循环利用的cell由于下载图片而开启多个线程,这样会导致cell的图片出现跳跃现象
        //解决方案: 刷新指定cell的数据即可
    
        //3.2 图片下载比较慢的情况下,下拉tableView后,迅速返回原先的位置会导致原先的cell开启多个线程下载同一个图片
        //解决方案:保存下载的操作到tableView中的某个容器属性中(NSMutableDictionary)

    //4.其他特殊情况
    //4.1 当网络环境较差,获取NSData失败,则data中数据为nil, 进而image数据nil,当往字典里保存nil数据时会引起app崩溃
    //解决方案: 如果data获取失败,应当
    //         1 移除当前下载的操作
    //         2  直接停止当前方法
    
    
    //获取缓存内存中的图片
    __block UIImage *image = self.imageCache[modle.icon];
    
    //判断缓存内存中的图片是否为空
    if (image == nil) {
        //进入到这,说明内存缓存中的图片为空
        
        //获取沙盒目录中磁盘内存中的图像数据
        
        //1.获取当前图片的图片名
        NSString *imageName = [modle.icon lastPathComponent];
        
        //2.获取当前图片的绝对存储路径
        //获取目录文件的路径集合
        NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        //获取当前文件的路径
        NSString *filePath = [array lastObject];
        //获取当前图片的路径
        NSString *imagePath =[filePath stringByAppendingPathComponent:imageName];
        
        //3.获取当前图片的data数据
        __block NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        
        //判断磁盘缓存中的数据是否为空
        if(imageData == nil){
            //进入到这说明内存缓存中的图片为空,磁盘缓存中的图片也为空,需要下载图片
            NSLog(@"从网上获取图片");
            
            //取出当前的操作
            NSBlockOperation *operation = self.operationCache[modle.icon];
            
            //判断当前操作是否为空
            if (operation == nil) {
            //如果操作为空,就说明当前没有进行下载, 应当进行下载
               
                //创建自定义队列,默认为并发队列
                NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
                //创建一个操作,里面的任务为下载图片
                NSBlockOperation *operation1 =[NSBlockOperation blockOperationWithBlock:^{
                    //下载图片
                    NSURL *url = [NSURL URLWithString:modle.icon];
                    imageData = [NSData dataWithContentsOfURL:url];
                    
                    //如果网络环境较差,导致获取imageData失败,应当及时停止此方法继续进行,否则在保存字典的时候出现崩溃
                    if(imageData == nil){
                        
                        //如果下载失败,应当从当前缓存中删除此次下载操作,否则以后没法重新下载
                        [self.operationCache removeObjectForKey:modle.icon];
                        
                        return ;
                    }
                    
                    
                    image = [UIImage imageWithData:imageData];
                    
                    //给内存缓存添加数据
                    self.imageCache[modle.icon] = image;
                    
                    //给磁盘缓存添加数据
                    //磁盘里只能存数据,不能存图片
                    [imageData writeToFile:imagePath atomically:YES];
                    
                    //创建主队列
                    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
                    //创建一个操作,里面的任务为刷新UI
                    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
                        //刷新UI
                        //                    cell.imageView.image = image;
                        //使用数据刷新方式避免同一个cell开启多个线程后会出现图片跳闪的问题
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                        
                        //当下载完毕后,将当前cell的下载操作去除
                        [self.operationCache removeObjectForKey:modle.icon];
                        
                        
                    }];
                    
                    //将操作放在主队列中
                    [mainQueue addOperation:operation2];
                    
                    //加上全局刷新后,可以避免第一次启动出现空白图片
                    [self.tableView reloadData];
                    
                }];
                
                //保存下载的操作到operationCache中
                self.operationCache[modle.icon] = queue1;
                
                //将操作放到队列中
                [queue1 addOperation:operation1];
            
            }else{
            //如果操作不为空,就说明当前正在进行下载
             
                
            }

        }else{
            //进入到这说明内存缓存中的图片为空,磁盘缓存中的图片不为空,需要加载磁盘缓存中的图片
            NSLog(@"从磁盘获取图片");
            
            //加载图片
            image = [UIImage imageWithData:imageData];
            
            //给内存缓存添加数据
            self.imageCache[modle.icon] = image;
            
            //刷新UI
            cell.imageView.image = image;
        }
    }else{
        //进入到这,说明内存缓存中的图片不为空
        NSLog(@"从内存获取图片");
        cell.imageView.image = image;
    }
    return cell;
}


#pragma mark - groupOfCellModel的lazy
- (NSArray *)groupOfCellModel{
    if (_groupOfCellModel == nil) {
        
        //1.读取plist中的数组
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
        NSArray *groupOfinstance = [NSArray arrayWithContentsOfFile:filePath];
        
        //2.创建存储模型的可变数组
        NSMutableArray *groupOfModel = [NSMutableArray arrayWithCapacity:groupOfinstance.count];
        
        //3.遍历从plist中取出的字典,转换成modle后存储
        for (NSDictionary *instance in groupOfinstance) {
            CellModel *modle = [CellModel cellModelWithDict:instance];
            [groupOfModel addObject:modle];
        }
        
        //4.复制groupOfModel数组
        _groupOfCellModel = [groupOfModel copy];
        
    }
    return _groupOfCellModel;

}


#pragma mark - imageCache的lazy
- (NSMutableDictionary *)imageCache{
    if (_imageCache == nil) {
        _imageCache = [NSMutableDictionary dictionary];
    }
    return _imageCache;
}

#pragma mark - operationCache的lazy
- (NSMutableDictionary *)operationCache{
    if (_operationCache == nil) {
        _operationCache = [NSMutableDictionary dictionary];
    }
    return _operationCache;
}


@end
