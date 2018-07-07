//
//  CompanyRecommentCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WICompanyInfo.h"
@interface CompanyRecommentCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *logoIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (nonatomic,strong)WICompanyInfo *companyInfo;
@property (weak, nonatomic) IBOutlet UIView *bgIconView;

@end
