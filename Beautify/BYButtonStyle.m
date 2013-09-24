//
//  ButtonStyle.m
//  Beautify
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYButtonStyle.h"
#import "BYBorder.h"
#import "BYFont.h"
#import "UIColor+HexColors.h"
#import "BYVersionUtils.h"
#import "BYStateSetter.h"
#import "BYGradientStop.h"

@implementation BYButtonStyle

+(BYButtonStyle*)defaultCustomStyle {
    BYButtonStyle *style = [BYButtonStyle new];
    style.title = [[BYText alloc] initWithFont:[BYFont new] color:[UIColor whiteColor]];
    style.backgroundColor = [UIColor clearColor];
    return style;
}

+(BYButtonStyle*)defaultSystemStyle {
    BYButtonStyle *style = [BYButtonStyle new];

    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        style.title = [[BYText alloc] initWithFont:[BYFont new] color:[UIColor colorWithRed:0 green:122.0f/255.0f blue:1.0f alpha:1.0f]];
        style.backgroundColor = [UIColor clearColor];
    }
    else {
        style.title = [[BYText alloc] initWithFont:[[BYFont alloc] initWithName:@"Helvetica-Bold" andSize:15.0f]
                                             color:[UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f]];
        style.backgroundColor = [UIColor whiteColor];
        style.border = [[BYBorder alloc] initWithColor:[UIColor colorWithWhite:0.67f alpha:1.0] width:2.0f radius:8];
        style.outerShadows = @[[[BYShadow alloc] initWithOffset:CGSizeMake(0, 1) radius:1.0f color:[UIColor whiteColor]]];
        style.innerShadows = @[[[BYShadow alloc] initWithOffset:CGSizeMake(0, 1) radius:1.0 color:[UIColor colorWithWhite:0.6 alpha:0.6]]];
        
        BYStateSetter *highlightedBGSetter = [BYStateSetter new];
        highlightedBGSetter.propertyName = @"backgroundGradient";
        highlightedBGSetter.state = UIControlStateHighlighted;
        BYGradientStop *stop1 = [[BYGradientStop alloc] initWithColor:[UIColor colorWithRed:1.0f/255.0f green:93.0f/255.0f blue:230.0f/255.0f alpha:1.0f] at:1.0];
        BYGradientStop *stop2 = [[BYGradientStop alloc] initWithColor:[UIColor colorWithRed:5.0f/255.0f green:139.0f/255.0f blue:245.0f/255.0f alpha:1.0f] at:0.0];
        highlightedBGSetter.value = [[BYGradient alloc] initWithStops:@[stop1, stop2]];
        
        BYStateSetter *highlightTextColorSetter = [BYStateSetter new];
        highlightTextColorSetter.propertyName = @"title";
        highlightTextColorSetter.state = UIControlStateHighlighted;
        highlightTextColorSetter.value = [[BYText alloc] initWithFont:[[BYFont alloc] initWithName:@"Helvetica-Bold" andSize:15.0f]
                                                               color:[UIColor whiteColor]];
        style.stateSetters = @[highlightTextColorSetter, highlightedBGSetter];
    }
    return style;
}

-(id)copyWithZone:(NSZone*)zone {
    id copy = [super copyWithZone:zone];
    [copy setTitle:self.title.copy];
    [copy setTitleShadow:self.titleShadow.copy];
    [copy setBackgroundColor:self.backgroundColor.copy];
    [copy setBackgroundGradient:self.backgroundGradient.copy];
    [copy setBackgroundImage:self.backgroundImage.copy];
    [copy setBorder:self.border.copy];
    [copy setInnerShadows:self.innerShadows.copy];
    [copy setOuterShadows:self.outerShadows.copy];
    [copy setStateSetters:self.stateSetters.copy];
    return copy;
}

@end