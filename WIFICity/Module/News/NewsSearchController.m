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
#import "WINormalCellHeader.h"
#import "NewsSearchNoneCell.h"
#import "HomeServiceCell.h"
#import "HomeServiceData.h"
#import "HomeSearchData.h"

#import "HomeServicePageController.h"

static NSString *const HomeSearchNewsAPI = @"/ws/third/findDeliveryByOrgIdAndTitle.do";
static NSString *const HomeSearchServiceAPI  = @"/ws/third/findAllThirdIconByName.do";

@interface NewsSearchController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIImageView  *imageView;
@property (nonatomic,strong)EaseSearchBar *searchBar;
@property (nonatomic,strong)UIButton *cancleBtn;
@property (nonatomic,strong)NSMutableArray *serachResultArray;
@property (nonatomic,strong)EaseTableView *tableView;
@property (nonatomic,strong)EaseTableView *searchBeforeView;
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
    self.serachResultArray = [NSMutableArray array];
    [self resetArray];
    self.imageView = [UIImageView new];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.imageView.image = self.bgImage;
    [self.imageView addSubview:[self effectViewWithFrame:self.view.frame]];
    self.searchBar = [[EaseSearchBar alloc]initWithFrame:CGRectMake(16, 25, 278/375.0f*KSCREENW, 35)];
    self.searchBar.searchTtf.userInteractionEnabled = YES;
    self.searchBar.textfieldPlaceHolderName = @"搜新闻...";
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
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchBar.mas_bottom).mas_offset(15);
        make.bottom.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).mas_offset(@(0));
        make.right.mas_equalTo(self.view).mas_offset(@(0));
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewsOneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeNewsOneCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeServiceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeServiceCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsSearchNoneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NewsSearchNoneCellID"];

    [self.searchBar.searchTtf becomeFirstResponder];
    
    self.nodataModel = [EaseNoDataModel new];
    self.nodataModel.noDataImageName = @"search_noresults";
    self.nodataModel.verticalOffset = -60;
    self.nodataModel.titile = @"没有搜索到相关信息~";
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setWhiteTrasluntNavBar];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setBlackNavBar];
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
        [self resetArray];
        [self.tableView reloadData];
        return;
    }
    [self serachService:word];;
    [self resetArray];
    
}

- (void)resetArray {
    [self.serachResultArray removeAllObjects];
}

- (void)serachHomeNews:(NSString *)word {
    NSDictionary *para = @{@"title":[word copy],@"orgId":[WIFISevice shared].wifiInfo.orgId};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, HomeSearchNewsAPI) params:para successBlock:^(NSDictionary *returnData) {
        NSArray *array = [HomeNews arrayOfModelsFromDictionaries:returnData[@"obj"] error:nil];
        if (array && array.count > 0) {
            HomeSearchData *data = [HomeSearchData new];
            data.typeString = @"新闻资讯";
            data.dataArray = [array copy];
            [self.serachResultArray addObject:data];
        }
        if (self.serachResultArray.count <= 0) {
            [self setNoDataViewWithBaseView:self.tableView];
//            [Dialog simpleToast:@"没有您想要的搜索结果"];
        }
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        kHudNetError;
    } showHUD:NO];
}

- (void)serachService:(NSString *)word {
    NSDictionary *para = @{@"thirdName":[word copy]};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, HomeSearchServiceAPI) params:para successBlock:^(NSDictionary *returnData) {
        NSArray *array = [HomeServiceData arrayOfModelsFromDictionaries:returnData[@"obj"] error:nil];
        if (array && array.count > 0) {
            HomeSearchData *data = [HomeSearchData new];
            data.typeString = @"服务功能";
            data.dataArray = [array copy];
            [self.serachResultArray addObject:data];
        }
        [self serachHomeNews:word];
        
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
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.estimatedRowHeight = 200;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}


#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    } else {
        return UITableViewAutomaticDimension;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.serachResultArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    HomeSearchData *data = self.serachResultArray[section];
    if ([data.typeString isEqualToString:@"服务功能"]) {
        return data.dataArray.count > 1 ? 1 : data.dataArray.count;
    }
    return data.dataArray.count;

  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeSearchData *data = self.serachResultArray[indexPath.section];
    if ([data.typeString isEqualToString:@"服务功能"]) {
        
        HomeServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeServiceCellID" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.collectionView.backgroundColor = [UIColor clearColor];
        [cell setDataArray:data.dataArray];
        cell.pick = ^(NSInteger idx) {
            [HomeServiceCell pickCellItem:idx dataArray:[data.dataArray copy]];
            if (idx == 0) {
                weakself;
                [NavManager pushParoWebViewController:wself];
            } else {
                HomeServicePageController *pageController = [[HomeServicePageController alloc]initWithServiceData:data.dataArray[idx]];
                [self.navigationController pushViewController:pageController animated:YES];
            }
        };
        return cell;
        
    } else {
        
        HomeNews *news = data.dataArray[indexPath.row];
        HomeNewsOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsOneCellID" forIndexPath:indexPath];
        cell.backgroundColor =  [UIColor whiteColor];
        [cell setNews:news];
        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HomeSearchData *data = self.serachResultArray[indexPath.section];
    if ([data.typeString isEqualToString:@"新闻资讯"]) {
        HomeNews *news = data.dataArray[indexPath.row];
        NSString *detailUrl = [NSString stringWithFormat:@"%@%@%@",kUrlHost,WIFIHomeNewsDetailAPI,news.ID];
        [NavManager pushWebViewControllerWithUrlString:detailUrl title:news.title controller:self];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    WINormalCellHeader *header = [[WINormalCellHeader alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 35)];
//    [header.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(header);
//        make.centerY.mas_equalTo(header);
//    }];
    header.lineView.backgroundColor = [UIColor clearColor];
    header.titleLabel.textColor = [UIColor whiteColor];
    header.backgroundColor = [UIColor clearColor];
    HomeSearchData *data = self.serachResultArray[section];
    header.titleLabel.text = [data.typeString copy];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)cancleSearch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
