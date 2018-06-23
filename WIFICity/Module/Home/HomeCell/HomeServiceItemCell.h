//
//  HomeServiceItemCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeServiceData.h"
@interface HomeServiceItemCell : UICollectionViewCell

@property (nonatomic,strong)HomeServiceData *serviceData;
@property (weak, nonatomic) IBOutlet UIImageView *serviceImageView;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;


@end
