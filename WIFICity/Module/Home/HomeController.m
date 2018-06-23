//
//  HomeController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HomeController.h"

#import "WIFISevice.h"
#import "WifiPanel.h"

#import "HomeNewsOneCell.h"
#import "HomeNewsTwoCell.h"
#import "HomeBannerCell.h"
#import "HomeServiceCell.h"

#import "EasyNormalRefreshHeader.h"



#define SaveUserFlowAPI @"/ws/third/saveFlow.do"
#define FindUserFLowAPI @"/ws/third/findBandByUserId.do"

#define LbtInfoAPI  @"/ws/wifi/findLbtByOrgId.do"
#define HomeNewsApi @"/ws/wifi/findDeliveryByOrgId.do" //8a8ab0b246dc81120146dc8180ba0017
#define HomeThirdAPI @"/ws/third/findAllThirdIcon.do"

@interface HomeController ()<UITableViewDelegate,UITableViewDataSource,WifiPanelProtocol>

@property (nonatomic,strong)EaseTableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,copy)NSArray *lbtArray;
@property (nonatomic,copy)NSArray *serviceArray;
@property (nonatomic,strong)WifiPanel *panel;
@property (nonatomic,strong)UIView *headerView;

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [WIFISevice shared].panelDelegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[AccountManager shared]handleWhenAppStart];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[WIFISevice shared]setNetMonitor];
    [self setWhiteTrasluntNavBar];
    [self loadHomeData];
    
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

#pragma mark - load data

- (void)loadHomeData {
    [self requestLbtData];
    [self requestHomeNews];
    [self requestServiceData];
}

- (void)requestLbtData {
    NSDictionary *para = @{@"orgId":@"8a8ab0b246dc81120146dc8180ba0017"};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, LbtInfoAPI) params:para successBlock:^(NSDictionary *returnData) {
        NSArray *lbtArray = [HomeLbtResponse arrayOfModelsFromDictionaries:[returnData objectForKey:@"obj"] error:nil];
        self.lbtArray = [lbtArray copy];
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)requestHomeNews {
    NSDictionary *para = @{@"orgId":@"8a8ab0b246dc81120146dc8180ba0017"};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, HomeNewsApi) params:para successBlock:^(NSDictionary *returnData) {
        NSArray *newsArray = [HomeNews arrayOfModelsFromDictionaries:[returnData objectForKey:@"obj"] error:nil];
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:newsArray];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failureBlock:^(NSError *error) {
        kHudNetError;
    } showHUD:NO];
}

- (void)requestServiceData {
    NSDictionary *para = @{@"number":@"1"};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, HomeThirdAPI) params:para successBlock:^(NSDictionary *returnData) {
        NSArray *serviceArray = [HomeServiceData arrayOfModelsFromDictionaries:[returnData objectForKey:@"obj"] error:nil];
        self.serviceArray = [serviceArray copy];
        
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        
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
        _tableView.mj_header = [EasyNormalRefreshHeader headerWithRefreshingBlock:^{
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
        return cell;
    }
    else if (indexPath.section == 1) {
        HomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBannerCellID" forIndexPath:indexPath];
        [cell setCoursalImageDataArray:[self.lbtArray copy]];
        return cell;
    }
    else {
        HomeNews *news = [self.dataArray objectAtIndex:indexPath.row];
//        if ([news.information_type isEqualToString:@"1"]) {
            HomeNewsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsOneCellID" forIndexPath:indexPath];
            [cell setNews:news];
            return cell;
//        } else {
//            HomeNewsTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsTwoCellID" forIndexPath:indexPath];
//            [cell setNews:news];
//            return cell;
//        }

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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1 ) {
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
        [NavManager pushWebViewControllerWithHtmlWord:news.details controller:self];
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
    // Dispose of any resources that can be recreated.
}


@end
