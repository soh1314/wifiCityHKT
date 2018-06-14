//
//  TGNetManager.m
//  TRGFShop
//
//  Created by yangqing Liu on 2017/11/1.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "TGNetManager.h"
#import "TGNetConfig.h"

@implementation TGNetManager

static AFHTTPSessionManager *manager ;

+ (AFHTTPSessionManager *)sharedHTTPSession {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10;
    });
    return manager;
}



+ (void)post:(NSDictionary *)par  url:(NSString *)url callBack:(TGNetCallBack)callBack {
    AFHTTPSessionManager *manager = [TGNetConfig httpManager];
    [manager POST:url parameters:par progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callBack(0,responseObject,@"成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callBack(400,nil,@"失败");
    }];
}

+ (void)postH5:(NSDictionary *)par  url:(NSString *)url callBack:(TGNetCallBack)callBack {
    TGNetConfig *netConfig = [TGNetConfig shared];
    [netConfig setType:1];
    AFHTTPSessionManager *manager = [TGNetConfig httpManager];
    [manager POST:url parameters:par progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callBack(0,responseObject,@"成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callBack(400,nil,@"失败");
    }];
}

+ (void)batchRequest:(NSArray *)requestInfo url:(NSArray *)url callBack:(TGNetCallBack)callback {
    [MBProgressHUD showHUDAddedTo:KWINDOW animated:YES];
    __block dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t dispatchQueue = dispatch_queue_create("trgf.queue.next1", DISPATCH_QUEUE_CONCURRENT);
    NSMutableArray* result = [NSMutableArray array];
    for (int i = 0 ; i < requestInfo.count; i++) {
        if (i != requestInfo.count) {
            dispatch_group_enter(group);
            dispatch_async(dispatchQueue, ^{
                [self post:requestInfo[i] url:kAppUrl(kUrlHost, url[i]) callBack:^(NSInteger code, NSDictionary *returnData, NSString *msg) {
                    
                    dispatch_group_leave(group);
                    
                }];
            });
        }
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"上传完成!");
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        NSInteger allSuc = 1;
        for (id response in result) {
            if ([[response objectForKey:@"result"] integerValue] == 0) {
                continue;
            } else {
                allSuc = 0;
                break;
            }
        }
        if (allSuc) {
            if (callback) {
                callback(0,nil,@"成功");
            }
        } else {
            if (callback) {
                callback(400,nil,@"失败");
            }
        }
        
        
        
    });
}

+ (void)batchRequestH5:(NSArray *)requestInfo url:(NSArray *)url callBack:(TGNetCallBack)callback {
    [MBProgressHUD showHUDAddedTo:KWINDOW animated:YES];
    __block dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t dispatchQueue = dispatch_queue_create("trgf.queue.next1", DISPATCH_QUEUE_CONCURRENT);
    NSMutableArray* result = [NSMutableArray array];
    for (int i = 0 ; i < requestInfo.count; i++) {
        if (i != requestInfo.count) {
            dispatch_group_enter(group);
            dispatch_async(dispatchQueue, ^{
                [self postH5:requestInfo[i] url:kAppUrl(kUrlHost, url[i]) callBack:^(NSInteger code, NSDictionary *returnData, NSString *msg) {
                    
                    dispatch_group_leave(group);
                    
                }];
            });
        }
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"上传完成!");
        [MBProgressHUD hideAllHUDsForView:KWINDOW animated:YES];
        NSInteger allSuc = 1;
        for (id response in result) {
            if ([[response objectForKey:@"result"] integerValue] == 0) {
                continue;
            } else {
                allSuc = 0;
                break;
            }
        }
        if (allSuc) {
            if (callback) {
                callback(0,nil,@"成功");
            }
        } else {
            if (callback) {
                callback(400,nil,@"失败");
            }
        }
        
        
        
    });
}

@end
