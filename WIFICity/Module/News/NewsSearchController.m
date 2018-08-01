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
static NSString *const HomeSearchNewsAPI = @"/ws/third/findDeliveryByOrgIdAndTitle.do?";

@interface NewsSearchController ()
@property (nonatomic,strong)UIImageView  *imageView;
@property (nonatomic,strong)EaseSearchBar *searchBar;
@property (nonatomic,strong)UIButton *cancleBtn;
@property (nonatomic,strong)NSMutableArray *dataArray;
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
    [self setWhiteTrasluntNavBar];
    [super viewDidLoad];
    self.imageView = [UIImageView new];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.imageView.image = self.bgImage;
    [self.imageView addSubview:[self effectViewWithFrame:self.view.frame]];
    self.searchBar = [[EaseSearchBar alloc]initWithFrame:CGRectMake(16, 25, 278/375.0f*KSCREENW, 32)];
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
    self.cancleBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
    [self.cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.cancleBtn];
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-16);
        make.centerY.mas_equalTo(self.searchBar);
        make.height.mas_equalTo(20);
    }];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(16);
        make.top.mas_equalTo(self.view).mas_offset(25);
        make.right.mas_equalTo(self.cancleBtn.mas_left).mas_offset(-10);
        make.height.mas_equalTo(32);
    }];
    [self.cancleBtn addTarget:self action:@selector(cancleSearch:) forControlEvents:UIControlEventTouchUpInside];
    self.dataArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

- (void)searchNews:(NSString *)word {
    
    [self.dataArray removeAllObjects];
    NSDictionary *para = @{@"title":[word copy],@"orgId":@""};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, HomeSearchNewsAPI) params:para successBlock:^(NSDictionary *returnData) {
        NSArray *array = [HomeNews arrayOfModelsFromDictionaries:returnData[@"obj"] error:nil];
        [self.dataArray addObjectsFromArray:array];
        
    } failureBlock:^(NSError *error) {
        kHudNetError;
    } showHUD:NO];
    
}

- (void)cancleSearch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
