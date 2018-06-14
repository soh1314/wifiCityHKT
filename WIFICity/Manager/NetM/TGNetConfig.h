//
//  TGNetConfig.h
//  TRGFShop
//
//  Created by yangqing Liu on 2017/9/19.
//  Copyright © 2017年 trgf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,TGNetRequestType) {
    TGNetJosonRequestType,
    TGNetPlainReuqestType,
    TGNetOtherReuqestType
};

@interface TGNetConfig : NSObject

@property (nonatomic,assign)TGNetRequestType type;
@property (nonatomic,assign)NSInteger timeout;


+ (instancetype)shared;

+ (AFHTTPSessionManager *)httpManager;

- (void)setTimeout:(NSInteger)timeout;

+ (AFHTTPSessionManager *)sharedHTTPSession;

@end
