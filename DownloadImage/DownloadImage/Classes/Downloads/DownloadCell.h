//
//  DownloadCell.h
//  DownloadImage
//
//  Created by 曹魏 on 2017/11/13.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DownloadModel;
@interface DownloadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv_icon;

@property (weak, nonatomic) IBOutlet UILabel *lb_name;
@property (weak, nonatomic) IBOutlet UILabel *lb_download;

@property (nonatomic,strong)DownloadModel *downModel;
@end
