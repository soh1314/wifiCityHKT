//
//  HomeServiceData.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/15.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"

//"thirdName": "电视",
//"thirdType": "1",
//"thirdImg": "thirdImg/third/电视/images/index_F3B1B668CBF225CFB673A0ECD4F52853.png",
//"thirdSort": "001",
//"thirdUrl": "",
//"id": "4028813c63b8f6930163b8f757720000"
@interface HomeServiceData : WIModel

@property (nonatomic,copy)NSString *thirdName;
@property (nonatomic,copy)NSString *thirdType;
@property (nonatomic,copy)NSString *thirdImg;
@property (nonatomic,copy)NSString *thirdSort;
@property (nonatomic,copy)NSString *thirdUrl;
@property (nonatomic,copy)NSString *ID;

@end
