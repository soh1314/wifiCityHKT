//
//  HomeController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HomeController.h"
#import "EasyCLLocationManager.h"
#import "WIFISevice.h"
#import "WifiPanel.h"

#import "HomeNewsOneCell.h"
#import "HomeNewsTwoCell.h"
#import "HomeBannerCell.h"
#import "HomeServiceCell.h"

#import "EaseRefreshHeader.h"
#import "WIPopView.h"

#import "EasePageController.h"
#import "HomeServicePageController.h"
#import "WebViewController.h"
#import "WifiMapController.h"
#import "AppDelegate.h"
#import "WIFIValidator.h"
#import "WIFIPusher.h"

#define FindUserFLowAPI @"/ws/third/findBandByUserId.do"
#define LbtInfoAPI  @"/v1/homepage/banner/list.do"
#define HomeThirdAPI @"/v1/homepage/module/list.do"

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource,WifiPanelProtocol>

@property (nonatomic,strong)EaseTableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,copy)NSArray *lbtArray;
@property (nonatomic,copy)NSArray *serviceArray;
@property (nonatomic,strong)WifiPanel *panel;
@property (nonatomic,strong)UIView *headerView;
@property (nonatomic,strong)dispatch_group_t group;
@property (nonatomic,assign)NSInteger page;

@end

@implementation HomeController

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.group = dispatch_group_create();
    [self loadHomeData];
    [[EasyCLLocationManager shared]startLocate:^(NSString *province, NSString *city, NSString *area, NSString *detailAddress) {
        [self.panel setLocation:[EasyCLLocationManager shared].location];
        [[EasyCLLocationManager shared]stopLocate];
//        [WIFIPusher sendRegionPush];
        
    }];
    [WIFISevice shared].panelDelegate = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(orgIDChange:) name:WIOrgIDChangeNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wifiValidateSuccess:) name:WIFIValidatorSuccessNoti object:nil];
    [[WIFISevice shared]setNetMonitor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wifiValidatingFinish:) name:@"WifiValidateingFinish" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wifiValidating:) name:@"WifiValidateingStatus" object:nil];
    
}

- (void)wifiValidateSuccess:(NSNotification *)noti {
    [self loadHomeData];
    
}


- (void)orgIDChange:(NSNotification *)noti {
    [self loadHomeData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WIOrgIDChangeNoti object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:WIFIValidatorSuccessNoti object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"WifiValidateingStatus" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"WifiValidateingFinish" object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[AccountManager shared]handleWhenAppStart];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setWhiteTrasluntNavBar];

   
    
}

- (void)initUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewsOneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeNewsOneCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewsOneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeNewsOneCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeBannerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeBannerCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeServiceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeServiceCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewsTwoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeNewsTwoCellID"];
    
    self.headerView.frame = CGRectMake(0, 0, KSCREENW, 325);
    self.tableView.tableHeaderView = self.headerView;
    [self.headerView addSubview:self.panel];
    [self.panel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.headerView);
    }];
    
}
#pragma mark - panel delegate

- (void)wifiPanelRefreshWifiInfo:(WIFIInfo *)info {
    [self.panel refreshUI:info];
}

- (void)handleWhenNetChange:(WINetStatus)status wifiInfo:(WIFIInfo*)info {
    [self.panel netChange:status wifiInfo:info];
}

- (void)wifiValidatingFinish:(NSNotification *)noti {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.panel.flowView.loadingView endAnimationWithResult:ALLoadingViewResultTypeSuccess];
        self.panel.flowView.loadingView.hidden = YES;
        [self.panel netChange:[WIFISevice netStatus] wifiInfo:[WIFISevice shared].wifiInfo];
    });
}

- (void)wifiValidating:(NSNotification *)noti {
    [self.panel.flowView.loadingView start];
    self.panel.flowView.loadingView.hidden = NO;
}

#pragma mark - load data

- (void)loadData:(BOOL)refresh {
    [self loadHomeData];
}

- (void)loadHomeData {
    [self requestLbtData];
    [self requestHomeNews];
    [self requestServiceData];
    [self getAreaUserInfo];
    dispatch_group_notify(self.group, dispatch_get_main_queue(), ^{
        [self setNoDataViewWithBaseView:self.tableView];
        [self.tableView reloadData];
    });
}

- (void)getAreaUserInfo {
    WIFIInfo *info  = [WIFISevice shared].wifiInfo;
    NSString *mac = info.hktMac;
    if (!mac || ![WIFISevice isHKTWifi]) {
        self.panel.bottomView.flowScoreLabel.text = @"0";
        return;
    }
    dispatch_group_enter(self.group);
    NSString *url = [NSString stringWithFormat:@"%@%@",@"http://www.hktfi.com/index.php/api/ap/getOnlineNum/mac/",mac];
    [MHNetworkManager getRequstWithURL:url params:nil  successBlock:^(NSDictionary *returnData) {
        NSInteger totalUser = [[returnData objectForKey:@"total"]integerValue];
        self.panel.bottomView.flowScoreLabel.text = [NSString stringWithFormat:@"%ld",totalUser];
        dispatch_group_leave(self.group);
    } failureBlock:^(NSError *error) {
        dispatch_group_leave(self.group);

    } showHUD:NO];
}


- (void)requestLbtData {
    dispatch_group_enter(self.group);
    [MHNetworkManager postReqeustWithURL:kAppUrl(kUrlHost, LbtInfoAPI) params:nil successBlock:^(NSDictionary *returnData) {
        NSDictionary *data = [returnData objectForKey:@"data"];
        if (data) {
            NSArray *lbtArray = [HomeLbtResponse arrayOfModelsFromDictionaries:[returnData objectForKey:@"data"] error:nil];
            self.lbtArray = [lbtArray copy];
        }
        [self.tableView reloadData];
        dispatch_group_leave(self.group);
    } failureBlock:^(NSError *error) {
        dispatch_group_leave(self.group);
    } showHUD:NO];
}

