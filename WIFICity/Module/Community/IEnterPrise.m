//
//  IEnterPrise.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/31.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "IEnterPrise.h"
#import "EnterpriseSquareNetAPI.h"
@implementation IEnterPrise

- (void)commentCompany:(WICompanyInfo *)company comment:(WIComment *)comment complete:(IEnterPriseCompleteBlock)complete {
    weakself;
    NSDictionary *para = @{@"useId":[AccountManager shared].user.userId,@"disId":company.ID,@"disType":@"1",@"disContent":comment.disContent};
    [IEnterPrise saveComment:^(WINetResponse *response) {
        if (response && response.success) {
            if (wself.reloadBlock && wself.needReload) {
                wself.reloadBlock();
                complete(nil);
            }
        }
    } par:para];
}

- (void)likeCompany:(WICompanyInfo *)company complete:(IEnterPriseCompleteBlock)complete {
    NSDictionary *para = @{@"useId":[AccountManager shared].user.userId,@"likesId":company.ID,@"likesType":@"1"};
    [IEnterPrise likeEnterprise:^(WINetResponse *response) {
        if (response && response.success) {
            complete(response);
        }
    } par:para];
}

+ (void)saveComment:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par {
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, CompanyCommentSaveAPI) params:par successBlock:^(NSDictionary *returnData) {
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        [Dialog simpleToast:response.msg];
        complete(response);
    } failureBlock:^(NSError *error) {
        complete(nil);
    } showHUD:NO];
}

+ (void)likeEnterprise:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par {
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, CompanyLikeAPI) params:par successBlock:^(NSDictionary *returnData) {
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        [Dialog simpleToast:response.msg];
        complete(response);
    } failureBlock:^(NSError *error) {
        complete(nil);
    } showHUD:NO];
}

+ (void)collectEnterprise:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par {
    
}

+ (void)enterpriseCommentList:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par {
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, CompanyCommentListAPI) params:par successBlock:^(NSDictionary *returnData) {
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete(response);
    } failureBlock:^(NSError *error) {
        complete(nil);
    } showHUD:NO];
}

+ (void)enterpriseDetail:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par {
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, CompanyDetailAPI) params:par successBlock:^(NSDictionary *returnData) {
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete(response);
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

@end
