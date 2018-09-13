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
    NSDictionary *para = @{@"appUserId":[AccountManager shared].user.userId,@"corporateId":@(company.ID),@"content":comment.content};
    [IEnterPrise saveComment:^(WINetResponse *response) {
        if (response && response.success) {
            if (wself.reloadBlock && wself.needReload) {
                wself.reloadBlock();
            }
            [Dialog simpleToast:@"评论成功"];
        } else {
            [Dialog simpleToast:@"评论失败"];
        }
        complete(nil);
        
    } par:para];
}

- (void)likeCompanyComment:(WIComment *)comment complete:(IEnterPriseCompleteBlock)complete {
    NSDictionary *para = @{@"appUserId":[AccountManager shared].user.userId,@"commentId":comment.ID};
    [IEnterPrise likeCompanyComment:^(WINetResponse *response) {
        if (response && response.success) {
            complete(response);
        } else {
            [Dialog simpleToast:@"点赞失败"];
        }
        
    } par:para];
}


- (void)likeCompany:(WICompanyInfo *)company complete:(IEnterPriseCompleteBlock)complete {
    NSDictionary *para = @{@"appUserId":[AccountManager shared].user.userId,@"id":@(company.ID)};
    [IEnterPrise likeEnterprise:^(WINetResponse *response) {
        if (response && response.success) {
            complete(response);
        } else {
            [Dialog simpleToast:@"点赞失败"];
        }
        
    } par:para];
}

- (void)collectCompany:(WICompanyInfo *)company complete:(IEnterPriseCompleteBlock)complete {
    if (!company) {
        return;
    }
    NSDictionary *para = @{@"useId":[AccountManager shared].user.userId,@"makeId":@(company.ID),@"makeType":@"1"};
    [IEnterPrise collectEnterprise:^(WINetResponse *response) {
        if (response && response.success) {
            complete(response);
            [Dialog simpleToast:@"收藏成功"];
        } else {
            [Dialog simpleToast:@"收藏失败"];
        }
        
    } par:para];
}

- (void)unCollectCompany:(WICompanyInfo *)company complete:(IEnterPriseCompleteBlock)complete {
    NSDictionary *para = @{@"useId":[AccountManager shared].user.userId,@"id":@(company.ID)};
    [IEnterPrise collectEnterprise:^(WINetResponse *response) {
        if (response && response.success) {
            complete(response);
            [Dialog simpleToast:@"取消收藏成功"];
        } else {
            [Dialog simpleToast:@"取消收藏失败"];
        }
        
    } par:para];
}

+ (void)saveComment:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par {
    [MHNetworkManager postReqeustWithURL:kAppUrl(kUrlHost, CompanyCommentSaveAPI) params:par successBlock:^(NSDictionary *returnData) {
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete(response);
    } failureBlock:^(NSError *error) {
        complete(nil);
    } showHUD:NO];
}

+ (void)likeComment:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par {
    [Dialog showRingLoadingView:KWINDOW];
    [MHNetworkManager postReqeustWithURL:kAppUrl(kUrlHost, CompanyLikeAPI) params:par successBlock:^(NSDictionary *returnData) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete(response);
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        complete(nil);
    } showHUD:NO];
}

+ (void)likeCompanyComment:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par {
    [Dialog showRingLoadingView:KWINDOW];
    [MHNetworkManager postReqeustWithURL:kAppUrl(kUrlHost, CompanyCommentLikeAPI) params:par successBlock:^(NSDictionary *returnData) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete(response);
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        complete(nil);
    } showHUD:NO];
}

+ (void)likeEnterprise:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par {
    [Dialog showRingLoadingView:KWINDOW];
    [MHNetworkManager postReqeustWithURL:kAppUrl(kUrlHost, CompanyLikeAPI) params:par successBlock:^(NSDictionary *returnData) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete(response);
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        complete(nil);
    } showHUD:NO];
}

+ (void)likeEnterpriseComment:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par {
    [Dialog showRingLoadingView:KWINDOW];
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, CompanyLikeAPI) params:par successBlock:^(NSDictionary *returnData) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete(response);
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        complete(nil);
    } showHUD:NO];
}

+ (void)collectEnterprise:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par {
    [Dialog showRingLoadingView:KWINDOW];
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, CompanyCollectAPI) params:par successBlock:^(NSDictionary *returnData) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete(response);
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        complete(nil);
    } showHUD:NO];
}

+ (void)unCollectEnterprise:(IEnterPriseCompleteBlock)complete par:(NSDictionary *)par {
    [Dialog showRingLoadingView:KWINDOW];
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, CompanyUnCollectAPI) params:par successBlock:^(NSDictionary *returnData) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        complete(response);
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        complete(nil);
    } showHUD:NO];
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
