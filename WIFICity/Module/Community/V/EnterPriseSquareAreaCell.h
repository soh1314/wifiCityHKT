//
//  EnterPriseSquareAreaCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/18.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "WICompanyCategory.h"
@interface EnterPriseSquareAreaCell : UITableViewCell<iCarouselDelegate,iCarouselDataSource>

@property (nonatomic,strong)iCarousel *carousel;
@property (nonatomic,copy)NSArray *categoryArray;

@end
