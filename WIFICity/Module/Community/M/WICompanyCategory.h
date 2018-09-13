


#import "WIModel.h"

//createName: 管理员,
//createBy: admin,
//createDate: 1515340800000,
//updateName: 管理员,
//updateBy: admin,
//updateDate: 1519712259000,
//entName: 互联网,
//entSort: 1,

//id: 402883b260d36c5f0160d4c0d7f70017

@interface WICompanyCategory : WIModel

@property(nonatomic,copy)NSString *createName;
@property(nonatomic,copy)NSString *createBy;
@property(nonatomic,copy)NSString *createDate;
@property(nonatomic,copy)NSString *updateName;
@property(nonatomic,copy)NSString *updateBy;
@property(nonatomic,copy)NSString *updateDate;
@property(nonatomic,copy)NSString *entName;
@property(nonatomic,copy)NSString *entSort;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *industryImg;
@property(nonatomic,copy)NSString *industryName;
@property(nonatomic,copy)NSString *industrySort;
@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,copy)NSString *name;

- (NSString *)industryImgUrl;

@end
