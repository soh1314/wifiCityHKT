//
//  WIFIListFunctionCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapWifiMapBgViewBlock)(void);
typedef void(^TapSaftyTestBgViewwBlock)(void);
typedef void(^TapSpeedTestBgViewBlock)(void);
@interface WIFIListFunctionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *wifimapBgView;
@property (weak, nonatomic) IBOutlet UIView *speedTestBgView;
@property (weak, nonatomic) IBOutlet UIView *saftyTestBgView;
@property (nonatomic,copy)TapWifiMapBgViewBlock tapWifiMapBgViewBlock;
@property (nonatomic,copy)TapSaftyTestBgViewwBlock tapSaftyTestBgViewwBlock;
@property (nonatomic,copy)TapSpeedTestBgViewBlock tapSpeedTestBgViewBlock;

@end
