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

#import "CompanyDetailController.h"
#import "CompanySearchController.h"
#import "EnterpriseSquareNetAPI.h"
#import "WICompanyInfo.h"
#import "WICompanyCategory.h"
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
    self.showType = 0;
    [self initUI];
    if (!self.categoryID) {
        self.categoryID = @"402883b260d36c5f0160d4c0d7f70017";
    }
    [self loadData:YES];
    self.dataArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar cancleSearch];
}

- (void)loadData:(BOOL)refresh {
    if (refresh) {
        self.page = 0;
    } else {
        self.page++;
    }
    
    NSDictionary *para = @{@"useId":[AccountManager shared].user.userId,@"pageNum":[NSString stringWithFormat:@"%ld",self.page],@"entID":[self.categoryID copy]};
    [MHNetworkManager getRequstWithURL:kAppUrl(kUrlHost, CompanyCategoryListAPI) params:para successBlock:^(NSDictionary *returnData) {
        WINetResponse *response = [[WINetResponse alloc]initWithDictionary:returnData error:nil];
        if (response && response.success) {
            NSArray *dataArray = [WICompanyInfo arrayOfModelsFromDictionaries:(NSArray *)response.obj error:nil];
            if (refresh) {
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:dataArray];
            } else {
                [self.dataArray addObjectsFromArray:dataArray];
            }
            [self.collectionView reloadData];
        }
    } failureBlock:^(NSError *error) {
        
    } showHUD:NO];
}

- (void)initUI {
    self.sortTopView = [EaseDropMenu topViewWithTitleArray:@[@"类别",@"距离"] imageArray:@[@"triangle",@"triangle"] frame:CGRectMake(0, 0, KSCREENW, 40)];
    self.sortTopView.delegate = self;
    self.sortTopView.tapBlock = ^(NSInteger index, EaseSortItemView *view) {
        if (index == 0) {
            
        }
    };
    [self.view addSubview:self.sortTopView];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.sortTopView.mas_bottom);
    }];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CompanyInfoVerticalCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CompanyInfoVerticalCellID"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CompanyInfoHorizonCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CompanyInfoHorizonCellID"];
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
    __weak typeof(self)wself = self;
    self.searchBar.actionblock = ^{
        [wself.view endEditing:YES];
        CompanySearchController *searchCtrl = [CompanySearchController new];
        [wself.navigationController pushViewController:searchCtrl animated:YES];
    };
    
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
        WICompanyCategroyView *categoryView  = [[WICompanyCategroyView alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 156)];
        categoryView.backgroundColor = [UIColor redColor];
        categoryView.categoryArray = @[@"app",@"AI",@"区块链",@"手机支付",@"小程序",@"智慧医疗",@"VR",@"物联网",@"智能制造",@"大数据",@"数字教育",@"北斗导航"];
        return categoryView;
    } else {
        return view;
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
            view.backgroundColor = [UIColor redColor];
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
        return CGSizeMake((KSCREENW-24)/2.0f,166);
    } else {
        return CGSizeMake(KSCREENW,123);
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

    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end