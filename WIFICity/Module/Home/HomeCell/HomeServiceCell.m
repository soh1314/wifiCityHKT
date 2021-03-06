//
//  HomeServiceCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HomeServiceCell.h"
#import "HomeServiceItemCell.h"

@implementation HomeServiceCell

+ (void)pickCellItem:(NSInteger)index dataArray:(NSArray *)dataArray {
//    EasePageController *pageController = [EasePageController new];
//    HomeServiceData *data = self.serviceArray[idx];
//    pageController.title = [data.thirdName copy];
//    pageController.count = 2;
//    EasePageModel *model0 = [EasePageModel new];
//    model0.title = @"国家政策";
//    model0.index = 0;
//    EasePageModel *model1 = [EasePageModel new];
//    model1.title = @"省市政策";
//    model1.index = 1;
//    NSMutableArray *array = [NSMutableArray array];
//    [array addObject:model0];
//    [array addObject:model1];
//    pageController.itemModel = [array copy];
//    [self.navigationController pushViewController:pageController animated:YES];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initUI];
}

- (void)initUI {
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)setServiceInfo:(NSDictionary *)serviceInfo {
    _serviceInfo = [serviceInfo copy];
    
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
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
        _collectionView.bounces = NO;
        _collectionView.pagingEnabled = NO;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeServiceItemCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HomeServiceItemCellID"];
    }
    return _collectionView;
}

#pragma mark -collect delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择了哪个答案:%ld",indexPath.row);
    if (_pick) {
        _pick(indexPath.row);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeServiceItemCell *colCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeServiceItemCellID" forIndexPath:indexPath];
    HomeServiceData *data = self.dataArray[indexPath.row];
    [colCell setServiceData:data];
    return colCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((KSCREENW-5.0-10)/5.0f,61);
}

//调节每个item的edgeInsets代理方法
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 5, 15, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return 0.5f;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 12.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
