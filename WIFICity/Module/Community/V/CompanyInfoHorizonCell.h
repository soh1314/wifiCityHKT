//
//  CompanyInfoHorizonCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WICompanyInfo.h"
#import "WIButton.h"
typedef void(^CompanyLikeBlock)(WICompanyInfo *info);
typedef void(^CompanyCommentBlock)(WICompanyInfo *info);
@interface CompanyInfoHorizonCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *companyLogo;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyDesLabel;

@property (weak, nonatomic) IBOutlet UIView *edgeView;
@property (weak, nonatomic) IBOutlet WIButton *collectBtn;
@property (weak, nonatomic) IBOutlet WIButton *commentBtn;
@property (weak, nonatomic) IBOutlet WIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectLabel;
@property (weak, nonatomic) IBOutlet UIView *topEdgeView;
@property (weak, nonatomic) IBOutlet UIView *bgIconView;
@property (nonatomic,strong)WICompanyInfo *info;
@property (nonatomic,copy)CompanyLikeBlock likeBlock;
@property (nonatomic,copy)CompanyCommentBlock commentBlock;
- (IBAction)comment:(id)sender;

- (IBAction)like:(id)sender;

@end
