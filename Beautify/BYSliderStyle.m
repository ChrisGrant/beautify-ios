//
//  BYSliderStyle.m
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UIColor+HexColors.h"
#import "BYSliderStyle.h"
#import "BYBorder.h"
#import "BYGradient.h"
#import "BYGradientStop.h"
#import "BYShadow.h"

#import "BYVersionUtils.h"

@implementation BYSliderStyle

+(BYSliderStyle*)defaultStyle {
    BYSliderStyle *style = [BYSliderStyle new];
    style.backgroundColor = [UIColor clearColor];
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        style.barBorder = [[BYBorder alloc] initWithColor:[UIColor clearColor] width:0 radius:3];
        style.minimumTrackColor = [UIColor colorWithRed:0 green:122.0f/255.0f blue:1.0f alpha:1.0f];
        style.maximumTrackColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        
        style.thumbBorder = [[BYBorder alloc] initWithColor:[UIColor blackColor] width:0 radius:25];
        style.thumbBackgroundColor = [UIColor whiteColor];
        style.thumbOuterShadows = @[[[BYShadow alloc] initWithOffset:CGSizeMake(0, 2) radius:4.0 color:[UIColor colorWithWhite:0.0 alpha:0.5]]];
    }
    else {
        style.barBorder = [[BYBorder alloc] initWithColor:[UIColor clearColor] width:0 radius:5];
        
        style.minimumTrackColor = [UIColor colorWithRed:109.0f/255.0f green:163.0f/255.0f blue:237.0f/255.0f alpha:1.0f];
        style.maximumTrackColor = [UIColor whiteColor];
        style.barInnerShadows = @[[[BYShadow alloc] initWithOffset:CGSizeMake(0, 3) radius:6.0 color:[UIColor colorWithWhite:0.0 alpha:0.9]],
                                  [[BYShadow alloc] initWithOffset:CGSizeMake(0, 1) radius:1.0 color:[UIColor colorWithWhite:0 alpha:0.5f]],
                                  ];
        
        style.thumbBorder = [[BYBorder alloc] initWithColor:[UIColor clearColor] width:0 radius:25];
        BYGradientStop *top1 = [[BYGradientStop alloc] initWithColor:[UIColor colorWithWhite:0.65f alpha:1.0f] at:0.0f];
        BYGradientStop *top2 = [[BYGradientStop alloc] initWithColor:[UIColor colorWithWhite:0.82f alpha:1.0f] at:0.5f];
        BYGradientStop *top3 = [[BYGradientStop alloc] initWithColor:[UIColor whiteColor] at:1.0f];
        style.thumbBackgroundGradient = [[BYGradient alloc] initWithStops:@[top1, top2, top3]];
        style.thumbOuterShadows = @[[[BYShadow alloc] initWithOffset:CGSizeMake(0, 1) radius:2.0 color:[UIColor colorWithWhite:0.0 alpha:0.8]]];
        style.thumbInnerShadows = @[[[BYShadow alloc] initWithOffset:CGSizeMake(0, 1) radius:1.0 color:[UIColor whiteColor]]];
    }
    return style;
}

@end