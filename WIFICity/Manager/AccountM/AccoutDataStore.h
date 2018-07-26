//
//  AccoutDataStore.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAccountDataStore.h"

@interface AccoutDataStore : NSObject <IAccountDataStore>

- (NSString *)loadUserID;
-(void)saveAccountWithAccount:(id)accountObject;
- (void)clearDataStore;

@end
