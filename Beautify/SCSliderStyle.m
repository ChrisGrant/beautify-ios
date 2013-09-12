//
//  SCSliderStyle.m
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UIColor+HexColors.h"
#import "SCSliderStyle.h"
#import "SCBorder.h"
#import "SCGradient.h"
#import "SCGradientStop.h"
#import "SCShadow.h"

#import "SCVersionUtils.h"

@implementation SCSliderStyle

+(SCSliderStyle*)defaultStyle {
    SCSliderStyle *style = [SCSliderStyle new];
    style.backgroundColor = [UIColor clearColor];
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        style.barBorder = [[SCBorder alloc] initWithColor:[UIColor clearColor] width:0 radius:3];
        style.minimumTrackColor = [UIColor colorWithRed:0 green:122.0f/255.0f blue:1.0f alpha:1.0f];
        style.maximumTrackColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        
        style.knobBorder = [[SCBorder alloc] initWithColor:[UIColor blackColor] width:0 radius:25];
        style.knobBackgroundColor = [UIColor whiteColor];
        style.knobOuterShadows = @[[[SCShadow alloc] initWithOffset:CGSizeMake(0, 2) radius:4.0 color:[UIColor colorWithWhite:0.0 alpha:0.5] isInset:NO]];
    }
    else {
        style.barBorder = [[SCBorder alloc] initWithColor:[UIColor clearColor] width:0 radius:5];
        
        style.minimumTrackColor = [UIColor colorWithRed:109.0f/255.0f green:163.0f/255.0f blue:237.0f/255.0f alpha:1.0f];
        style.maximumTrackColor = [UIColor whiteColor];
        style.barInnerShadows = @[[[SCShadow alloc] initWithOffset:CGSizeMake(0, 3) radius:6.0 color:[UIColor colorWithWhite:0.0 alpha:0.9] isInset:YES],
                                  [[SCShadow alloc] initWithOffset:CGSizeMake(0, 1) radius:1.0 color:[UIColor colorWithWhite:0 alpha:0.5f] isInset:YES],
                                  ];
        
        style.knobBorder = [[SCBorder alloc] initWithColor:[UIColor clearColor] width:0 radius:25];
        SCGradientStop *top1 = [[SCGradientStop alloc] initWithColor:[UIColor colorWithWhite:0.65f alpha:1.0f] at:0.0f];
        SCGradientStop *top2 = [[SCGradientStop alloc] initWithColor:[UIColor colorWithWhite:0.82f alpha:1.0f] at:0.5f];
        SCGradientStop *top3 = [[SCGradientStop alloc] initWithColor:[UIColor whiteColor] at:1.0f];
        style.knobBackgroundGradient = [[SCGradient alloc] initWithStops:@[top1, top2, top3]];
        style.knobOuterShadows = @[[[SCShadow alloc] initWithOffset:CGSizeMake(0, 1) radius:2.0 color:[UIColor colorWithWhite:0.0 alpha:0.8] isInset:NO]];
        style.knobInnerShadows = @[[[SCShadow alloc] initWithOffset:CGSizeMake(0, 1) radius:1.0 color:[UIColor whiteColor] isInset:YES]];
    }
    return style;
}

@end