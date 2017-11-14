//
//  DownloadModel.m
//  DownloadImage
//
//  Created by 曹魏 on 2017/11/13.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "DownloadModel.h"

@implementation DownloadModel
//字典转模型
+ (instancetype)objcWithDict:(NSDictionary *)dict{
    DownloadModel *objc = [[DownloadModel alloc]init];
    [objc setValuesForKeysWithDictionary:dict];
    return objc;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
//懒加载
+ (NSArray<DownloadModel *> *)applist{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"apps.plist" ofType:nil]];
    NSMutableArray *nmArray = [NSMutableArray array];
    //遍历数组字典转模型
    for (NSDictionary *dict in array) {
        DownloadModel *model = [DownloadModel objcWithDict:dict];
        [nmArray addObject:model];
    }
    return nmArray.copy;
}
@end
