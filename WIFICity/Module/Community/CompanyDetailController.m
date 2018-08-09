//
//  CompanyDetailController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanyDetailController.h"
#import "CompanyDetailSectionOne.h"
#import "CompanyDetailSectionTwo.h"
#import "CompanyDeatailSectionThree.h"
#import "CompanyDetailSectionFour.h"
#import "CompanyDetailRecruitCell.h"
#import "CompanyDetailCommentCell.h"
#import "CompanyDetailNoCommentCell.h"
#import "WebViewController.h"
#import "WICommentBottomBar.h"
#import "WIPopView.h"
#import "WINormalCellHeader.h"
#import "IEnterPrise.h"
#import "WIComment.h"
#import "UIViewController+EasyUtil.h"
#import "WIUtil.h"

static NSString *const EnterPriseCompanyDetailAPI = @"/ws/company/findCompanyById.do";

@interface CompanyDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)EaseTableView *tableView;

@property (nonatomic,strong)WICommentBottomBar *commentBottomBar;

@property (nonatomic,strong)NSMutableArray *commentArray;

@property (nonatomic,assign)BOOL collected;

@property (nonatomic,strong)IEnterPrise *dispatch;

@end

@implementation CompanyDetailController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业详情";
    [self setBlackNavBar];
    self.commentArray = [NSMutableArray array];
    [self initUI];
    [self loadCompanyDetailData];
    [self loadData:YES];

    // Do any additional setup after loading the view.
}

- (void)loadData:(BOOL)refresh {
    if (refresh) {
        [self.commentArray removeAllObjects];
    }
    [Dialog showRingLoadingView:self.view];
    NSDictionary *para = @{@"disId":[self.info.ID copy],@"disType":@"1",@"useId":[AccountManager shared].user.userId};
    [IEnterPrise enterpriseCommentList:^(WINetResponse *response) {
        [Dialog hideToastView:self.view];
        if (response) {
            NSArray *commentArray = [WIComment arrayOfModelsFromDictionaries:(NSArray *)response.obj error:nil];
            [self.commentArray addObjectsFromArray:commentArray];
            [self updateView];
            [self updateCommentNum];
        }
    } par:para];
}

- (void)loadCompanyDetailData {
    
    NSDictionary *para = @{@"comId":self.info.ID,@"useId":[AccountManager shared].user.userId};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, EnterPriseCompanyDetailAPI) params:para successBlock:^(NSDictionary *returnData) {
        self.info = [[WICompanyInfo alloc]initWithDictionary:returnData[@"obj"][0] error:nil];
        [self updateView];
        [Dialog hideToastView:self.view];
    } failureBlock:^(NSError *error) {
        [Dialog hideToastView:self.view];
        kHudNetError;
    } showHUD:NO];
}

- (void)updateView {
    self.commentBottomBar.info = self.info;
    [self.tableView reloadData];
}

- (void)updateCommentNum {
    self.commentBottomBar.commentNum = self.commentArray.count;
}

- (void)initUI {
    [self.view addSubview:self.tableView];
    self.commentBottomBar = [[WICommentBottomBar alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 40)];
    [self.view addSubview:self.commentBottomBar];
    [self.commentBottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-1*KBottomBarPadding);
        make.height.mas_equalTo(40+KBottomBarPadding);
        
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.commentBottomBar.mas_top);
    }];
    __weak typeof(self)wself = self;
    self.commentBottomBar.tapBlock = ^{
        WICommentView *commentView =  [WIPopView popCommentView:wself];
        commentView.info = wself.info;
        commentView.delegate = wself.dispatch;

    };
    [self.tableView registerNib:[UINib nibWithNibName:@"CompanyDetailSectionFour" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CompanyDetailSectionFourID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompanyDetailSectionTwo" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CompanyDetailSectionTwoID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompanyDetailSectionOne" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CompanyDetailSectionOneID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompanyDeatailSectionThree" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CompanyDeatailSectionThreeID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompanyDetailRecruitCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CompanyDetailRecruitCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompanyDetailCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CompanyDetailCommentCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompanyDetailNoCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CompanyDetailNoCommentCellID"];
    
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc]initWithImage:[UIImage qsImageNamed:@"collect_default"] style:UIBarButtonItemStylePlain target:self action:@selector(collectCompanyInfo:)];
    self.navigationItem.rightBarButtonItem = collectItem;
    
}

- (IEnterPrise *)dispatch {
    if (!_dispatch) {
        _dispatch = [IEnterPrise new];
        _dispatch.needReload = YES;
        weakself;
        _dispatch.reloadBlock = ^{
            [wself loadData:YES];
        };
    }
    return _dispatch;
}

- (void)collectCompanyInfo:(id)sender {
    self.collected = self.collected ? NO : YES ;
    if (self.collected) {
//        [self.dispatch collectCompany:self.info complete:^(WINetResponse *response) {
//            if (response && response.success) {
//                [self.navigationItem.rightBarButtonItem setImage:[UIImage qsImageNamed:@"collect"]];
//            }
//
//        }];
        [self.navigationItem.rightBarButtonItem setImage:[UIImage qsImageNamed:@"collect"]];
    } else {
//        [self.dispatch unCollectCompany:self.info complete:^(WINetResponse *response) {
//            if (response && response.success) {
//                [self.navigationItem.rightBarButtonItem setImage:[UIImage qsImageNamed:@"collect_default"]];
//            }
//        }];
        [self.navigationItem.rightBarButtonItem setImage:[UIImage qsImageNamed:@"collect_default"]];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        if (!self.commentArray.count) {
            return 1;
        } else {
            return self.commentArray.count >= 3 ? 3 : self.commentArray.count ;
        }
    }
    return 1;
}

- (void)jumpToWebViewController:(NSString *)url {
    WebViewController *webView = [WebViewController new];
    webView.URLString = [url copy];
    [self.navigationController pushViewController:webView animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    weakself;
    if (section == 0) {
        CompanyDetailSectionOne *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyDetailSectionOneID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.webSiteBlock = ^{
            [wself jumpToWebViewController:wself.info.com_website];
        };
        cell.SeeQuanjinBlock = ^{
            [wself jumpToWebViewController:@"https://720yun.com/t/946jezwnuv5?scene_id=17042939&from=groupmessage"];
        };
        cell.locateBlock = ^{
            [WIUtil openThirdMap:cell.info.com_name viewcontroller:wself];
            
        };
        cell.info = self.info;
        return cell;
        
    } else if (section == 1) {
        CompanyDetailSectionTwo *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyDetailSectionTwoID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.info = self.info;
        
        return cell;
    } else if (section == 2) {
        CompanyDetailRecruitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyDetailRecruitCellID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        if (!self.commentArray.count) {
            CompanyDetailNoCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyDetailNoCommentCellID" forIndexPath:indexPath];
            
            return cell;
        } else {
            WIComment *comment = self.commentArray[indexPath.row];
            CompanyDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyDetailCommentCellID" forIndexPath:indexPath];
            [cell setComment:comment];
            return cell;
        }

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        [Dialog simpleToast:@"当前企业暂无招聘信息"];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        WINormalCellHeader *header = [[WINormalCellHeader alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 40)];
        header.titleLabel.text = @"最新评论";
        return header;
    }
    return [UIView new];

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return CGFLOAT_MIN;
    }
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return 40;
    }
    return CGFLOAT_MIN;
}

@end
