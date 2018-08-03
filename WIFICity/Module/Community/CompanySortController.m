//
//  CompanySortController.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/4.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "CompanySortController.h"
#import "CompanyInfoVerticalCell.h"
#import "CompanyInfoHorizonCell.h"
#import "EaseSearchBar.h"
#import "EaseDropMenu.h"
#import "EaseRefreshFooter.h"
#import "EaseRefreshHeader.h"

#import "CompanyDetailController.h"
#import "CompanySearchController.h"
#import "EnterpriseSquareNetAPI.h"
#import "WICompanyInfo.h"

#import "WICompanyCategroyView.h"

@interface CompanySortController ()<UICollectionViewDelegate,UICollectionViewDataSource,EaseDropMenuDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger showType;
@property (nonatomic,strong)EaseSearchBar *searchBar;
@property (nonatomic,strong)EaseDropMenu *sortTopView;

@property (nonatomic,assign)NSInteger page;

@end

@implementation CompanySortController

- (id)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBlackNavBar];
    self.showType = 1;
    self.page = 1;
    [self initUI];
    [self loadData:YES];
    self.dataArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

- (void)loadData:(BOOL)refresh {
    if (refresh) {
        self.page = 1;
    } else {
        self.page++;
    }
    NSDictionary *para = nil;
//    if (self.categoryID && ![self.categoryID isEqualToString:@""]) {
    para = @{@"useId":[AccountManager shared].user.userId,@"pageNum":[NSString stringWithFormat:@"%ld",self.page],@"entId":[self.categoryID copy],@"industryId":[self.areaID copy]};
//    }
//    else {
//        para = @{@"useId":[AccountManager shared].user.userId,@"pageNum":[NSString stringWithFormat:@"%ld",self.page]};
//    }
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, CompanyCategoryBriefListAPI) params:para successBlock:^(NSDictionary *returnData) {
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        if (response && response.success) {
            NSArray *dataArray = [WICompanyInfo arrayOfModelsFromDictionaries:(NSArray *)response.obj error:nil];
            if (refresh) {
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:dataArray];
            } else {
                [self.dataArray addObjectsFromArray:dataArray];
            }
            if (!refresh && dataArray.count == 0 ) {
                [Dialog toast:@"没有更多数据了"];
                 [self.collectionView.mj_footer endRefreshing];
                
                return ;
            }
            [self.collectionView reloadData];
        }
        [self.collectionView.mj_footer endRefreshing];
        [self.collectionView.mj_header endRefreshing];
    } failureBlock:^(NSError *error) {
       [self.collectionView.mj_footer endRefreshing];
       [self.collectionView.mj_header endRefreshing];
    } showHUD:NO];
}

- (void)initUI {
    weakself;
    self.sortTopView = [EaseDropMenu topViewWithTitleArray:@[@"产业分类",@"产品分类"] imageArray:@[@"triangle",@"triangle"] frame:CGRectMake(0, 0, KSCREENW, 40)];
    [self.sortTopView setHideArrow:YES];
    self.sortTopView.delegate = self;
    [self.view addSubview:self.sortTopView];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.sortTopView.mas_bottom);
    }];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CompanyInfoVerticalCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CompanyInfoVerticalCellID"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CompanyInfoHorizonCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CompanyInfoHorizonCellID"];
    self.collectionView.mj_footer = [EaseRefreshFooter footerWithRefreshingBlock:^{
        [wself loadData:NO];
    }];
    self.collectionView.mj_header = [EaseRefreshHeader headerWithRefreshingBlock:^{
        [wself loadData:YES];
    }];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage qsImageNamed:@"heng"] style:UIBarButtonItemStylePlain target:self action:@selector(changeCollectionViewStyle:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    self.searchBar = [[EaseSearchBar alloc]initWithFrame:CGRectMake(0, 0, 278/375.0f*KSCREENW, 36)];
    self.searchBar.textfieldPlaceHolderName = @"";
    self.navigationItem.titleView = self.searchBar;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0) {
        [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(278);
            make.height.mas_equalTo(36);
        }];
    }
    self.searchBar.actionblock = ^{
        CompanySearchController *searchCtrl = [CompanySearchController new];
        [wself.navigationController pushViewController:searchCtrl animated:YES];
    };
    if (self.selectCategory) {
        self.sortTopView.selectItemBlock(0, self.selectCategory.industryName);
    }
    if (self.selectProductCategory) {
        self.sortTopView.selectItemBlock(1, self.selectProductCategory.entName);
    }
    
    
}

