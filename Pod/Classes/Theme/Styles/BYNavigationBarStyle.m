//
//  BYNavigationBarStyle.m
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYNavigationBarStyle.h"
#import "BYPlatformVersionUtils.h"
#import "BYGradient.h"
#import "BYGradientStop.h"
#import "BYTextShadow.h"
#import "BYBackgroundImage.h"

@implementation BYNavigationBarStyle

+(BYNavigationBarStyle*)defaultStyle {
    BYNavigationBarStyle *style = [BYNavigationBarStyle new];
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        style.title = [BYText textWithFont:[BYFont fontWithName:@"HelveticaNeue-Medium" andSize:18.0f] color:[UIColor blackColor]];
    }
    else {
        BYFont *font = [BYFont fontWithName:[UIFont boldSystemFontOfSize:1].fontName andSize:0];
        style.title = [BYText textWithFont:font color:[UIColor whiteColor]];
        style.dropShadow = [BYDropShadow shadowWithColor:[UIColor colorWithWhite:0.5 alpha:0.2] andHeight:1.0f];
        
        BYGradient *g = [BYGradient gradientWithStops:@[[BYGradientStop stopWithColor:[UIColor whiteColor] at:0.0],
                                                        [BYGradientStop stopWithColor:[UIColor colorWithRed:207.0f/255 green:217.0f/255 blue:230.0f/255 alpha:1.0] at:0.02],
                                                        [BYGradientStop stopWithColor:[UIColor colorWithRed:190.0f/255 green:204.0f/255 blue:221.0f/255 alpha:1.0] at:0.05],
                                                        [BYGradientStop stopWithColor:[UIColor colorWithRed:88.0f/255 green:115.0f/255 blue:151.0f/255 alpha:1.0] at:0.98],
                                                        [BYGradientStop stopWithColor:[UIColor colorWithRed:63.0f/255 green:92.0f/255 blue:128.0f/255 alpha:1.0] at:1.0]]
                                             isRadial:NO
                                         radialOffset:CGSizeZero];
        style.backgroundGradient = g;
    }
    return style;
}

-(id)copyWithZone:(NSZone*)zone {
    BYNavigationBarStyle *copy = [super copyWithZone:zone];
    copy.tintColor = self.tintColor.copy;
    copy.backgroundColor = self.backgroundColor.copy;
    copy.backgroundImage = self.backgroundImage.copy;
    copy.backgroundGradient = self.backgroundGradient.copy;
    copy.title = self.title.copy;
    copy.titleShadow = self.titleShadow.copy;
    copy.dropShadow = self.dropShadow.copy;
    return copy;
}

@end