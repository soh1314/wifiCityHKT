//
//  CompanyDetailSectionOne.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WICompanyInfo.h"

typedef void(^CompanySeeQuanjinBlock)(void);
typedef void(^CompanyGotoWebSiteBlock)(void);
typedef void(^CompanyLocateBlock)(void);

@interface CompanyDetailSectionOne : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *companyIcon;
@property (weak, nonatomic) IBOutlet UILabel *bossNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *registerMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *registerNotiLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeNotiLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;

@property (weak, nonatomic) IBOutlet UIButton *locationBtn;

@property (weak, nonatomic) IBOutlet UILabel *bossNameNotiLabel;
@property (weak, nonatomic) IBOutlet UILabel *quanjingLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *quanjinTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *quanjinBtn;
@property (nonatomic,copy)CompanyLocateBlock locateBlock;
@property (nonatomic,copy)CompanyGotoWebSiteBlock webSiteBlock;
@property (nonatomic,copy)CompanySeeQuanjinBlock SeeQuanjinBlock;

- (IBAction)callCompany:(id)sender;
- (IBAction)locateCompany:(id)sender;
- (IBAction)seeQuanJin:(id)sender;
- (IBAction)goToHomeWebSite:(id)sender;


@property (nonatomic,strong)WICompanyInfo *info;


@end
