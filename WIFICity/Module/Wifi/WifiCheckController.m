//
//  WifiCheckController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/17.
//  Copyright © 2018年 HKT. All rights reserved.


#import "WifiCheckController.h"
#import "WifiDectectPanel.h"
#import "WifiListCell.h"
#import "WIFIListFunctionCell.h"

#import "WifiMapController.h"
#import "WifiGuideController.h"
#import "WifiSpeedTestController.h"
#import "WIFISevice.h"
#import "EasyCacheHelper.h"
#import "WINormalCellHeader.h"

@interface WifiCheckController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)WifiDectectPanel *panel;

@property (nonatomic,strong)EaseTableView *tableView;

@property (nonatomic,copy)NSArray *hktWifiArray;

@property (nonatomic,copy)NSArray *otherWifiArray;

@end

@implementation WifiCheckController

- (id)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteTrasluntNavBar];
    [self initUI];
    [self getWifiListCach];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wifiStatusChange:) name:@"WINETSTATUSCHANGE" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wifiValidatingFinish:) name:@"WifiValidateingFinish" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wifiValidating:) name:@"WifiValidateingStatus" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"WINETSTATUSCHANGE" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"WifiValidateingStatus" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"WifiValidateingFinish" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setWhiteTrasluntNavBar];
    [self setPanelData];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];

}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)getWifiListCach {
    NSArray *wifiCachArray = [EasyCacheHelper getResponseCacheForKey:HKTWIFIARRAYKEY];
    NSArray *otherWifiCachArray = [EasyCacheHelper getResponseCacheForKey:OHERWIFIARRAYKEY];
    if (wifiCachArray && wifiCachArray.count > 0) {
        self.hktWifiArray = [wifiCachArray copy];
        
    }
    if (otherWifiCachArray && otherWifiCachArray.count > 0) {
        self.otherWifiArray = [otherWifiCachArray copy];
    }
    if (otherWifiCachArray || wifiCachArray) {
        [self.tableView reloadData];
    }
    
}

- (void)setPanelData {
    WIFIInfo *info = [WIFISevice shared].wifiInfo;
    [self.panel setInfo:info];
}

#pragma  mark - noti
- (void)applicationEnterForeground:(NSNotification *)noti {
    if ([WIFISevice shared].hktWifiArray && [WIFISevice shared].hktWifiArray.count > 0) {
         self.hktWifiArray = [[WIFISevice shared].hktWifiArray copy];
    }
    if ([WIFISevice shared].otherWifiArray && [WIFISevice shared].hktWifiArray.count > 0) {
        self.otherWifiArray = [[WIFISevice shared].otherWifiArray copy];
    }
    if ([WIFISevice shared].hktWifiArray || [WIFISevice shared].otherWifiArray) {
        [self.tableView reloadData];
    }
    
}

- (void)wifiStatusChange:(NSNotification *)noti {
    [self setPanelData];
}

- (void)wifiValidatingFinish:(NSNotification *)noti {
    
}

- (void)wifiValidating:(NSNotification *)noti {
   
}

#pragma mark - ui

- (void)initUI {
    weakself;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).mas_offset(16);
        make.right.mas_equalTo(self.view).mas_offset(-16);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"WifiListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WifiListCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WIFIListFunctionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WIFIListFunctionCellID"];
    
    self.panel = [[WifiDectectPanel alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 220)];
    self.panel.wifiGuideBlock = ^{
        WifiGuideController *ctrl = [WifiGuideController new];
        [wself.navigationController pushViewController:ctrl animated:YES];
    };
//    [self.view addSubview:self.panel];
    self.tableView.tableHeaderView = self.panel;
    [self.panel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(220);
        make.left.right.mas_equalTo(self.view);
    }];
   
    
}

#pragma mark - get and set
- (EaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[EaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.estimatedRowHeight = 200;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.contentInset  = UIEdgeInsetsMake(260, 0, 0, 0);
    }
    return _tableView;
}


#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
       return self.hktWifiArray.count;
    } else {
        return self.otherWifiArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    weakself;
    if (indexPath.section == 0) {
        WIFIListFunctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIFIListFunctionCellID" forIndexPath:indexPath];
        cell.tapWifiMapBgViewBlock = ^{
            WifiMapController *wifiCtrl = [WifiMapController new];
            [wself.navigationController pushViewController:wifiCtrl animated:YES];
        };
        cell.tapSaftyTestBgViewwBlock = ^{
            [Dialog simpleToast:@"当前wifi监测安全,可放心使用"];
        };
        
        cell.tapSpeedTestBgViewBlock = ^{
            
            WifiSpeedTestController *ctrl  = [WifiSpeedTestController new];
            [wself.navigationController pushViewController:ctrl animated:YES];
        };
        return cell;
    }
    WifiListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WifiListCellID" forIndexPath:indexPath];
    if (indexPath.section == 1) {
        WIFIInfo *info = self.hktWifiArray[indexPath.row];
        [cell setInfo:info];
    } else {
        WIFIInfo *info = self.otherWifiArray[indexPath.row];
        [cell setInfo:info];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        WIFIInfo *info = self.hktWifiArray[indexPath.row];
        [[WIFISevice shared]applicationConnectWifi:info];
    } else if (indexPath.section == 2) {
        [Dialog simpleToast:@"当前wifi无法连接,请稍后尝试"];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2 ) {
        WINormalCellHeader *header = [[WINormalCellHeader alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 45)];
        if (section == 1) {
            header.titleLabel.text = @"推荐WIFI";
        } else {
            header.titleLabel.text = @"其他WIFI";
        }
        return header;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1 || section == 2) {
        return 45;
    }
    return CGFLOAT_MIN;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
