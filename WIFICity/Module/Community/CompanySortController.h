//
//  CompanySortController.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "BaseViewController.h"
#import "WICompanyCategory.h"

@interface CompanySortController : BaseViewController

@property (nonatomic,strong)WICompanyCategory *selectCategory;
@property (nonatomic,strong)WICompanyCategory *selectProductCategory;
@property (nonatomic,copy)NSString *categoryID;
@property (nonatomic,copy)NSString *areaID;
@property (nonatomic,copy)NSArray *categoryArray;
@property (nonatomic,copy)NSArray *productArray;

@end
