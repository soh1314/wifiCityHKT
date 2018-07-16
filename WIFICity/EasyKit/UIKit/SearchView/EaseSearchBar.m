//
//  EaseSearchBar.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/6.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "EaseSearchBar.h"


@implementation EaseSearchBar

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.searchTtf];
    [self addSubview:self.searchIcon];
    self.searchTtf.borderStyle = UITextBorderStyleNone;
    if (self.textfieldPlaceHolderName) {
        self.searchTtf.placeholder = [self.textfieldPlaceHolderName copy];
    }
    self.searchTtf.font = [UIFont systemFontOfSize:13];
    self.searchTtf.userInteractionEnabled = NO;
    self.searchTtf.returnKeyType = UIReturnKeySearch;
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 6;
    self.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    self.frame = CGRectMake(0, 0, 278/375.0f*KSCREENW, 36);
    self.searchIcon.image = [UIImage qsImageNamed:@"search"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    [self masLayout];
    
}

- (void)setTextfieldPlaceHolderName:(NSString *)textfieldPlaceHolderName {
    _textfieldPlaceHolderName = textfieldPlaceHolderName;
    self.searchTtf.placeholder = [_textfieldPlaceHolderName copy];
}

- (void)masLayout {
    
    [self.searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(16);
        make.width.height.mas_equalTo(16);
        
    }];
    
    [self.searchTtf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchIcon.mas_right).mas_offset(12);
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self).mas_offset(-10);
    }];
    
}

- (void)tap:(UITapGestureRecognizer *)tap {
    if (self.actionblock) {
        self.actionblock();

    }
    
}

- (void)invokeSearch {
   [self.searchTtf becomeFirstResponder];
}

- (void)cancleSearch {
     self.searchTtf.text = @"";
    [self.searchTtf resignFirstResponder];
}

#pragma mark -- get

- (UIImageView *)searchIcon {
    if (!_searchIcon) {
        _searchIcon = [UIImageView  new];
    }
    return _searchIcon;
}

- (UITextField *)searchTtf {
    if (!_searchTtf) {
        _searchTtf = [UITextField new];
    }
    return _searchTtf;
}

@end
