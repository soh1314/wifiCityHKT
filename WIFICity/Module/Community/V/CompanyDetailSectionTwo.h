//
//  CompanyDetailSectionTwo.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WICompanyInfo.h"
#import <MLLabel/MLLinkLabel.h>
@interface CompanyDetailSectionTwo : UITableViewCell
@property (weak, nonatomic) IBOutlet MLLinkLabel *abstractLabel;
@property (weak, nonatomic) IBOutlet UILabel *notiLabel;

@property (nonatomic,strong)WICompanyInfo *info;

@end
