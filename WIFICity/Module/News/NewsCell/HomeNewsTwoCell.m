//
//  HomeNewsTwoCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HomeNewsTwoCell.h"
#import "HomeNewsImageItemCell.h"

@implementation HomeNewsTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initUI];
    self.imageGroupArray = [NSArray array];
}

- (void)initUI {
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#111111"];
    self.agencyLabel.textColor = [UIColor colorWithHexString:@"#888888"];
    self.additionLabel.textColor = [UIColor colorWithHexString:@"#888888"];
    [self.imageGroupView addSubview:self.imageGroupCollectionView];
    CGFloat imageHeight = (KSCREENW-40)/3.0f*74/112.0f;
    [self.imageGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(imageHeight);
    }];
    [self.imageGroupCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.imageGroupCollectionView);
    }];
    
}

- (void)setNews:(HomeNews *)news {
    _news = news;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",news.title];
    self.agencyLabel.text = [NSString stringWithFormat:@"%@",news.abstracts];
    
}

- (UICollectionView *)imageGroupCollectionView
{
    if(!_imageGroupCollectionView)
    {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _imageGroupCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KSCREENW, 85) collectionViewLayout:flowLayout];
        _imageGroupCollectionView.showsVerticalScrollIndicator = NO;
        _imageGroupCollectionView.showsHorizontalScrollIndicator = NO;
        _imageGroupCollectionView.bounces = NO;
        _imageGroupCollectionView.pagingEnabled = NO;
        _imageGroupCollectionView.delegate = self;
        _imageGroupCollectionView.dataSource = self;
        _imageGroupCollectionView.showsVerticalScrollIndicator = NO;
        _imageGroupCollectionView.showsHorizontalScrollIndicator = NO;
        _imageGroupCollectionView.bounces = NO;
        _imageGroupCollectionView.pagingEnabled = NO;
        _imageGroupCollectionView.scrollEnabled = NO;
        [_imageGroupCollectionView registerNib:[UINib nibWithNibName:@"HomeNewsImageItemCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HomeNewsImageItemCellID"];
    }
    return _imageGroupCollectionView;
}

#pragma mark - delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择了哪个答案:%ld",indexPath.row);

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageGroupArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeNewsImageItemCell *colCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeNewsImageItemCellID" forIndexPath:indexPath];

    return colCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((KSCREENW-40)/3.0f,82);
}

//调节每个item的edgeInsets代理方法
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 16, 0, 16);
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
