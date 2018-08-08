//
//  HomeNews.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/15.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"

//"id": "8a2bf9ef63bae39d0163d87829491235",
//"create_name": "",
//"create_by": "",
//"create_date": null,
//"update_name": "管理员",
//"update_by": "admin",
//"update_date": 1528871313000,
//"org_id": "8a8ab0b246dc81120146dc8180ba0017",
//"title": "以色列企业代表考察麓谷企业",
//"abstracts": "长沙高新区门户网",
//"details": @""
//"information_type": "1",
//"img_src": "thirdImg/information/2/images/http://www.cshtz.gov.cn/picture/0/s1806061409440574219.jpg",
//"is_hot": 1,
//"new_type": "",
//"is_top": 1

@interface HomeNews : WIModel

@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *update_name;
@property (nonatomic,copy)NSString *update_by;
@property (nonatomic,copy)NSString *update_date;
@property (nonatomic,copy)NSString *org_id;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *abstracts;
@property (nonatomic,copy)NSString *details;
@property (nonatomic,assign)NSInteger information_type;
@property (nonatomic,copy)NSString *img_src;
@property (nonatomic,assign)BOOL is_hot;
@property (nonatomic,assign)BOOL is_top;
@property (nonatomic,copy)NSString *src_list;
@property (nonatomic,copy)NSArray *home_image_array;
@end
