//
//  DownloadCell.m
//  DownloadImage
//
//  Created by 曹魏 on 2017/11/13.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "DownloadCell.h"
#import "DownloadModel.h"

@implementation DownloadCell
- (void)setDownModel:(DownloadModel *)downModel{
    _downModel = downModel;
    self.iv_icon.image = [UIImage imageNamed:@"user_default"];;
    self.lb_name.text = downModel.name;
    self.lb_download.text = downModel.download;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

@end
