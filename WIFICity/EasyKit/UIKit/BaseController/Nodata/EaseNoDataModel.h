//
//  EaseNoDataModel.h
//  TRGFShop
//
//  Created by yangqing Liu on 2018/1/8.
//  Copyright © 2018年 trgf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^EaseNoDataButtonActionBlock)(void);
typedef void(^EaseNoDataTapViewBlock)(void);


@interface EaseNoDataModel : NSObject

@property (nonatomic,copy)NSString *titile;
@property (nonatomic,copy)NSString *buttonTitle;
@property (nonatomic,copy)NSString *noDataImageName;
@property (nonatomic,copy)NSString *noNetImageName;

@property (nonatomic,assign)float verticalOffset;
@property (nonatomic,assign)BOOL noNet;

@property (nonatomic,copy)EaseNoDataButtonActionBlock btnActionBlock;
@property (nonatomic,copy)EaseNoDataTapViewBlock tapViewBlock;


@end
