//
//  HomeNewsTwoCell.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/22.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "HomeNewsTwoCell.h"
#import "HomeNewsImageItemCell.h"
#import "GaoXinNewS.h"

@implementation HomeNewsTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initUI];
    self.imageGroupArray = [NSArray array];
}

- (void)initUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#111111"];
    self.agencyLabel.textColor = [UIColor colorWithHexString:@"#888888"];
    self.additionLabel.textColor = [UIColor colorWithHexString:@"#888888"];
    self.tabLabel.clipsToBounds = YES;
    self.tabLabel.layer.cornerRadius = 2;
    self.tabLabel.layer.borderWidth = 1.0f;
    self.tabLabel.layer.borderColor = [UIColor colorWithHexString:@"#F9595B"].CGColor;
    self.tabLabel.textColor = [UIColor colorWithHexString:@"#F9595B"];
    
    [self.imageGroupView addSubview:self.imageGroupCollectionView];
    CGFloat imageHeight = (KSCREENW-40)/3.0f*74/112.0f;
    [self.imageGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(imageHeight+16);
        
    }];
    [self.imageGroupCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.imageGroupView);
    }];
    self.imageGroupCollectionView.userInteractionEnabled = NO;
    
    
}

- (void)updateGaoXinNews:(GaoXinNewS *)news {
    self.titleLabel.text = [NSString stringWithFormat:@"%@",news.gxq_title];
    self.agencyLabel.text = [NSString stringWithFormat:@"%@",news.gxq_agency];
    if (news.gxq_create_date) {
        self.additionLabel.text = [NSString stringWithFormat:@"%@",news.gxq_create_date];
    } else {
        self.additionLabel.text = @"";
    }
    

}

- (void)updateHomeNews:(HomeNews *)news {
    self.titleLabel.text = [NSString stringWithFormat:@"%@",news.title];
    self.agencyLabel.text = [NSString stringWithFormat:@"%@",news.abstracts];

}


- (void)setNews:(HomeNews *)news {
    
    _news = news;
    BOOL isGaoxinNews = NO;
    if ([news isKindOfClass:[GaoXinNewS class]]) {
        [self updateGaoXinNews:(GaoXinNewS *)self.news];
        isGaoxinNews = YES;
    } else {
        [self updateHomeNews:news];
    }
    
    if (news.is_hot) {
        self.tabLabel.hidden = NO;
        self.tabLabel.text = @"热点";
        [self.tabLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(25.0f);
        }];
        [self.agencyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(self.tabLabel.mas_right).mas_offset(8.0).priorityHigh();
        }];
    } else {
        self.tabLabel.hidden = YES;
        [self.tabLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0.0f);
        }];
        [self.agencyLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(12);
            make.left.mas_equalTo(self.tabLabel.mas_right).mas_offset(0);
        }];
    }
}

- (void)setImageGroupArray:(NSArray *)imageGroupArray {
    _imageGroupArray = imageGroupArray;
    [self.imageGroupCollectionView reloadData];
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
        _imageGroupCollectionView.backgroundColor = [UIColor whiteColor];
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
    
    NSString *url = self.imageGroupArray[indexPath.row];
    if ([url hasPrefix:@"http:"]) {
        NSString *urlEncode = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [colCell.HomeNewsImageView sd_setImageWithURL:[NSURL URLWithString:urlEncode]];
    } else {
        NSString *urlEncode = [NSString stringWithFormat:@"%@/%@",kUrlHost,url];
        [colCell.HomeNewsImageView sd_setImageWithURL:[NSURL URLWithString:urlEncode]];
    }

    return colCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((KSCREENW-40)/3.0f,(KSCREENW-40)/3.0f*74/112);
}

//调节每个item的edgeInsets代理方法
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 16, 8, 16);
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
