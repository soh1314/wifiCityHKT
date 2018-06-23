//
//  HomeNewsOneCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNews.h"

@interface HomeNewsOneCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;

@property (weak, nonatomic) IBOutlet UILabel *tagView;
@property (weak, nonatomic) IBOutlet UILabel *agencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *additionLabel;

@property (nonatomic,strong)HomeNews *news;

@end
