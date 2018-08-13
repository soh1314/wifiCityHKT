//
//  WIFIInfo.m
//  WIFICity
//
//  Created by WifiProjectPC on 2018/6/15.
//  Copyright © 2018年 HKT. All rights reserved.
//

#import "WIFIInfo.h"

@implementation WIFIInfo


- (NSString *)hktMac {

    NSArray *macArray = [self.bsid componentsSeparatedByString:@":"];
    NSMutableString *macString = [NSMutableString string];
    for (int i = 0; i < macArray.count; i++) {
        NSString *str = macArray[i];
        if (i ==macArray.count -1) {
            NSInteger macValue = [self numberWithHexString:str];
            if (self.sid && ([self.sid containsString:@"5G"] || [self.sid containsString:@"5g"])) {
                macValue -= 2;
            } else {
                macValue -= 1;
            }
            NSString *str3 = [self getHexByDecimal:macValue];
            [macString appendString:str3];
        } else {
            if (str.length == 1) {
                NSString *str1 = [NSString stringWithFormat:@"%@",str];
                [macString appendString:str1];
            } else {
                [macString appendString:str];
            }
        }

    }
    _hktMac = [macString lowercaseString];
    return _hktMac;
}

- (NSString *)stringWithHexNumber:(NSUInteger)hexNumber{
    
    char hexChar[6];
    NSString *hexString = [NSString stringWithCString:hexChar encoding:NSUTF8StringEncoding];
    
    return hexString;
}

- (NSInteger)numberWithHexString:(NSString *)hexString{
    
    const char *hexChar = [hexString cStringUsingEncoding:NSUTF8StringEncoding];
    
    int hexNumber;
    
    sscanf(hexChar, "%x", &hexNumber);
    
    return (NSInteger)hexNumber;
}

- (NSString *)getHexByDecimal:(NSInteger)decimal {
    
    NSString *hex =@"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i<9; i++) {
        
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
                
            case 10:
                letter =@"A"; break;
            case 11:
                letter =@"B"; break;
            case 12:
                letter =@"C"; break;
            case 13:
                letter =@"D"; break;
            case 14:
                letter =@"E"; break;
            case 15:
                letter =@"F"; break;
            default:
                letter = [NSString stringWithFormat:@"%ld", number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {
            
            break;
        }
    }
    return hex;
}

@end
