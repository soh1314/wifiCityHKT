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
#import "CompanySortTopView.h"

#import "CompanyDetailController.h"
#import "CompanySearchController.h"
@interface CompanySortController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger showType;
@property (nonatomic,strong)EaseSearchBar *searchBar;
@property (nonatomic,strong)CompanySortTopView *sortTopView;

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
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)loadData {
    
}

- (void)initUI {
    self.sortTopView = [CompanySortTopView topViewWithTitleArray:@[@"类别",@"距离"] imageArray:@[@"triangle",@"triangle"] frame:CGRectMake(0, 0, KSCREENW, 40)];
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
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(278);
        make.height.mas_equalTo(36);
    }];
    __weak typeof(self)wself = self;
    self.searchBar.actionblock = ^{
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

#pragma mark -collect delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择了哪个答案:%ld",indexPath.row);
    CompanyDetailController *detailCtrl = [CompanyDetailController new];
    [self.navigationController pushViewController:detailCtrl animated:YES];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.showType == 0) {
        CompanyInfoVerticalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompanyInfoVerticalCellID" forIndexPath:indexPath];
        
        return cell;
    } else {
        CompanyInfoHorizonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompanyInfoHorizonCellID" forIndexPath:indexPath];
        
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
    return 8.0f;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
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
