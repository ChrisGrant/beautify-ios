//
//  UIColor+Comparison.m
//  Beautify
//
//  Created by Chris Grant on 13/09/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "UIColor+Comparison.h"
#import "UIColor+HexColors.h"

@implementation UIColor (Comparison)

-(BOOL)isEqualToColor:(UIColor*)otherColor {
    NSString *selfColorString = [UIColor hexValuesFromUIColor:self];
    NSString *otherColorString = [UIColor hexValuesFromUIColor:otherColor];
    
    return [selfColorString isEqualToString:otherColorString];
}

@end