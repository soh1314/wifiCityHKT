//
//  WIMapBubbleView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/10.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIGeometryInfo.h"

@interface WIMapBubbleView : UIView

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *wifiNameLabel;
@property (nonatomic,strong)WIGeometryInfo *info;

@end
