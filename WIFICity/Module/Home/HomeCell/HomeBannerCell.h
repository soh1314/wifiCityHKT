//
//  HomeBannerCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeLbtResponse.h"
#import "SDCycleScrollView.h"
typedef void(^itemPick)(NSInteger idx);
@interface HomeBannerCell : UITableViewCell<SDCycleScrollViewDelegate>

@property (nonatomic,copy)NSArray *imageUrlArray;
@property (nonatomic,strong)SDCycleScrollView *coursal;
@property (nonatomic, copy) itemPick pick;
- (void)setCoursalImageDataArray:(NSArray *)dataArray;

@end
