//
//  HomeNewsTwoCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNews.h"

@interface HomeNewsTwoCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *imageGroupView;
@property (weak, nonatomic) IBOutlet UILabel *tabLabel;
@property (weak, nonatomic) IBOutlet UILabel *agencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *additionLabel;
@property (nonatomic,strong)UICollectionView *imageGroupCollectionView;
@property (nonatomic,copy)NSArray *imageGroupArray;

@property (nonatomic,strong)HomeNews *news;


@end
