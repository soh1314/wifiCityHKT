//
//  CompanyRecommentHeader.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SeeMoreAction)(void);
@interface CompanyRecommentHeader : UIView

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIView *edgeView;
- (IBAction)seeMore:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,copy)SeeMoreAction moreBlock;

@end
