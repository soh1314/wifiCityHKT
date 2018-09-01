//
//  NSString+Additions.h
//  Additions
//
//  Created by Johnil on 13-6-15.
//  Copyright (c) 2013年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@interface NSString (Additions)

#pragma mark - 字符串操作方法
- (BOOL)isNilString;
- (NSUInteger) compareTo: (NSString*) comp;
- (NSUInteger) compareToIgnoreCase: (NSString*) comp;
- (bool) contains: (NSString*) substring;
- (bool) endsWith: (NSString*) substring;
- (bool) startsWith: (NSString*) substring;
- (NSUInteger) indexOf: (NSString*) substring;
- (NSUInteger) indexOf:(NSString *)substring startingFrom: (NSUInteger) index;
- (NSUInteger) lastIndexOf: (NSString*) substring;
- (NSUInteger) lastIndexOf:(NSString *)substring startingFrom: (NSUInteger) index;
- (NSString*) substringFromIndex:(NSUInteger)from toIndex: (NSUInteger) to;
- (NSString*) trim;
- (NSArray*) split: (NSString*) token;
- (NSString*) replace: (NSString*) target withString: (NSString*) replacement;
- (NSArray*) split: (NSString*) token limit: (NSUInteger) maxResults;

- (CGSize)sizeWithConstrainedToWidth:(float)width fromFont:(UIFont *)font1 lineSpace:(float)lineSpace;
- (CGSize)sizeWithConstrainedToSize:(CGSize)size fromFont:(UIFont *)font1 lineSpace:(float)lineSpace;
- (void)drawInContext:(CGContextRef)context withPosition:(CGPoint)p andFont:(UIFont *)font andTextColor:(UIColor *)color andHeight:(float)height andWidth:(float)width;
- (void)drawInContext:(CGContextRef)context withPosition:(CGPoint)p andFont:(UIFont *)font andTextColor:(UIColor *)color andHeight:(float)height;

//url 编码
- (NSString *)URLEncode;
- (NSString *)URLDecode;
- (NSString *)hanziURLEncode;
- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;
+ (NSString*)ObjectTojsonString:(id)object;

//富文本
- (NSMutableAttributedString *)priceStringsSetPriceColor:(UIColor *)pColor priceFont:(UIFont *)pfont fuhaoColor:(UIColor *)fhColor fuhaoFont:(UIFont *)fhFont;
- (NSMutableAttributedString *)setSubStringColor:(UIColor *)subStringColor subString:(NSString *)subString;
//协议字符串
- (NSString *)protocalHandle:(NSString *)origin;

//正则校验
+ (BOOL)checkRegularPhone:(NSString *)phone;
+(BOOL) isValidateMobile:(NSString *)mobile;

// 金钱数字处理
+ (NSString *)numberDecimal:(id)number;
// 昵称处理
- (NSString *)nickNameAddStart;
+ (NSString *)phoneAddStar:(NSString*)number;
// json字符串
+ (NSString*)dataToJsonString:(id)object;

//时间戳
- (NSString *)timeStringToDay:(NSString *)timeString;
+ (NSString *)currentTimeStr;
+ (NSString *)unixTimeStamp;
+ (NSString *)unixTimeStampMsecond;

@end
