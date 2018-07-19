//
//  HomeServiceCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeServiceData.h"
typedef void(^itemPick)(NSInteger idx);
@interface HomeServiceCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,copy)NSDictionary *serviceInfo;
@property (nonatomic,copy)NSArray *dataArray;
@property (nonatomic, copy) itemPick pick;

+ (void)pickCellItem:(NSInteger)index dataArray:(NSArray *)dataArray;

@end
