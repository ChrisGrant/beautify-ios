//
//  BYBarButtonStyle.m
//  Beautify
//
//  Created by Chris Grant on 10/09/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYBarButtonStyle.h"
#import "BYFont.h"
#import "BYVersionUtils.h"
#import "BYGradientStop.h"

@implementation BYBarButtonStyle

+(BYBarButtonStyle*)defaultCustomStyle {
    BYBarButtonStyle *style = [BYBarButtonStyle new];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        style.title = [[BYText alloc] initWithFont:[BYFont new] color:[UIColor colorWithRed:0 green:122.0f/255.0f blue:1.0f alpha:1.0f]];
        style.backgroundColor = [UIColor clearColor];
    }
    else {
        style.title = [[BYText alloc] initWithFont:[[BYFont alloc] initWithName:[UIFont boldSystemFontOfSize:1.0f].fontName] color:[UIColor whiteColor]];
        style.titleShadow = [BYTextShadow shadowWithOffset:CGSizeMake(0, -1) andColor:[UIColor blackColor]];
        style.border = [[BYBorder alloc] initWithColor:[UIColor blackColor] width:0.0f radius:5.0f];
        
        style.backgroundGradient = [[BYGradient alloc] initWithStops: @[[[BYGradientStop alloc] initWithColor:[UIColor colorWithWhite:1.0 alpha:0.3] at:0.0],
                                                                        [[BYGradientStop alloc] initWithColor:[UIColor colorWithWhite:0.0 alpha:0.3] at:0.5],
                                                                        [[BYGradientStop alloc] initWithColor:[UIColor colorWithWhite:0.0 alpha:0.3] at:0.95],
                                                                        [[BYGradientStop alloc] initWithColor:[UIColor colorWithWhite:0.9 alpha:0.9] at:1.0]]];
        style.backgroundColor = [UIColor blackColor];
        
        style.innerShadows = @[[[BYShadow alloc] initWithOffset:CGSizeMake(0, 1) radius:1.0f color:[UIColor colorWithWhite:0.0f alpha:0.9f]]];
    }
    return style;
}

@end