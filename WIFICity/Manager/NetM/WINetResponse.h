//
//  WINetResponse.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/13.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <JSONModel/JSONModel.h>
//"success": true,
//"msg": "操作成功",
//"obj": null,
//"attributes": null
@interface WINetResponse : JSONModel

@property (nonatomic,assign)BOOL success;
@property (nonatomic,copy)NSString *msg;
@property (nonatomic,copy)NSDictionary *obj;
@property (nonatomic,copy)NSString *strObj;
@property (nonatomic,copy)NSString *attributes;

@end
