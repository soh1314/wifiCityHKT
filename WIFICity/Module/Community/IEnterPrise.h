//
//  IEnterPrise.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/31.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnterPriseDelegate.h"
typedef void(^IEnterPriseCompleteBlock)(WINetResponse *response);
typedef void(^IEnterPriseReloadDataBlock)(void);

@interface IEnterPrise : NSObject<EnterPriseDelegate>

@property (nonatomic,copy)IEnterPriseReloadDataBlock reloadBlock;
@property (nonatomic,assign)BOOL needReload;

- (void)commentCompany:(WICompanyInfo *)company comment:(WIComment *)comment complete:(IEnterPriseCompleteBlock)complete;

- (void)likeCompany:(WICompanyInfo *)company complete:(IEnterPriseCompleteBlock)complete;

- (void)likeCompanyComment:(WIComment *)comment complete:(IEnterPriseCompleteBlock)complete;

- (void)collectCompany:(WICompanyInfo *)company complete:(IEnterPriseCompleteBlock)complete;

- (void)unCollectCompany:(WICompanyInfo *)company complete:(IEnterPriseCompleteBlock)complete;

+ (void)saveComment:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par;

+ (void)likeEnterprise:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par;

+ (void)collectEnterprise:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par;

+ (void)unCollectEnterprise:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par;

+ (void)enterpriseCommentList:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par;

+ (void)enterpriseDetail:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par;

@end
