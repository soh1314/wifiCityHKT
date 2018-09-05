//
//  WIStartAdsView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/9/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATCountdownButton.h"
typedef void(^StartAdsBtnSkipBlock)();
@interface WIStartAdsView : UIView

@property (nonatomic,strong)UIImageView *bgView;
@property (nonatomic,strong)ATCountdownButton *skipBtn;
@property (nonatomic,copy)StartAdsBtnSkipBlock skipBlock;

@end
