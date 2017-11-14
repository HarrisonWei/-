//
//  DownloadViewController.m
//  DownloadImage
//
//  Created by 曹魏 on 2017/11/13.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "DownloadViewController.h"
#import "DownloadModel.h"
#import "DownloadCell.h"
#import "NSString+Path.h"
@interface DownloadViewController ()
//数据数组
@property (nonatomic,strong)NSArray *dataArray;
//定义一个队列
@property (nonatomic,strong)NSOperationQueue *queue;
//定义一个可变字典:图片缓存
@property (nonatomic,strong)NSMutableDictionary *cacheImage;
//操作缓存
@property (nonatomic,strong)NSMutableDictionary *operationCache;
@end

@implementation DownloadViewController

//懒加载
- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [DownloadModel applist];
    }
    return _dataArray;
}
- (NSOperationQueue *)queue{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc]init];
    }
    return _queue;
}
- (NSMutableDictionary *)cacheImage{
    if (_cacheImage == nil) {
        _cacheImage = [NSMutableDictionary dictionary];
    }
    return _cacheImage;
}
- (NSMutableDictionary *)operationCache{
    if (_operationCache == nil) {
        _operationCache = [NSMutableDictionary dictionary];
    }
    return _operationCache;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.cacheImage removeAllObjects];
    [self.operationCache removeAllObjects];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cell";
    DownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    //获取模型对象
    DownloadModel *model = self.dataArray[indexPath.row];
    
    cell.downModel = model;
    //从字典中取出image
    UIImage *cacheImg = self.cacheImage[model.icon];
    if (cacheImg) {
        cell.iv_icon.image = cacheImg;
        return cell;
    }else{
        //从沙盒中取
        UIImage *sandBoxImg = [UIImage imageWithContentsOfFile:[model.icon appendCachePath]];
        //判断沙盒
        if (sandBoxImg) {
            cell.iv_icon.image = sandBoxImg;
            //由于从内存取比沙盒快得多,所以优化一下
            [self.cacheImage setObject:sandBoxImg forKey:model.icon];
            
            return cell;
        }
    }
    
    //取出操作缓存
    if (self.operationCache[model.icon]) {
        return cell;
    }
    
    //图片下载任务
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        //1.模拟耗时
        [NSThread sleepForTimeInterval:1];
        
        NSURL *url = [NSURL URLWithString:model.icon];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        //把数据存储到沙盒中
        [data writeToFile:[model.icon appendCachePath] atomically:YES];
        
        //2.开始图片下载--子线程
        UIImage *image = [UIImage imageWithData:data];
        
        //3.主线程更新UI
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            //图片缓存
            [self.cacheImage setObject:image forKey:model.icon];
            
            //删除图片下载的操作缓存
            [self.operationCache removeObjectForKey:model.icon];
            //刷新cell
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }];
    
    //操作缓存
    [self.operationCache setObject:blockOperation forKey:model.icon];
    
    //4.把操作加入队列
    [self.queue addOperation:blockOperation];
    return cell;
}

//内存警告


- (BOOL)prefersStatusBarHidden{
    return YES;
}



@end














