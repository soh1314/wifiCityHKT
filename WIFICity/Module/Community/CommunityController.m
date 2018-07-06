//
//  CommunityController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/12.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CommunityController.h"
#import "CompanyRecommentCell.h"
#import "EnterPriseSquareHomeInfoCell.h"
#import "EnterpriseSquareSortCell.h"
#import "CompanyRecommentHeader.h"
#import "EnterpriseSquareHomeHeader.h"
#import "ParallaxHeaderView.h"
#import "CompanySortController.h"

@interface CommunityController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)EaseTableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation CommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteTrasluntNavBar];
    [self initUI];
    [self loadData];
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
    EnterpriseSquareHomeHeader *header = [[EnterpriseSquareHomeHeader alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 175/375.0f * KSCREENW)];
    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithSubView:header];
    [self.tableView setTableHeaderView:headerView];

}

- (void)loadData {
    
}


#pragma mark - tableview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        // pass the current offset of the UITableView so that the ParallaxHeaderView layouts the subViews.
        [(ParallaxHeaderView *)self.tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 164;
    } else if (indexPath.section == 1) {
        return 85;
        
    } else {
        return UITableViewAutomaticDimension;

    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 1;
        
    } else {
        return 4;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        EnterpriseSquareSortCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnterpriseSquareSortCellID" forIndexPath:indexPath];
        
        
        return cell;
    } else if (indexPath.section == 1) {
        EnterPriseSquareHomeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnterPriseSquareHomeInfoCellID" forIndexPath:indexPath];
        
        return cell;
        
    } else {
        CompanyRecommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyRecommentCellID" forIndexPath:indexPath];
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        CompanySortController *sortCtrl = [CompanySortController new];
        [self.navigationController pushViewController:sortCtrl animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        CompanyRecommentHeader *header = [[CompanyRecommentHeader alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 41)];
        return header;
    } else {
        return [UIView new];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 41;
    } else {
        return CGFLOAT_MIN;
    }
  
}

#pragma mark - get and set
- (EaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[EaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.estimatedRowHeight = 200;
    }
    return _tableView;
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
