//
//  NewsSearchController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/8/1.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "NewsSearchController.h"
#import "EaseSearchBar.h"
#import "HomeNews.h"
#import "HomeNewsOneCell.h"
#import "WIFISevice.h"
#import "WebViewController.h"

static NSString *const HomeSearchNewsAPI = @"/ws/third/findDeliveryByOrgIdAndTitle.do?";

@interface NewsSearchController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIImageView  *imageView;
@property (nonatomic,strong)EaseSearchBar *searchBar;
@property (nonatomic,strong)UIButton *cancleBtn;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)EaseTableView *tableView;
@end

@implementation NewsSearchController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame{
    UIBlurEffect * effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha = 0.9;
    effectView.frame = frame;
    return effectView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.imageView = [UIImageView new];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.imageView.image = self.bgImage;
    [self.imageView addSubview:[self effectViewWithFrame:self.view.frame]];
    self.searchBar = [[EaseSearchBar alloc]initWithFrame:CGRectMake(16, 25, 278/375.0f*KSCREENW, 35)];
    self.searchBar.searchTtf.userInteractionEnabled = YES;
    self.searchBar.textfieldPlaceHolderName = @"搜企业名、老板...";
    self.searchBar.searchTtf.delegate = self;
    __weak typeof(self)wself = self;
    self.searchBar.actionblock = ^{
        [wself.searchBar.searchTtf becomeFirstResponder];
    };
    [self.view addSubview:self.searchBar];

    self.cancleBtn = [UIButton new];
    [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancleBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    [self.cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.cancleBtn];
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.centerY.mas_equalTo(self.searchBar);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(16);
        make.top.mas_equalTo(self.view).mas_offset(25);
        make.right.mas_equalTo(self.cancleBtn.mas_left).mas_offset(-10);
        make.height.mas_equalTo(35);
    }];
    [self.cancleBtn addTarget:self action:@selector(cancleSearch:) forControlEvents:UIControlEventTouchUpInside];
    self.dataArray = [NSMutableArray array];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchBar.mas_bottom).mas_offset(15);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewsOneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeNewsOneCellID"];
    
    self.dataArray = [NSMutableArray array];
    [self.searchBar.searchTtf becomeFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setWhiteTrasluntNavBar];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar.searchTtf resignFirstResponder];
}

#pragma mark - search method

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self searchNews:textField.text];
    [textField resignFirstResponder];
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
//    [self performSelector:@selector(searchNews:) withObject:self.searchBar.searchTtf.text afterDelay:0.3];
//    return YES;
//
//}

- (void)searchNews:(NSString *)word {
    if (self.searchBar.searchTtf.markedTextRange) {
        return;
    }
    NSString *searchWord = [self.searchBar.searchTtf.text copy];
    if (!searchWord || [searchWord isEqualToString:@""]) {
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
        return;
    }
    [self.dataArray removeAllObjects];
    NSDictionary *para = @{@"title":[searchWord copy],@"orgId":[WIFISevice shared].wifiInfo.orgId};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, HomeSearchNewsAPI) params:para successBlock:^(NSDictionary *returnData) {
        NSArray *array = [HomeNews arrayOfModelsFromDictionaries:returnData[@"obj"] error:nil];
        [self.dataArray addObjectsFromArray:array];
        [self.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        kHudNetError;
    } showHUD:NO];
    
}

#pragma mark - get and set
- (EaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[EaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor themeTableEdgeColor];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.estimatedRowHeight = 200;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}


#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeNews *news = self.dataArray[indexPath.row];
    HomeNewsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsOneCellID" forIndexPath:indexPath];
    [cell setNews:news];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HomeNews *news = self.dataArray[indexPath.row];
    [NavManager pushWebViewControllerWithHtmlWord:news.details title:news.title controller:self];
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

- (void)cancleSearch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
