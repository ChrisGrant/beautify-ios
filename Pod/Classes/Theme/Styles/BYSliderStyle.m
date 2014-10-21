//
//  BYSliderStyle.m
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "UIColor+HexColors.h"
#import "BYSliderStyle.h"
#import "BYBorder.h"
#import "BYGradient.h"
#import "BYGradientStop.h"
#import "BYShadow.h"
#import "BYPlatformVersionUtils.h"

@implementation BYSliderStyle

+(BYSliderStyle*)defaultStyle {
    BYSliderStyle *style = [BYSliderStyle new];
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        style.barHeightFraction = 0.05;
        style.barBorder = [BYBorder borderWithColor:[UIColor clearColor] width:0 radius:3];
        style.minimumTrackColor = [UIColor colorWithRed:0 green:122.0f/255.0f blue:1.0f alpha:1.0f];
        style.maximumTrackColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        
        style.thumbBorder = [BYBorder borderWithColor:[UIColor blackColor] width:0 radius:25];
        style.thumbBackgroundColor = [UIColor whiteColor];
        style.thumbOuterShadow = [BYShadow shadowWithOffset:CGSizeMake(0, 2) radius:4.0 color:[UIColor colorWithWhite:0.0 alpha:0.5]];
    }
    else {
        style.barHeightFraction = 0.33;
        style.barBorder = [BYBorder borderWithColor:[UIColor clearColor] width:0 radius:5];
        
        style.minimumTrackColor = [UIColor colorWithRed:109.0f/255.0f green:163.0f/255.0f blue:237.0f/255.0f alpha:1.0f];
        style.maximumTrackColor = [UIColor whiteColor];
        style.barInnerShadow = [BYShadow shadowWithOffset:CGSizeMake(0, 3) radius:6.0 color:[UIColor colorWithWhite:0.0 alpha:0.9]];
        
        style.thumbBorder = [BYBorder borderWithColor:[UIColor clearColor] width:0 radius:25];
        BYGradientStop *top1 = [BYGradientStop stopWithColor:[UIColor colorWithWhite:0.65f alpha:1.0f] at:0.0f];
        BYGradientStop *top2 = [BYGradientStop stopWithColor:[UIColor colorWithWhite:0.82f alpha:1.0f] at:0.5f];
        BYGradientStop *top3 = [BYGradientStop stopWithColor:[UIColor whiteColor] at:1.0f];
        style.thumbBackgroundGradient = [BYGradient gradientWithStops:@[top1, top2, top3]];
        style.thumbOuterShadow = [BYShadow shadowWithOffset:CGSizeMake(0, 1) radius:2.0 color:[UIColor colorWithWhite:0.0 alpha:0.8]];
        style.thumbInnerShadow = [BYShadow shadowWithOffset:CGSizeMake(0, 1) radius:1.0 color:[UIColor whiteColor]];
    }
    return style;
}

-(id)copyWithZone:(NSZone *)zone {
    BYSliderStyle *copy = [super copyWithZone:zone];
    
    copy.barBorder = self.barBorder.copy;
    copy.barInnerShadow = self.barInnerShadow.copy;
    copy.barOuterShadow = self.barOuterShadow.copy;
    copy.barHeightFraction = self.barHeightFraction;
    
    copy.minimumTrackColor = self.minimumTrackColor.copy;
    copy.minimumTrackImage = self.minimumTrackImage.copy;
    copy.minimumTrackBackgroundGradient = self.minimumTrackBackgroundGradient;
    
    copy.maximumTrackColor = self.maximumTrackColor.copy;
    copy.maximumTrackImage = self.maximumTrackImage.copy;
    copy.maximumTrackBackgroundGradient = self.maximumTrackBackgroundGradient;
    
    copy.thumbBorder = self.thumbBorder.copy;
    copy.thumbBackgroundColor = self.thumbBackgroundColor.copy;
    copy.thumbImage = self.thumbImage.copy;
    copy.thumbBackgroundGradient = self.thumbBackgroundGradient.copy;
    copy.thumbInnerShadow = self.thumbInnerShadow.copy;
    copy.thumbOuterShadow = self.thumbOuterShadow.copy;

    return copy;
}

@end