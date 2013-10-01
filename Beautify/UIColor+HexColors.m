//
//  UIColor+HexColors.m
//  KiwiHarness
//
//  Created by Tim on 07/09/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "UIColor+HexColors.h"

@implementation UIColor (HexColors)

+(UIColor *)colorWithHexString:(NSString *)hexString {

    if(![hexString isKindOfClass:[NSString class]]) {
        NSLog(@"Value '%@' was not a string!", hexString);
        return nil;
    }
    
    if ([hexString isEqualToString:@"nil"]){
        return nil;
    }
    
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    if ([hexString length] != 6 &&  [hexString length] != 8) {
        return nil;
    }
    
    // Brutal and not-very elegant test for non hex-numeric characters
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-fA-F|0-9]" options:0 error:NULL];
    NSUInteger match = [regex numberOfMatchesInString:hexString options:NSMatchingReportCompletion range:NSMakeRange(0, [hexString length])];
    
    if (match != 0) {
        return nil;
    }
    
    NSRange rRange = NSMakeRange(0, 2);
    NSString *rComponent = [hexString substringWithRange:rRange];
    NSUInteger rVal = 0;
    NSScanner *rScanner = [NSScanner scannerWithString:rComponent];
    [rScanner scanHexInt:&rVal];
    float rRetVal = (float)rVal / 255;

    NSRange gRange = NSMakeRange(2, 2);
    NSString *gComponent = [hexString substringWithRange:gRange];
    NSUInteger gVal = 0;
    NSScanner *gScanner = [NSScanner scannerWithString:gComponent];
    [gScanner scanHexInt:&gVal];
    float gRetVal = (float)gVal / 255;

    NSRange bRange = NSMakeRange(4, 2);
    NSString *bComponent = [hexString substringWithRange:bRange];
    NSUInteger bVal = 0;
    NSScanner *bScanner = [NSScanner scannerWithString:bComponent];
    [bScanner scanHexInt:&bVal];
    float bRetVal = (float)bVal / 255;
    
    float alpha = 1.0f;
    if ([hexString length] == 8)
    {
        NSRange fRange = NSMakeRange(6, 2);
        NSString *fComponent = [hexString substringWithRange:fRange];
        NSUInteger fVal = 0;
        NSScanner *fScanner = [NSScanner scannerWithString:fComponent];
        [fScanner scanHexInt:&fVal];
        alpha = (float)fVal / 255;
    }
    return [UIColor colorWithRed:rRetVal green:gRetVal blue:bRetVal alpha:alpha];
}

+(NSString *)hexValuesFromUIColor:(UIColor *)color {
    if (!color) {
        return nil;
    }
    
    if (color == [UIColor whiteColor]) {
        // Special case, as white doesn't fall into the RGB color space
        return @"ffffff";
    }
 
    CGFloat red;
    CGFloat blue;
    CGFloat green;
    CGFloat alpha;
    
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    int redDec = (int)(red * 255);
    int greenDec = (int)(green * 255);
    int blueDec = (int)(blue * 255);
    
    NSString *returnString = [NSString stringWithFormat:@"%02x%02x%02x", (unsigned int)redDec, (unsigned int)greenDec, (unsigned int)blueDec];

    return returnString;
    
}

@end