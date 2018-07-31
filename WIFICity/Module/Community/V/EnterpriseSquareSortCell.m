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
#import "EnterPriseAreaColCell.h"
@implementation EnterpriseSquareSortCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self initUI];

    
    // Initialization code
}

- (void)initUI {
    [self.contentView addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews {
//    if (self.cellType == 0) {
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
//    }
//    else {
//        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.mas_equalTo(self.contentView).mas_offset(28);
//            make.centerX.mas_equalTo(self);
//            make.height.mas_equalTo(45.0f);
//            make.top.mas_equalTo(self.contentView).mas_offset(12);
//        }];
//    }
}

- (void)setCategoryModelArray:(NSArray *)categoryModelArray {
    _categoryModelArray = categoryModelArray;
//    if (self.cellType == 0) {
//        self.imageArray = @[@"advanced_equipment",@"biomedicine",@"electronic_information",@"modern_services",@"new_energy",@"new_material"];
//        self.titleArray = @[@"生物医药与健康产业",@"新材料产业",@"现代服务业",@"手机新新能源与节能",@"先进装备制造产业",@"电子信息及互联网技术"];
//    }
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
        _collectionView.bounces = YES;
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollEnabled = YES;
        [_collectionView registerNib:[UINib nibWithNibName:@"EnterPriseAreaColCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"EnterPriseAreaColCellID"];
        [_collectionView registerClass:[EnterPriseTagCell class] forCellWithReuseIdentifier:@"EnterPriseTagCellID"];
    }
    return _collectionView;
}

#pragma mark -collect delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择了哪个答案:%ld",indexPath.row);
    if (_pick) {
        if (self.categoryModelArray.count > 0) {
            _pick(indexPath.row,self.categoryModelArray[indexPath.row]);
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.categoryModelArray.count;

    
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.cellType == SquareSortCellImageTextType) {
        EnterPriseAreaColCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EnterPriseAreaColCellID" forIndexPath:indexPath];
//        itemCell.areaIconView.image = [UIImage qsImageNamed:self.imageArray[indexPath.row]];
//        itemCell.areaNameLabel.text = self.titleArray[indexPath.row];
        WICompanyCategory *category = self.categoryModelArray[indexPath.row];
        [itemCell.areaIconView sd_setImageWithURL:[NSURL URLWithString:category.industryImgUrl]];
        itemCell.areaNameLabel.text = [category.industryName copy];
        itemCell.areaNameLabel.textColor = [UIColor colorWithHexString:@"#141414"];
        return itemCell;
    } else {
        WICompanyCategory *category = self.categoryModelArray[indexPath.row];
        EnterPriseTagCell *colCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EnterPriseTagCellID" forIndexPath:indexPath];
        colCell.nameLabel.text = [category.entName copy];
        return colCell;
    }

   
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellType == 0) {
        return CGSizeMake((KSCREENW-2*12-2*15)/3.0f, 80);
    } else {
        return CGSizeMake((KSCREENW-5*5 -2* 12)/6.0f,24);
    }
    
}

//调节每个item的edgeInsets代理方法
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (self.cellType == 0) {
        return UIEdgeInsetsMake(12, 15, 12, 15);
    } else {
        return UIEdgeInsetsMake(8, 12, 8, 12);
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.cellType == 0) {
        return 8.0f;
    } else {
       return 8.0f;
    }
    
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (self.cellType == 0) {
        return 12.0f;
    } else {
        return 5.0f;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
