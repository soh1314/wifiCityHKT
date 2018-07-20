//
//  CompanySearchController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/6.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanySearchController.h"
#import "EaseSearchBar.h"
#import "CompanyRecommentCell.h"
#import "EnterpriseSquareNetAPI.h"
#import "CompanyDetailController.h"

@interface CompanySearchController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong)NSMutableArray *searchResultArray;
@property (nonatomic,strong)EaseTableView *tableView;
@property (nonatomic,strong)NSMutableArray *searchHotArray;
@property (nonatomic,strong)NSMutableArray *searchHistoryArray;
@property (nonatomic,strong)EaseSearchBar *searchBar;

@end

@implementation CompanySearchController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initArray];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.searchBar invokeSearch];
        
    });

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar cancleSearch];
}

- (void)initArray {
    self.searchResultArray = [NSMutableArray array];
    self.searchHotArray = [NSMutableArray array];
    self.searchHistoryArray = [NSMutableArray array];
}

- (void)initUI {
    [self setBlackNavBar];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompanyRecommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CompanyRecommentCellID"];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelSearch:)];
    if (KSys11Up) {
        [rightBarItem setTitlePositionAdjustment:UIOffsetMake(5, 0) forBarMetrics:UIBarMetricsDefault];
    }
   [rightBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateSelected];
   [rightBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    self.searchBar = [[EaseSearchBar alloc]initWithFrame:CGRectMake(0, 0, 278/375.0f*KSCREENW, 36)];
    self.searchBar.searchTtf.userInteractionEnabled = YES;
    self.searchBar.textfieldPlaceHolderName = @"搜企业名、老板...";
    self.searchBar.searchTtf.delegate = self;
    __weak typeof(self)wself = self;
    self.searchBar.actionblock = ^{
        [wself.searchBar.searchTtf becomeFirstResponder];
    };
    self.navigationItem.titleView = self.searchBar;
    if (KSys11Up) {
        [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(270/375.0f*KSCREENW);
            make.height.mas_equalTo(36);
            make.centerX.mas_equalTo(self.navigationItem.titleView.mas_centerX);
        }];
    }

}


#pragma mark - search delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
   [self requestCompanySearch:textField.text];
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(requestCompanySearch:) withObject:self.searchBar.searchTtf.text afterDelay:0.3];
    return YES;
    
}

- (void)cancelSearch:(id)sender {
   
    [self.searchBar cancleSearch];
}

- (void)requestCompanySearch:(NSString *)companyName {
    if (self.searchBar.searchTtf.markedTextRange) {
        return;
    }
    NSString *searchWord = [self.searchBar.searchTtf.text copy];
    if (!searchWord || [searchWord isEqualToString:@""]) {
        [self.searchResultArray removeAllObjects];
        [self.tableView reloadData];
        return;
    }
    NSDictionary *para = @{@"useId":[AccountManager shared].user.userId,@"comName":[searchWord copy]};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, CompanySearchAPI) params:para successBlock:^(NSDictionary *returnData) {
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        if (response && response.success) {
            NSArray *dataArray = [WICompanyInfo arrayOfModelsFromDictionaries:(NSArray *)response.obj error:nil];
            [self.searchResultArray removeAllObjects];
            [self.searchResultArray addObjectsFromArray:dataArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

#pragma mark - 搜索热门和历史记录
- (void)loadHotHistoryData {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CompanyRecommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyRecommentCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WICompanyInfo *info = self.searchResultArray[indexPath.row];
    cell.companyInfo = info;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.searchBar.searchTtf.isFirstResponder) {
        [self.searchBar.searchTtf resignFirstResponder];
        return;
    }
    WICompanyInfo *info = self.searchResultArray[indexPath.row];
    CompanyDetailController *detailCtrl = [CompanyDetailController new];
    detailCtrl.info = info;
    [self.navigationController pushViewController:detailCtrl animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - get and set
- (EaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[EaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.estimatedRowHeight = 200;
    }
    return _tableView;
}

@end
