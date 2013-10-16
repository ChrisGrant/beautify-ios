//
//  SwitchConfig.m
//  Beautify
//
//  Created by Chris Grant on 27/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UIColor+HexColors.h"
#import "BYSwitchStyle.h"
#import "BYBorder.h"
#import "BYGradient.h"
#import "BYGradientStop.h"
#import "BYShadow.h"
#import "BYVersionUtils.h"

@implementation BYSwitchStyle

+(BYSwitchStyle*)defaultStyle {
    BYSwitchStyle *style = [BYSwitchStyle new];
    
    BYSwitchState *onState = [BYSwitchState new];
    style.onState = onState;
    BYSwitchState *offState = [BYSwitchState new];
    style.offState = offState;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        style.border = [BYBorder borderWithColor:[UIColor clearColor] width:1.5 radius:20];
        
        style.thumbInset = 1.5;
        style.border = [BYBorder borderWithColor:[UIColor colorWithWhite:0.88 alpha:1.0] width:2 radius:25];
        
        onState.backgroundColor = [UIColor colorWithRed:75.0f/255.0f green:216.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
        onState.borderColor = [UIColor colorWithRed:75.0f/255.0f green:216.0f/255.0f blue:99.0f/255.0f alpha:1.0f];
        
        offState.backgroundColor = [UIColor clearColor];
        offState.borderColor = [UIColor colorWithWhite:0.88f alpha:1.0f];
        
        style.thumbBackgroundColor = [UIColor whiteColor];
        style.thumbBorder = [BYBorder borderWithColor:[UIColor clearColor] width:0 radius:15];
        style.thumbOuterShadow = [BYShadow shadowWithOffset:CGSizeMake(0, 2) radius:5 color:[UIColor colorWithWhite:0.0 alpha:0.6]];
        style.thumbBorder = [BYBorder borderWithColor:[UIColor clearColor] width:0 radius:15];
        style.thumbOuterShadow = [BYShadow shadowWithOffset:CGSizeMake(0, 0) radius:3 color:[UIColor colorWithWhite:0.0 alpha:0.5]];
    }
    else {
        style.border = [BYBorder borderWithColor:[UIColor clearColor] width:0 radius:15];
        
        style.highlightColor = [UIColor colorWithWhite:1.0 alpha:0.25];
        
        BYFont *font = [BYFont fontWithName:[UIFont boldSystemFontOfSize:1].fontName];
        onState.textStyle = [BYText textWithFont:font color:[UIColor whiteColor]];
        onState.textShadow = [BYTextShadow shadowWithOffset:CGSizeMake(0, -1) andColor:[UIColor colorWithRed:0 green:108.0f/255.0f blue:175.0f/255.0f alpha:1.0f]];
        onState.text = @"ON";
        onState.backgroundColor = [UIColor colorWithRed:0 green:127.0f/255.0f blue:234.0f/255.0f alpha:1.0f];
        
        offState.textStyle = [BYText textWithFont:font color:[UIColor colorWithWhite:0.47f alpha:1.0f]];
        offState.text = @"OFF";
        offState.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1.0f];
        
        style.innerShadow = [BYShadow shadowWithOffset:CGSizeMake(0, 0) radius:4 color:[UIColor blackColor]];
        
        style.thumbBackgroundGradient = [BYGradient gradientWithStops:@[[BYGradientStop stopWithColor:[UIColor colorWithWhite:0.78 alpha:1.0] at:0.0],
                                                                           [BYGradientStop stopWithColor:[UIColor colorWithWhite:0.9 alpha:1.0] at:1.0]] isRadial:NO radialOffset:CGSizeZero];
        style.thumbInnerShadow = [BYShadow shadowWithOffset:CGSizeMake(0, 0) radius:2.0 color:[UIColor whiteColor]];
        style.thumbBorder = [BYBorder borderWithColor:[UIColor colorWithWhite:0.5 alpha:1.0] width:1 radius:15];
        style.thumbOuterShadow = [BYShadow shadowWithOffset:CGSizeMake(0, 0) radius:3 color:[UIColor colorWithWhite:0.0 alpha:0.5]];
    }
    return style;
}

-(id)copyWithZone:(NSZone *)zone {
    BYSwitchStyle *copy = [super copyWithZone:zone];
    
    copy.onState = self.onState.copy;
    copy.offState = self.offState.copy;
    
    copy.highlightColor = self.highlightColor.copy;
    
    copy.border = self.border.copy;
    copy.innerShadow = self.innerShadow.copy;
    copy.outerShadow = self.outerShadow.copy;
    
    copy.thumbBorder = self.thumbBorder.copy;
    copy.thumbBackgroundColor = self.thumbBackgroundColor.copy;
    copy.thumbImage = self.thumbImage.copy;
    copy.thumbBackgroundGradient = self.thumbBackgroundGradient.copy;
    copy.thumbInnerShadow = self.thumbInnerShadow.copy;
    copy.thumbOuterShadow = self.thumbOuterShadow.copy;
    copy.thumbInset = self.thumbInset;
    
    copy.trackLayerImage = self.trackLayerImage.copy;
    copy.borderLayerImage = self.borderLayerImage.copy;
    
    return copy;
}

+(BOOL)propertyIsOptional:(NSString *)propertyName {
    if([propertyName isEqualToString:@"thumbInset"])
        return YES;

    return [super propertyIsOptional:propertyName];
}

@end