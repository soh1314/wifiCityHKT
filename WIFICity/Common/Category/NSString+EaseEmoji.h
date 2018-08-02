//
//  NSString+EaseEmoji.h
//  TRGFShop
//
//  Created by yangqing Liu on 2018/1/4.
//  Copyright © 2018年 trgf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EaseEmoji)

- (NSString *)stringByReplacingEmojiUnicodeWithCheatCodes;
- (NSString *)stringByReplacingEmojiCheatCodesWithUnicode;
@end
