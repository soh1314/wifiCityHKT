//
//  CompanyDetailCommentCell.h
//  WIFICity
//
//  Created by WifiProjectPC on 2018/7/24.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WIComment.h"
#import "IEnterPrise.h"
#import "WIButton.h"
@interface CompanyDetailCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avartar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic,strong)WIComment *comment;
@property (nonatomic,strong)IEnterPrise *dispatch;
@property (weak, nonatomic) IBOutlet WIButton *likeBtn;
- (IBAction)likeComment:(id)sender;


@end
