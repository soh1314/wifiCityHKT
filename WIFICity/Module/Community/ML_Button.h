//
//  ML_Button.h
//  ML_Button
//
//  Created by Mac mini on 2017/3/13.
//  Copyright © 2017年 MaLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    // 正常
    MLAlignmentStatusNormal,
    // 图标和文本位置变化
    MLAlignmentStatusLeft,// 左对齐
    MLAlignmentStatusCenter,// 居中对齐
    MLAlignmentStatusRight,// 右对齐
    MLAlignmentStatusTop,// 图标在上，文本在下(居中)
    MLAlignmentStatusBottom, // 图标在下，文本在上(居中)
}MLAlignmentStatus;

@interface ML_Button : UIButton

@property (nonatomic,assign)MLAlignmentStatus status;

+ (instancetype)ml_shareButton;

@property (nonatomic, assign) BOOL ml_imageAligmentLeft; // 设置图片居前  注: 默认文字在前 图片在后

@end