- (void)changeCollectionViewStyle:(id)sender {
    UIBarButtonItem *item = self.navigationItem.rightBarButtonItem;
    if (self.showType == 0) {
        self.showType = 1;
        [item setImage:[UIImage qsImageNamed:@"shu"]];
    } else {
        self.showType = 0;
        [item setImage:[UIImage qsImageNamed:@"heng"]];
    }
    [self.collectionView reloadData];
    
}

#pragma mark - dropmenu delegate

-(UIView *)dropContentViewForItem:(NSInteger)index {
    UIView *view = [UIView new];
    if (index == 0) {
        WICompanyCategroyView *categoryView  = [[WICompanyCategroyView alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, EaseDropItemContentViewHeight)];
        [categoryView setSelectCategory:self.selectCategory];
        weakself;
        categoryView.pick = ^(NSInteger idx) {
            WICompanyCategory *category = wself.productArray[idx];
            wself.selectCategory = category;
            wself.areaID = [category.ID copy];
            wself.sortTopView.selectItemBlock(index, category.industryName);
            [wself loadData:YES];
            [wself.sortTopView hideDropView];
        };
        categoryView.categoryArray = [self.productArray copy];
        categoryView.flowLayoutType = 0;
        categoryView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        return categoryView;
    } else {
        
        WICompanyCategroyView *categoryView  = [[WICompanyCategroyView alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, EaseDropItemContentViewHeight)];
        categoryView.flowLayoutType = 1;
        [categoryView setSelectCategory:self.selectProductCategory];
        weakself;
        categoryView.pick = ^(NSInteger idx) {
            WICompanyCategory *category = wself.categoryArray[idx];
            wself.categoryID = [category.ID copy];
            wself.selectProductCategory = category;
            wself.sortTopView.selectItemBlock(index, category.entName);
            [wself loadData:YES];
            [wself.sortTopView hideDropView];
        };
        categoryView.categoryArray = [self.categoryArray copy];
        categoryView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        return categoryView;
    }
   
    
}

- (void)dropContentTapActionForItem:(NSInteger)index {
    [self.sortTopView hideDropView];
}

- (void)reloadContentView:(NSInteger)index {
    if (index == 0) {
        UIView *view = [self dropContentViewForItem:index];
        if ([view isKindOfClass:[WICompanyCategroyView class]]) {
            WICompanyCategroyView *categoryView = (WICompanyCategroyView *)view;
            [categoryView.collectionView reloadData];
            __weak typeof(self)wself = self;
            categoryView.pick = ^(NSInteger idx) {
                [wself dropContentViewForItem:0];
                [wself loadData:YES];
            };
        }
    }

}

#pragma mark -collect delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择了哪个答案:%ld",indexPath.row);
    WICompanyInfo *info = self.dataArray[indexPath.row];
    CompanyDetailController *detailCtrl = [CompanyDetailController new];
    detailCtrl.info = info;
    [self.navigationController pushViewController:detailCtrl animated:YES];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WICompanyInfo *info = self.dataArray[indexPath.row];
    if (self.showType == 0) {
        CompanyInfoVerticalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompanyInfoVerticalCellID" forIndexPath:indexPath];
        [cell setInfo:info];
        return cell;
    } else {
        CompanyInfoHorizonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompanyInfoHorizonCellID" forIndexPath:indexPath];
        [cell setInfo:info];
        return cell;
    }

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.showType == 0) {
        return CGSizeMake((KSCREENW-24)/2.0f,202);
    } else {
        return CGSizeMake(KSCREENW,128);
    }
}

//调节每个item的edgeInsets代理方法
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (self.showType == 0) {
         return UIEdgeInsetsMake(8,8, 8, 8);
    } else {
         return UIEdgeInsetsMake(0, 0, 0, 0);
    }
   
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    if (self.showType == 1 && section == 0) {
        return CGFLOAT_MIN;
    }
    return 8.0f;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (self.showType == 1 && section == 0) {
        return CGFLOAT_MIN;
    }
    return 8.0;
}


- (UICollectionView *)collectionView
{
    if(!_collectionView)
    {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 85) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.pagingEnabled = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
        _collectionView.pagingEnabled = NO;
        _collectionView.scrollEnabled = YES;
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }

    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
