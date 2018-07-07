//
//  CompanyDetailSectionFour.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WICompanyInfo.h"

typedef void(^JumpWebSiteActionBlock)(NSString *url);

@interface CompanyDetailSectionFour : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *recruimentView;
@property (weak, nonatomic) IBOutlet UIView *productInfoView;
@property (weak, nonatomic) IBOutlet UIView *websiteView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *recruitSubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *productInfoSubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteSubTitleLabel;

@property (weak, nonatomic) IBOutlet UIView *egdeView1;
@property (weak, nonatomic) IBOutlet UIView *edgeView2;
@property (nonatomic,strong)WICompanyInfo *info;
@property (nonatomic,copy)JumpWebSiteActionBlock actionBlock;


@end
