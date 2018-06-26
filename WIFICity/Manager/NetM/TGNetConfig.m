//
//  TGNetConfig.m
//  TRGFShop
//
//  Created by yangqing Liu on 2017/9/19.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import "TGNetConfig.h"

@implementation TGNetConfig

static AFHTTPSessionManager *manager ;

+ (instancetype)shared {
    static TGNetConfig *manager = nil;
    static dispatch_once_t once_tokn;
    dispatch_once(&once_tokn, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

+ (AFHTTPSessionManager *)sharedHTTPSession {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = 10;
    });
    return manager;
}


+ (AFHTTPSessionManager *)httpManager {
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    if ([TGNetConfig shared].type == 0) {
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html",@"text/javascript",nil];
//        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
         manager.requestSerializer.timeoutInterval = 10;
    } else if ([TGNetConfig shared].type == 1) {
         manager.requestSerializer=[AFHTTPRequestSerializer serializer];
         manager.requestSerializer.timeoutInterval = 10;
        
    } else {
        manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html",@"text/javascript",nil];
        manager.requestSerializer.timeoutInterval = 10;
    }
    return manager;
}

- (void)setTimeout:(NSInteger)timeout {
    _timeout = timeout;

}

@end
