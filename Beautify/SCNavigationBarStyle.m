//
//  SCNavigationBarStyle.m
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCNavigationBarStyle.h"
#import "SCVersionUtils.h"
#import "SCGradient.h"
#import "SCGradientStop.h"

@implementation SCNavigationBarStyle

+(SCNavigationBarStyle*)defaultStyle {
    SCNavigationBarStyle *style = [SCNavigationBarStyle new];
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        style.title = [[SCText alloc] initWithFont:[SCFont new] color:[UIColor blackColor]];
    }
    else {
        SCFont *font = [[SCFont alloc] initWithName:[UIFont boldSystemFontOfSize:1].fontName];
        style.title = [[SCText alloc] initWithFont:font color:[UIColor whiteColor]];
        style.dropShadow = [[SCDropShadow alloc] initWithColor:[UIColor colorWithWhite:0.5 alpha:0.2] andHeight:1.0f];
        
        SCGradient *g = [[SCGradient alloc] initWithStops:@[[[SCGradientStop alloc] initWithColor:[UIColor whiteColor] at:0.0],
                                                            [[SCGradientStop alloc] initWithColor:[UIColor colorWithRed:207.0f/255 green:217.0f/255 blue:230.0f/255 alpha:1.0] at:0.02],
                                                            [[SCGradientStop alloc] initWithColor:[UIColor colorWithRed:190.0f/255 green:204.0f/255 blue:221.0f/255 alpha:1.0] at:0.05],
                                                            [[SCGradientStop alloc] initWithColor:[UIColor colorWithRed:88.0f/255 green:115.0f/255 blue:151.0f/255 alpha:1.0] at:0.98],
                                                            [[SCGradientStop alloc] initWithColor:[UIColor colorWithRed:63.0f/255 green:92.0f/255 blue:128.0f/255 alpha:1.0] at:1.0]]];
        style.backgroundGradient = g;
    }
    return style;
}

@end