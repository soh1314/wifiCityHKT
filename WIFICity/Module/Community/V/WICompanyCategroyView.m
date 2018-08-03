//
//  WICompanyCategroyView.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/9.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WICompanyCategroyView.h"
#import "WICompanyCategroyCell.h"
@implementation WICompanyCategroyView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.collectionView];
    self.collectionView.frame = self.bounds;

}

- (void)setSelectCategory:(WICompanyCategory *)selectCategory {
    if (selectCategory) {
        _selectCategory  = selectCategory;
    }
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
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.pagingEnabled = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.pagingEnabled = NO;
        _collectionView.scrollEnabled = YES;
        [_collectionView registerNib:[UINib nibWithNibName:@"WICompanyCategroyCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"WICompanyCategroyCellID"];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        
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
    return self.categoryArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WICompanyCategroyCell *colCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WICompanyCategroyCellID" forIndexPath:indexPath];
    WICompanyCategory *category = self.categoryArray[indexPath.row];
    if (self.flowLayoutType == 0) {
        colCell.companyNameLabel.textAlignment = NSTextAlignmentLeft;
    } else {
        colCell.companyNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    if (category.entName) {
        if (self.selectCategory && self.selectCategory.entName && [self.selectCategory.entName isEqualToString:category.entName]) {
            colCell.companyNameLabel.textColor = [UIColor themeColor];
        } else {
            colCell.companyNameLabel.textColor = [UIColor colorWithHexString:@"#666666"];;
        }
        colCell.companyNameLabel.text = [category.entName copy];
    } else {
        if (self.selectCategory && self.selectCategory.industryName && [self.selectCategory.industryName isEqualToString:category.industryName]) {
            colCell.companyNameLabel.textColor = [UIColor themeColor];
        } else {
            colCell.companyNameLabel.textColor = [UIColor colorWithHexString:@"#666666"];;
        }
        colCell.companyNameLabel.text = [category.industryName copy];
    }

    return colCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.flowLayoutType == 0) {
        return CGSizeMake(KSCREENW,40);
    } else {
       return CGSizeMake(KSCREENW/2.0,40);
    }
   
}

//调节每个item的edgeInsets代理方法
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section

{
    return CGFLOAT_MIN;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CGFLOAT_MIN;
}

@end
