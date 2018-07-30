//
//  CommunityController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CommunityController.h"
#import "CompanySortController.h"
#import "CompanySearchController.h"
#import "WebViewController.h"
#import "CompanyDetailController.h"
#import "CompanyRecommendController.h"

#import "CompanyRecommentCell.h"
#import "EnterPriseSquareHomeInfoCell.h"
#import "EnterpriseSquareSortCell.h"
#import "CompanyRecommentHeader.h"
#import "EnterpriseSquareHomeHeader.h"
#import "ParallaxHeaderView.h"
#import "EnterPriseSquareAreaCell.h"

#import "EnterpriseSquareNetAPI.h"
#import "WICompanyCategory.h"
#import "WICompanyInfo.h"

#import "EasySpringRefreshHeader.h"
#import "UIScrollView+SpringRefreshHeader.h"
#import "EaseNavBar.h"

static int EnterPriseRecommentSection = 2;

@interface CommunityController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)EaseTableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *categoryArray;
@property (nonatomic,strong)EaseNavBar *navBar;

@end

@implementation CommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
    self.categoryArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

- (void)initUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompanyRecommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CompanyRecommentCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EnterPriseSquareHomeInfoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"EnterPriseSquareHomeInfoCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EnterpriseSquareSortCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"EnterpriseSquareSortCellID"];
    [self.tableView registerClass:[EnterPriseSquareAreaCell class] forCellReuseIdentifier:@"EnterPriseSquareAreaCellID"];
    EnterpriseSquareHomeHeader *header = [[EnterpriseSquareHomeHeader alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 100)];
    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithSubView:header];
    [self.tableView setTableHeaderView:headerView];
    
    [self.view addSubview:self.navBar];
    weakself;
    CompanyHomeSearchBar *searchBar = [[CompanyHomeSearchBar alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 100)];
    searchBar.tapBlock = ^{
        CompanySearchController *vc = [CompanySearchController new];
        [wself.navigationController pushViewController:vc animated:YES];
    };
    searchBar.seePanoramaBlock = ^{
        WebViewController *webview = [[WebViewController alloc]init];
        webview.URLString = WIPanoramaUrl;
        [wself.navigationController pushViewController:webview animated:YES];
    };
     self.navBar.context = self;
    self.navBar.contentView = searchBar;
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)loadData {

    [self requestCompanyCategoryInfo];
    [self requestCompanyList];

}

- (void)requestCompanyList {
    
    NSDictionary *para = @{@"useId":[AccountManager shared].user.userId,@"pageNum":@"0"};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, CompanyCategoryListAPI) params:para successBlock:^(NSDictionary *returnData) {
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        if (response && response.success) {
            NSArray *dataArray = [WICompanyInfo arrayOfModelsFromDictionaries:(NSArray *)response.obj error:nil];
            [self.dataArray addObjectsFromArray:dataArray];
            [self.tableView reloadData];
//            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        }
        [self.tableView.es_header endRefreshing];
        
    } failureBlock:^(NSError *error) {
        
        [self.tableView.es_header endRefreshing];
        
    } showHUD:NO];
    
}

- (void)requestCompanyCategoryInfo {
    
    [MHNetworkManager postReqeustWithURL:kAppUrl(kUrlHost, CompanyCategoryAPI) params:nil successBlock:^(NSDictionary *returnData) {
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        if (response && response.success) {
            NSArray *obj = (NSArray *)response.obj;
            NSArray *categoryArray = [WICompanyCategory arrayOfModelsFromDictionaries:obj error:nil];
            [self.categoryArray removeAllObjects];
            [self.categoryArray addObjectsFromArray:categoryArray];
            [self.tableView reloadData];
        }
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}


#pragma mark - tableview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        [(ParallaxHeaderView *)self.tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 194;
    } else if (indexPath.section == 1) {
        return 73;
        
    }  else {
        return UITableViewAutomaticDimension;

    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 || section == 1 ) {
        return 1;
    }  else {
        if (self.dataArray.count > 0) {
            return 4;
        }
        return self.dataArray.count;
        
    }
}

- (void)jumpToSortController:(NSInteger)index {
    if (index != 444) {
        CompanySortController *sortCtrl = [CompanySortController new];
        WICompanyCategory *category = self.categoryArray[index];
        sortCtrl.categoryID = [category.ID copy];
        sortCtrl.categoryArray = [self.categoryArray copy];
        [self.navigationController pushViewController:sortCtrl animated:YES];
    } else {
        CompanySortController *sortCtrl = [CompanySortController new];
        [self.navigationController pushViewController:sortCtrl animated:YES];

    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
//        EnterPriseSquareAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnterPriseSquareAreaCellID" forIndexPath:indexPath];
//
//        return cell;
        EnterpriseSquareSortCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnterpriseSquareSortCellID" forIndexPath:indexPath];
        __weak typeof(self)wself = self;
        cell.cellType = SquareSortCellImageTextType;
        [cell setCategoryModelArray: [self.categoryArray copy]];
        cell.pick = ^(NSInteger idx ,WICompanyCategory *category) {
            [wself jumpToSortController:idx];
        };
        return cell;
    }  else if (indexPath.section == 1) {
        EnterpriseSquareSortCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnterpriseSquareSortCellID" forIndexPath:indexPath];
        cell.cellType = SquareSortCellTextType;
        __weak typeof(self)wself = self;
        [cell setCategoryModelArray: [self.categoryArray copy]];
        cell.pick = ^(NSInteger idx ,WICompanyCategory *category) {
            [wself jumpToSortController:idx];
        };
        return cell;
        
    } else {
        CompanyRecommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyRecommentCellID" forIndexPath:indexPath];
        WICompanyInfo *info = self.dataArray[indexPath.row];
        [cell setCompanyInfo:info];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == EnterPriseRecommentSection) {
        CompanyDetailController *detailController = [[CompanyDetailController alloc]init];
        detailController.info = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:detailController animated:YES];
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == EnterPriseRecommentSection) {
        CompanyRecommentHeader *header = [[CompanyRecommentHeader alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 41)];
        __weak typeof(self)wself = self;
        header.moreBlock = ^{
            CompanyRecommendController *ctrl = [CompanyRecommendController new];
            [wself.navigationController pushViewController:ctrl animated:YES];
        };
        return header;
    } else {
        return [UIView new];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == EnterPriseRecommentSection) {
        return 41;
    } else {
        return CGFLOAT_MIN;
    }
  
}

#pragma mark - get and set
- (EaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[EaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.estimatedRowHeight = 200;
        __weak typeof(self)wself = self;
        _tableView.es_header =  [EasySpringRefreshHeader headerWithRefreshingBlock:^{
            [wself loadData];
        }];
    }
    return _tableView;
}

- (EaseNavBar *)navBar {
    if (!_navBar) {
        _navBar = [[EaseNavBar alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 100)];
        _navBar.scrollView = self.tableView;
    }
    return _navBar;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
