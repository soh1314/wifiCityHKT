//
//  WifiPanel.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/15.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WifiFlowView.h"
#import "WifiPanelTopView.h"
#import "WifiPanelBottomView.h"
#import "WIFIInfo.h"
#import "WifiUtil.h"
#import "WIFISevice.h"

@interface WifiPanel : UIView


@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (weak, nonatomic) IBOutlet UIView *flowBgView;
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;
@property (weak, nonatomic) IBOutlet UILabel *wifiNameLabel;

@property (nonatomic,strong)WifiFlowView *flowView;
@property (nonatomic,strong)WifiPanelBottomView *bottomView;
@property (nonatomic,strong)WifiPanelTopView *topView;
@property (nonatomic,strong)WIFIInfo *wifiInfo;
@property (weak, nonatomic) IBOutlet UIButton *connectWifiBtn;
- (IBAction)connectWifi:(id)sender;
- (void)refreshUI:(WIFIInfo *)info;
- (void)netChange:(WINetStatus)status wifiInfo:(WIFIInfo *)info;

@end
