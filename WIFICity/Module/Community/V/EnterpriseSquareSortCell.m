//
//  EnterpriseSquareSortCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/5.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EnterpriseSquareSortCell.h"
#import "HomeServiceItemCell.h"
#import "EnterPriseTagCell.h"
@implementation EnterpriseSquareSortCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self initUI];
    self.imageArray = @[@"app",@"ai",@"block_chain",@"phone_pay",@"small_program",@"medical",@"VR",@"iot",@"manufacturing",@"big_data",@"education_services",@"navigation"];
    self.titleArray = @[@"app",@"AI",@"区块链",@"手机支付",@"小程序",@"智慧医疗",@"VR",@"物联网",@"智能制造",@"大数据",@"数字教育",@"北斗导航"];
    
    // Initialization code
}

- (void)initUI {
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.contentView).mas_offset(28);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(45.0f);
        make.top.mas_equalTo(self.contentView).mas_offset(12);
    }];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)setCategoryModelArray:(NSArray *)categoryModelArray {
    _categoryModelArray = categoryModelArray;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView
{
    if(!_collectionView)
    {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 85) collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.pagingEnabled = NO;
        _collectionView.scrollEnabled = NO;
//        [_collectionView registerNib:[UINib nibWithNibName:@"HomeServiceItemCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HomeServiceItemCellID"];
        [_collectionView registerClass:[EnterPriseTagCell class] forCellWithReuseIdentifier:@"EnterPriseTagCellID"];
    }
    return _collectionView;
}

#pragma mark -collect delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择了哪个答案:%ld",indexPath.row);
    if (_pick) {
        _pick(indexPath.row,self.categoryModelArray[indexPath.row]);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categoryModelArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EnterPriseTagCell *colCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EnterPriseTagCellID" forIndexPath:indexPath];
//    colCell.serviceImageView.image = [UIImage qsImageNamed:self.imageArray[indexPath.row]];
//    colCell.serviceNameLabel.text = self.titleArray[indexPath.row];

//    colCell.serviceNameLabel.text  = [category.entName copy];
//    colCell.serviceNameLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    WICompanyCategory *category = self.categoryModelArray[indexPath.row];
    colCell.nameLabel.text = [category.entName copy];
    return colCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(49,20);
}

//调节每个item的edgeInsets代理方法
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0f;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
