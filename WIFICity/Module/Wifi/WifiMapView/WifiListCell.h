//
//  WifiListCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIFIInfo.h"

@interface WifiListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *wifiNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *wifiNotiLabel;
@property (weak, nonatomic) IBOutlet UIImageView *wifiSignalImageView;
@property (nonatomic,strong)WIFIInfo *info;


@end
