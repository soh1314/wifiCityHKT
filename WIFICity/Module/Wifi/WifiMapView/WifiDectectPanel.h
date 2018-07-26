//
//  WifiDectectPanel.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JumpToWifiGuideBlock)(void);

@interface WifiDectectPanel : UIView

@property (weak, nonatomic) IBOutlet UILabel *wifiSignalLabel;
@property (weak, nonatomic) IBOutlet UILabel *wifiDelayLabel;
@property (weak, nonatomic) IBOutlet UIButton *connectBtn;
@property (weak, nonatomic) IBOutlet UILabel *wifiNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *connectStatusLabel;
@property (nonatomic,copy) JumpToWifiGuideBlock wifiGuideBlock;

- (IBAction)jumpToWifiGuide:(id)sender;

@end
