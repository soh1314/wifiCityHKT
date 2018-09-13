//
//  WIComment.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/31.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"

//"disContent" : "hello",
//"disDate" : 1533020594000,
//"disId" : "402883b260d36c5f0160d4c0d7f70017",
//"disType" : "1",
//"id" : "ff80818164ee66580164ef25e007001a",
//"useId" : "8a2bf9ef63fd1b0801642667a2ae0ec1"
//"content" : "好的",
//"createDate" : "2018-09-13",
//"id" : 1,
//"liked" : false,
//"likedQuantity" : 0,
//"nickname" : "15874278508"
@interface WIComment : WIModel

@property (nonatomic,copy)NSString *dis_id;
@property (nonatomic,copy)NSString *dis_Type;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *use_id;
@property (nonatomic,copy)NSString *createDate;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *qq_icon;
@property (nonatomic,copy)NSString *wx_icon;
@property (nonatomic,assign)NSInteger dis_numbers;
@property (nonatomic,assign)NSInteger likedQuantity;
@property (nonatomic,assign)NSInteger liked;
@property (nonatomic,copy)NSString *like_id;

@end
