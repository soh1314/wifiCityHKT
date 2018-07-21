//
//  WifiPanelBottomView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIFIInfo.h"
#import "WIFICloudInfo.h"

@interface WifiPanelBottomView : UIView

@property (weak, nonatomic) IBOutlet UILabel *bandWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageFlowLabel;
@property (weak, nonatomic) IBOutlet UILabel *flowScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *districtUserNumLabel;
@property (nonatomic,strong)WIFIInfo *wifiInfo;

@end