- (void)requestHomeNews {
    dispatch_group_enter(self.group);
    self.page = 1;
    NSDictionary *para = @{@"mac":[WIFISevice shared].wifiInfo.hktMac,@"currentPage":@(self.page),@"pageSize":@"10"};
    [MHNetworkManager postReqeustWithURL:kAppUrl(kUrlHost, WIFIHomeNewsAPI) params:para successBlock:^(NSDictionary *returnData) {
        [self.tableView.mj_header endRefreshing];
        NSDictionary *data = [returnData objectForKey:@"data"];
        if (data) {
            NSArray *newsArray = [HomeNews arrayOfModelsFromDictionaries:[data objectForKey:@"rows"] error:nil];
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:newsArray];
        }
        [self.tableView reloadData];
        dispatch_group_leave(self.group);
    } failureBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        dispatch_group_leave(self.group);
        kHudNetError;
    } showHUD:NO];
}

- (void)requestServiceData {
    dispatch_group_enter(self.group);
    NSString *mac = [WIFISevice shared].wifiInfo.hktMac;
    NSDictionary *para = @{@"mac":mac};
    [MHNetworkManager postReqeustWithURL:kAppUrl(kUrlHost, HomeThirdAPI) params:para successBlock:^(NSDictionary *returnData) {
        NSDictionary *data = [returnData objectForKey:@"data"];
        if (data) {
            NSArray *serviceArray = [HomeServiceData arrayOfModelsFromDictionaries:(NSArray *)data error:nil];
            self.serviceArray = [serviceArray copy];
        }
        [self.tableView reloadData];
        dispatch_group_leave(self.group);
    } failureBlock:^(NSError *error) {
        dispatch_group_leave(self.group);
    } showHUD:NO];
}

#pragma mark - lazy load

- (EaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[EaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor themeTableEdgeColor];
        _tableView.tableFooterView = [[UIView alloc]init];
        __weak typeof(self)wself = self;
        _tableView.mj_header = [EaseRefreshHeader headerWithRefreshingBlock:^{
            [wself loadHomeData];
            
        }];
        _tableView.estimatedRowHeight = 200;
    }
    return _tableView;
}

- (WifiPanel *)panel {
    if (!_panel) {
        _panel = [[WifiPanel alloc]initWithFrame:CGRectZero];
    }
    return _panel;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]init];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - delegate and datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        HomeServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeServiceCellID" forIndexPath:indexPath];
        [cell setDataArray:self.serviceArray];
        cell.pick = ^(NSInteger idx) {
            [HomeServiceCell pickCellItem:idx dataArray:[self.serviceArray copy]];
            if (idx == 0) {
                weakself;
                [NavManager pushParoWebViewController:wself];
            } else {
                HomeServicePageController *pageController = [[HomeServicePageController alloc]initWithServiceData:self.serviceArray[idx]];
                [self.navigationController pushViewController:pageController animated:YES];
            }
        };
        return cell;
    }
    else if (indexPath.section == 1) {
        HomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBannerCellID" forIndexPath:indexPath];
        [cell setCoursalImageDataArray:[self.lbtArray copy]];
        weakself;
        cell.pick = ^(NSInteger idx) {
            HomeLbtResponse *data = self.lbtArray[idx];
            WebViewController *ctrl = [WebViewController new];
            if (data.link && ![data.link isEqualToString:@"<null>"] && [data.mark hasPrefix:@"http"]) {
                ctrl.URLString = [data.link copy];
                [wself.navigationController pushViewController:ctrl animated:YES];
            }
            if ([data.mark hasPrefix:@"module"] && [data.link isEqualToString:@"wifiMapController"]) {
                ctrl.URLString = @"http://wifi.hktfi.com/hktInformationDeliveryController.do?findById&id=8a2bf9ef6536207001653736f9d202d1";
                ctrl.newsTitle = @"无线高新,即将到来";
                [wself.navigationController pushViewController:ctrl animated:YES];
            }
            if ([data.mark hasPrefix:@"module"] && [data.link isEqualToString:@"enterpriseController"]) {
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                UITabBarController *tabCtrl = delegate.tabBarController;
                [tabCtrl setSelectedIndex:2];
            }
        };
        return cell;
    }
    else {
        HomeNews *news = [self.dataArray objectAtIndex:indexPath.row];
        if (news.imgType == 3 && news.images && news.images.count >= 2) {
            HomeNewsTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsTwoCellID" forIndexPath:indexPath];
            [cell setNews:news];
            cell.imageGroupArray = [news.images copy];
            return cell;
        } else {
            HomeNewsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsOneCellID" forIndexPath:indexPath];
            [cell setNews:news];

            return cell;
        }

    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 164;
    } else if (indexPath.section == 1) {
        return KSCREENW * 175 / 375.0f;
    }
    else {
        return UITableViewAutomaticDimension;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeader = [[UIView alloc]initWithFrame:CGRectZero];
    return sectionHeader;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.serviceArray.count ) {
        return 0;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1 ) {
        if (self.dataArray.count == 0 && !self.lbtArray.count &&!self.serviceArray.count) {
            return 0;
        }
        return 1;
    } else {
        return self.dataArray.count;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 2) {
        HomeNews *news = [self.dataArray objectAtIndex:indexPath.row];
        NSString *detailUrl =  news.url;
        [NavManager pushWebViewControllerWithUrlString:detailUrl title:news.title controller:self];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    } else {
        return CGFLOAT_MIN;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return CGFLOAT_MIN;
    } else {
        return 5;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
