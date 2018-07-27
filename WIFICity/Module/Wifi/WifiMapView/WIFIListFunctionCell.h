//
//  WIFIListFunctionCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/25.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapWifiMapBgViewBlock)(void);
@interface WIFIListFunctionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *wifimapBgView;

@property (nonatomic,copy)TapWifiMapBgViewBlock tapWifiMapBgViewBlock;


@end