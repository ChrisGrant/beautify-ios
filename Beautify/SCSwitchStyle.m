//
//  SwitchConfig.m
//  Beautify
//
//  Created by Chris Grant on 27/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UIColor+HexColors.h"
#import "SCSwitchStyle.h"
#import "SCBorder.h"
#import "SCGradient.h"
#import "SCGradientStop.h"
#import "SCShadow.h"
#import "SCVersionUtils.h"

@implementation SCSwitchStyle

+(SCSwitchStyle*)defaultStyle {
    SCSwitchStyle *style = [SCSwitchStyle new];
    
    SCSwitchState *onState = [SCSwitchState new];
    style.onState = onState;
    SCSwitchState *offState = [SCSwitchState new];
    style.offState = offState;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        style.border = [[SCBorder alloc] initWithColor:[UIColor colorWithWhite:0.88 alpha:1.0] width:2 radius:25];
        
        onState.text = @"";
        onState.backgroundColor = [UIColor colorWithRed:75.0f/255.0f green:216.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
        offState.text = @"";
        offState.backgroundColor = [UIColor clearColor];
        
        style.knobBackgroundColor = [UIColor whiteColor];
        style.knobBorder = [[SCBorder alloc] initWithColor:[UIColor clearColor] width:0 radius:15];
        style.knobOuterShadows = @[[[SCShadow alloc] initWithOffset:CGSizeMake(0, 0) radius:3 color:[UIColor colorWithWhite:0.0 alpha:0.5] isInset:NO]];
    }
    else {
        style.border = [[SCBorder alloc] initWithColor:[UIColor clearColor] width:0 radius:15];
        
        style.highlightColor = [UIColor colorWithWhite:1.0 alpha:0.25];
        
        SCFont *font = [[SCFont alloc] initWithName:[UIFont boldSystemFontOfSize:1].fontName];
        onState.textStyle = [[SCText alloc] initWithFont:font color:[UIColor whiteColor]];
        onState.textShadow = [SCTextShadow shadowWithOffset:CGSizeMake(0, -1) andColor:[UIColor colorWithRed:0 green:108.0f/255.0f blue:175.0f/255.0f alpha:1.0f]];
        onState.text = @"ON";
        onState.backgroundColor = [UIColor colorWithRed:0 green:127.0f/255.0f blue:234.0f/255.0f alpha:1.0f];
        
        offState.textStyle = [[SCText alloc] initWithFont:font color:[UIColor colorWithWhite:0.47f alpha:1.0f]];
        offState.text = @"OFF";
        offState.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1.0f];
        
        style.innerShadows = @[[[SCShadow alloc] initWithOffset:CGSizeMake(0, 0) radius:4 color:[UIColor blackColor] isInset:YES]];
        
        style.knobBackgroundGradient = [[SCGradient alloc] initWithStops:@[[[SCGradientStop alloc] initWithColor:[UIColor colorWithWhite:0.78 alpha:1.0] at:0.0],
                                                                           [[SCGradientStop alloc] initWithColor:[UIColor colorWithWhite:0.9 alpha:1.0] at:1.0]]];
        style.knobInnerShadows = @[[[SCShadow alloc] initWithOffset:CGSizeMake(0, 0) radius:2.0 color:[UIColor whiteColor] isInset:YES]];
        style.knobBorder = [[SCBorder alloc] initWithColor:[UIColor colorWithWhite:0.5 alpha:1.0] width:1 radius:15];
        style.knobOuterShadows = @[[[SCShadow alloc] initWithOffset:CGSizeMake(0, 0) radius:3 color:[UIColor colorWithWhite:0.0 alpha:0.5] isInset:NO]];
    }
    return style;
}

@end