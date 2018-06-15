//
//  TGNetManager.h
//  TRGFShop
//
//  Created by yangqing Liu on 2017/11/1.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^TGNetCallBack)(NSInteger code ,NSDictionary *returnData,NSString *msg);

@interface TGNetManager : NSObject

+ (AFHTTPSessionManager *)sharedHTTPSession;

+ (void)batchRequest:(NSArray *)requestInfo url:(NSArray *)url callBack:(TGNetCallBack)callback;

+ (void)batchRequestH5:(NSArray *)requestInfo url:(NSArray *)url callBack:(TGNetCallBack)callback;

@end
