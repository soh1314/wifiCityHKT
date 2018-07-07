//
//  CompanyDetailSectionOne.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WICompanyInfo.h"

@interface CompanyDetailSectionOne : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *companyIcon;
@property (weak, nonatomic) IBOutlet UILabel *bossNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *registerMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressValueLabel;

- (IBAction)callCompany:(id)sender;
- (IBAction)locateCompany:(id)sender;

@property (nonatomic,strong)WICompanyInfo *info;


@end
