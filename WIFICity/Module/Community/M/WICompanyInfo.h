//
//  WICompanyInfo.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/7.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIModel.h"

//"com_address" : "长沙市岳麓区高新开发区青山路以南50米华宽通科技园",
//"com_contacts" : null,
//"com_logo" : "upload/plug-in/accordion/images/HKT.jpg",
//"com_name" : "湖南华宽通科技股份有限公司",
//"com_range" : "经营范围：计算机技术开发、技术服务；计算机网络平台的建设与开发;电子产品生产；物联网技术的研发。",
//"com_show" : "1",
//"com_tel" : null,
//"com_website" : "http://www.hktchn.com/",
//"create_by" : null,
//"create_date" : null,
//"create_name" : null,
//"ent_id" : "402883b260d36c5f0160d4c0d7f70017",
//"ent_name" : "互联网",
//"id" : "8a2bf9ef61d5dffd0161d634b3a30047",
//"like_id" : null,
//"likes" : 30,
//"org_id" : "8a8ab0b246dc81120146dc8180ba0017",
//"org_name" : "默认机构",
//"rew_num" : null,
//"update_by" : "admin",
//"update_date" : 1519882345000,
//"update_name" : "管理员"

@interface WICompanyInfo : WIModel

@property (nonatomic,copy)NSString *com_address;
@property (nonatomic,copy)NSString *com_logo;
@property (nonatomic,copy)NSString *com_name;
@property (nonatomic,copy)NSString *com_range;
@property (nonatomic,copy)NSString *com_show;
@property (nonatomic,copy)NSString *com_tel;
@property (nonatomic,copy)NSString *com_website;
@property (nonatomic,copy)NSString *ent_id;
@property (nonatomic,copy)NSString *ent_name;
@property (nonatomic,copy)NSString *like_id;
@property (nonatomic,copy)NSString *org_id;
@property (nonatomic,copy)NSString *org_name;
@property (nonatomic,assign)long update_date;
@property (nonatomic,copy)NSString *update_by;
@property (nonatomic,copy)NSString *phoneNumber;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,assign)NSInteger likes;
@property (nonatomic,assign)NSInteger dis;
@property (nonatomic,assign)float ratio;
@property (nonatomic,copy)NSString *com_legal;
@property (nonatomic,copy)NSString *com_capital;
@property (nonatomic,copy)NSString *com_contacts;
@property (nonatomic,copy)NSString *com_vr;
@property (nonatomic,assign)NSInteger com_found_date;
@property (nonatomic,copy)NSString *likeId;

@property (nonatomic,copy)NSString *com_introduction;

@end
