//
//  WICompanyInfo.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/7.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"

//"address" : "湖南长沙",
//"businessScope" : "经营范围：智能制造智能制造智能制造智能制造智能制造智能制造，智能制造智能制造智能制造智能制造智能制造智能制造。",
//"commentsQuantity" : 0,
//"foundingDate" : "2018-09-10",
//"id" : 4,
//"industryCategory" : "先进装备制造",
//"introduction" : "简介：智能制造智能制造智能制造智能制造智能制造智能制造，智能制造智能制造智能制造智能制造智能制造智能制造。智能制造智能制造智能制造智能制造智能制造智能制造，智能制造智能制造智能制造智能制造智能制造智能制造。",
//"lastUpdateTime" : "2018-09-11",
//"legalPerson" : "鸠摩智",
//"liked" : false,
//"likesQuantity" : 0,
//"logoImgUrl" : "http://192.168.1.103:9091/wifi-city-static/corporate/20180911/1536651838723.jpg",
//"name" : "五八到家",
//"registeredCapital" : 1,
//"techCategories" : "智能制造",
//"telephone" : "123456",
//"vrUrl" : "http://www.baidu.com",
//"website" : "http://www.baidu.com"

@interface WICompanyInfo : WIModel

@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *logoImgUrl;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *com_range;
@property (nonatomic,copy)NSString *com_show;
@property (nonatomic,copy)NSString *telephone;
@property (nonatomic,copy)NSString *website;
@property (nonatomic,copy)NSString *ent_id;
@property (nonatomic,copy)NSString *ent_name;
@property (nonatomic,copy)NSString *like_id;
@property (nonatomic,copy)NSString *org_id;
@property (nonatomic,copy)NSString *org_name;
@property (nonatomic,assign)long update_date;
@property (nonatomic,copy)NSString *update_by;
@property (nonatomic,copy)NSString *phoneNumber;
@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,assign)NSInteger likesQuantity;
@property (nonatomic,assign)NSInteger dis;
@property (nonatomic,assign)float ratio;
@property (nonatomic,copy)NSString *legalPerson;
@property (nonatomic,copy)NSString *com_capital;
@property (nonatomic,copy)NSString *com_contacts;
@property (nonatomic,copy)NSString *vrUrl;
@property (nonatomic,assign)NSInteger com_found_date;
@property (nonatomic,copy)NSString *likeId;
@property (nonatomic,copy)NSString *introduction;

@property (nonatomic,copy)NSString *businessScope;
@property (nonatomic,copy)NSString *foundingDate;
@property (nonatomic,copy)NSString *lastUpdateTime;
@property (nonatomic,assign)BOOL liked;
@property (nonatomic,assign)NSInteger registeredCapital;
@property (nonatomic,assign)NSInteger commentsQuantity;


@end
