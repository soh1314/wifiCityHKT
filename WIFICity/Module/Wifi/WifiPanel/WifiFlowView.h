//
//  WifiFlowView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIFIInfo.h"
#import "WIFICloudInfo.h"
#import "UILabel+wordStyle.h"

@interface WifiFlowView : UIView

@property (nonatomic,strong)WIFIInfo *wifiInfo;
@property (weak, nonatomic) IBOutlet UILabel *totalFlowLabel;
@property (weak, nonatomic) IBOutlet UILabel *flowLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *wifiStatusLabel;


@end
