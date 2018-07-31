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
#import "WIFISevice.h"
#import "EasyCacheHelper.h"

@interface WifiCheckController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)WifiDectectPanel *panel;

@property (nonatomic,strong)EaseTableView *tableView;

@property (nonatomic,copy)NSArray *wifiArray;

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
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"WINETSTATUSCHANGE" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setWhiteTrasluntNavBar];
    [self setPanelData];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];

}

- (void)getWifiListCach {
    NSArray *wifiCachArray = [EasyCacheHelper getResponseCacheForKey:HKTWIFIARRAYKEY];
    if (wifiCachArray && wifiCachArray.count > 0) {
        self.wifiArray = [wifiCachArray copy];
        [self.tableView reloadData];
    }
}

- (void)setPanelData {
    WIFIInfo *info = [WIFISevice shared].wifiInfo;
    [self.panel setInfo:info];
}

#pragma  mark - noti
- (void)applicationEnterForeground:(NSNotification *)noti {
    
    self.wifiArray = [[WIFISevice shared].m_wifiArray copy];
    [self.tableView reloadData];
}

- (void)wifiStatusChange:(NSNotification *)noti {
    [self setPanelData];
}

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
//        _tableView.contentInset  = UIEdgeInsetsMake(260, 0, 0, 0);
    }
    return _tableView;
}


#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.wifiArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    weakself;
    if (indexPath.section == 0) {
        WIFIListFunctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WIFIListFunctionCellID" forIndexPath:indexPath];
        cell.tapWifiMapBgViewBlock = ^{
            WifiMapController *wifiCtrl = [WifiMapController new];
            [wself.navigationController pushViewController:wifiCtrl animated:YES];
        };
        return cell;
    }
    WifiListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WifiListCellID" forIndexPath:indexPath];
    WIFIInfo *info = self.wifiArray[indexPath.row];
    [cell setInfo:info];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        WIFIInfo *info = self.wifiArray[indexPath.row];
        [[WIFISevice shared]applicationConnectWifi:info];
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
