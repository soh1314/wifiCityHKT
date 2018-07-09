//
//  WICompanyCategroyView.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/9.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^itemPick)(NSInteger idx);
@interface WICompanyCategroyView : UIView

@property (nonatomic,copy)NSArray *categoryArray;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, copy) itemPick pick;

@end
