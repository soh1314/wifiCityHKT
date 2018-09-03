//
//  HomeServicePageController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/21.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HomeServicePageController.h"
#import "WINewsInfoViewController.h"
#import "WINewsPageModel.h"


@interface HomeServicePageController ()

@property (nonatomic,copy)NSArray *gxqTypeArray;

@end

@implementation HomeServicePageController

- (id)initWithServiceData:(HomeServiceData *)data {
    if (self = [super init]) {
        self.serviceData = data;
        self.titleColorNormal = [UIColor lightGrayColor];
        self.titleColorSelected = [UIColor themeColor];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)setServiceData:(HomeServiceData *)serviceData {
    _serviceData = serviceData;
    self.title = [self.serviceData.thirdName copy];
    self.count = 2;
    NSArray *titleArray = nil;
    NSArray *gqxType = nil;
    if ([serviceData.thirdName isEqualToString:@"高新头条"]) {
        titleArray = @[@"高新头条"];
        self.gxqTypeArray = @[@(21)];
    }
    if ([serviceData.thirdName isEqualToString:@"麓谷新闻"]) {
        titleArray = @[@"麓谷新闻"];
        self.gxqTypeArray  = @[@(19)];
    }
    if ([serviceData.thirdName isEqualToString:@"媒体聚焦"]) {
        titleArray = @[@"媒体聚焦"];
        self.gxqTypeArray  = @[@(20)];
    }
    if ([serviceData.thirdName isEqualToString:@"通知公告"]) {
        titleArray = @[@"通知公告"];
        self.gxqTypeArray  = @[@(1)];
    }
    if ([serviceData.thirdName isEqualToString:@"部门动态"]) {
        titleArray = @[@"部门动态"];
        self.gxqTypeArray  = @[@(2)];
    }
    if ([serviceData.thirdName isEqualToString:@"政府采购"]) {
        titleArray = @[@"采购目录",@"采购公告",@"中标公告",@"废标公告"];
        self.gxqTypeArray  = @[@(9),@(10),@(11),@(12)];
    }
    if ([serviceData.thirdName isEqualToString:@"党风廉政"]) {
        titleArray = @[@"党风廉政"];
        self.gxqTypeArray  = @[@(4)];
    }
    if ([serviceData.thirdName isEqualToString:@"法规公文"]) {
        titleArray = @[@"国家政策",@"省市政策"];
        self.gxqTypeArray  = @[@(6),@(7)];
    }
    if ([serviceData.thirdName isEqualToString:@"征地拆迁"]) {
        titleArray = @[@"征地公告",@"拆迁补偿"];
        self.gxqTypeArray = @[@(17),@(18)];
    }
    NSMutableArray *itemArray = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        WINewsPageModel *model0 = [WINewsPageModel new];
        model0.title = titleArray[i];
        model0.gxqType = [gqxType[i] integerValue];
        [itemArray addObject:model0];
    }
    self.itemModel = [itemArray copy];

}

- (UIViewController *)easePageController:(EasePageController *)viewController AtIndex:(NSInteger)index {
    WINewsInfoViewController *sub = [[WINewsInfoViewController alloc]init];
    WINewsPageModel *model = [WINewsPageModel new];
    model.index = index;
    model.gxqType = [self.gxqTypeArray[index] integerValue];
    model.modelName = @"GaoXinNewS";
    model.cellClass = @"HomeNewsOneCell";
    if (self.gxqTypeArray && [self.gxqTypeArray[0] integerValue] == 21 ) {
        model.modelName = @"HomeNews";
    }
    sub.pageModel = model;
    return sub;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
