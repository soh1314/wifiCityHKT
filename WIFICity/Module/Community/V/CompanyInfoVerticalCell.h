//
//  CompanyInfoVerticalCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WICompanyInfo.h"

typedef void(^CompanyLikeBlock)(WICompanyInfo *info);
typedef void(^CompanyCommentBlock)(WICompanyInfo *info);
@interface CompanyInfoVerticalCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *companyLogo;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIView *edgeView;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeNum;
@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectLabel;
@property (weak, nonatomic) IBOutlet UIView *bgIconView;
@property (weak, nonatomic) IBOutlet UIView *btnEdgeView;
@property (nonatomic,copy)CompanyLikeBlock likeBlock;
@property (nonatomic,copy)CompanyCommentBlock commentBlock;

@property (nonatomic,strong)WICompanyInfo *info;
- (IBAction)like:(id)sender;

- (IBAction)comment:(id)sender;
@end
