//
//  CompanyDetailRecruitCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/24.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WICompanyInfo.h"
@interface CompanyDetailRecruitCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *seeAllNotiLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *arrowLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (nonatomic,strong)WICompanyInfo *info;

@end
