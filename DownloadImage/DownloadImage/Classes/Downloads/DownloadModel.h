//
//  DownloadModel.h
//  DownloadImage
//
//  Created by 曹魏 on 2017/11/13.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadModel : NSObject
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *download;
@property (nonatomic,copy)NSString *icon;
+ (instancetype)objcWithDict:(NSDictionary *)dict;
+ (NSArray<DownloadModel *> *)applist;
@end



