//
//  EnterpriseSquareSortCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EnterpriseSquareSortCell.h"
#import "HomeServiceItemCell.h"

@implementation EnterpriseSquareSortCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    self.imageArray = @[@"app",@"ai",@"block_chain",@"phone_pay",@"small_program",@"medical",@"VR",@"iot",@"manufacturing",@"big_data",@"education_services",@"navigation"];
    self.titleArray = @[@"app",@"AI",@"区块链",@"手机支付",@"小程序",@"智慧医疗",@"VR",@"物联网",@"智能制造",@"大数据",@"数字教育",@"北斗导航"];
    
    // Initialization code
}

- (void)initUI {
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    self.collectionView.backgroundColor = [UIColor whiteColor];
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
    return self.titleArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeServiceItemCell *colCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeServiceItemCellID" forIndexPath:indexPath];
    colCell.serviceImageView.image = [UIImage qsImageNamed:self.imageArray[indexPath.row]];
    colCell.serviceNameLabel.text = self.titleArray[indexPath.row];
    colCell.serviceNameLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    return colCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((KSCREENW-5.0)/5.0f,82);
}

//调节每个item的edgeInsets代理方法
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.5f;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
