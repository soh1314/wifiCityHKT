//
//  EnterPriseDelegate.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/31.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WIComment.h"
#import "WICompanyInfo.h"
typedef void(^IEnterPriseCompleteBlock)(WINetResponse *response);

@protocol EnterPriseDelegate <NSObject>

- (void)commentCompany:(WICompanyInfo *)company comment:(WIComment *)comment complete:(IEnterPriseCompleteBlock)complete;
- (void)likeCompany:(WICompanyInfo *)company complete:(IEnterPriseCompleteBlock)complete;

@end
