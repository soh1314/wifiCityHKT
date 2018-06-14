//
//  IAccountDataStore.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IAccountDataStore <NSObject>

-(void)saveAccountWithAccount:(id)accountObject;

-(id)loadAccount;

-(BOOL)saveAccountPhotoWithImage:(UIImage *)photoImage withImageName:(NSString *)imgName;

-(UIImage *)loadAccountPhotoWithImageName:(NSString *)imgName;

@end
