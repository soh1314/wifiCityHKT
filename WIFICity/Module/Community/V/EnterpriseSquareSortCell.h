//
//  EnterpriseSquareSortCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WICompanyCategory.h"

typedef void(^itemPick)(NSInteger idx ,WICompanyCategory *category);
typedef NS_ENUM(NSInteger,SquareSortCellType) {
    SquareSortCellImageTextType,
    SquareSortCellTextType
};


@interface EnterpriseSquareSortCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,copy)NSArray *dataArray;
@property (nonatomic,copy)NSArray *titleArray;
@property (nonatomic,copy)NSArray *imageArray;
@property (nonatomic,copy)NSArray *categoryModelArray;
@property (nonatomic,assign)SquareSortCellType cellType;
@property (nonatomic, copy) itemPick pick;

@end
