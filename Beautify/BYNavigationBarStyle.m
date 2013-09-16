//
//  BYNavigationBarStyle.m
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYNavigationBarStyle.h"
#import "BYVersionUtils.h"
#import "BYGradient.h"
#import "BYGradientStop.h"

@implementation BYNavigationBarStyle

+(BYNavigationBarStyle*)defaultStyle {
    BYNavigationBarStyle *style = [BYNavigationBarStyle new];
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        style.title = [[BYText alloc] initWithFont:[BYFont new] color:[UIColor blackColor]];
    }
    else {
        BYFont *font = [[BYFont alloc] initWithName:[UIFont boldSystemFontOfSize:1].fontName];
        style.title = [[BYText alloc] initWithFont:font color:[UIColor whiteColor]];
        style.dropShadow = [[BYDropShadow alloc] initWithColor:[UIColor colorWithWhite:0.5 alpha:0.2] andHeight:1.0f];
        
        BYGradient *g = [[BYGradient alloc] initWithStops:@[[[BYGradientStop alloc] initWithColor:[UIColor whiteColor] at:0.0],
                                                            [[BYGradientStop alloc] initWithColor:[UIColor colorWithRed:207.0f/255 green:217.0f/255 blue:230.0f/255 alpha:1.0] at:0.02],
                                                            [[BYGradientStop alloc] initWithColor:[UIColor colorWithRed:190.0f/255 green:204.0f/255 blue:221.0f/255 alpha:1.0] at:0.05],
                                                            [[BYGradientStop alloc] initWithColor:[UIColor colorWithRed:88.0f/255 green:115.0f/255 blue:151.0f/255 alpha:1.0] at:0.98],
                                                            [[BYGradientStop alloc] initWithColor:[UIColor colorWithRed:63.0f/255 green:92.0f/255 blue:128.0f/255 alpha:1.0] at:1.0]]];
        style.backgroundGradient = g;
    }
    return style;
}

@end