//
//  WICompanyCategroyCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/9.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WICompanyCategory.h"

@interface WICompanyCategroyCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (nonatomic,strong)WICompanyCategory *category;

@end
