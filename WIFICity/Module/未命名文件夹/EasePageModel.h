//
//  EasePageModel.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/19.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface EasePageModel : JSONModel

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *noDateImageString;
@property (nonatomic,copy)NSString *cellClass;
@property (nonatomic,copy)NSString *modelName;
@property (nonatomic,assign)NSInteger index;

@end
