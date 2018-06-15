//
//  AccoutDataStore.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "AccoutDataStore.h"
#import "RNEncryptor.h"
#import "RNDecryptor.h"

@interface AccoutDataStore()

@property (nonatomic, readonly) NSString *storePath;

@end

@implementation AccoutDataStore

@synthesize storePath = _storePath;

-(NSString *)storePath{
    NSArray *docuemntPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [docuemntPaths objectAtIndex:0];
    _storePath = [documentPath stringByAppendingPathComponent:@"User.data"];
    
    return _storePath;
}

-(void)saveAccountWithAccount:(id)accountObject{
    if(!accountObject){
        return;
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:accountObject];
    NSString *password = @"secret password";
    NSError *error;
    NSData *encryptedData = [RNEncryptor encryptData:data withSettings:kRNCryptorAES256Settings password:password error:&error];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:self.storePath]) {
        [fileManager removeItemAtPath:self.storePath error:&error];
    }
    [fileManager createFileAtPath:self.storePath contents:encryptedData attributes:nil];
}

-(id)loadAccount{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *encryptedData = [fileManager contentsAtPath:self.storePath];
    NSString *password = @"secret password";
    NSError *error;
    NSData *data = [RNDecryptor decryptData:encryptedData withPassword:password error:&error];
    id account = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return account;
}

- (void)clearDataStore {
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:self.storePath]) {
        [fileManager removeItemAtPath:self.storePath error:&error];
    }
}

- (NSString *)loadUserID {
    WIUser *account = [self loadAccount];
    if (!account) {
        return nil;
    }
    else {
        return account.userId;
    }
}

@end
