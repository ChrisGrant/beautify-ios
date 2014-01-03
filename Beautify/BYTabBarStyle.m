//
//  BYTabBarStyle.m
//  Beautify
//
//  Created by CG on 24/11/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "BYTabBarStyle.h"

@implementation BYTabBarStyle

+(BYTabBarStyle*)defaultStyle {
    BYTabBarStyle *barStyle = [BYTabBarStyle new];
    barStyle.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
    barStyle.tintColor = [UIColor colorWithRed:0.3 green:0.3 blue:1.0 alpha:1.0];
    barStyle.border = [BYBorder borderWithColor:[UIColor colorWithWhite:0.4 alpha:1.0] width:0.5 radius:0];
    return barStyle;
}

-(id)copyWithZone:(NSZone*)zone {
    BYTabBarStyle *copy = [super copyWithZone:zone];
    copy.tintColor = self.tintColor.copy;
    copy.imageTintColor = self.imageTintColor.copy;
    copy.backgroundColor = self.backgroundColor.copy;
    copy.backgroundImage = self.backgroundImage.copy;
    copy.backgroundGradient = self.backgroundGradient.copy;
    copy.border = self.border.copy;
    copy.innerShadow = self.innerShadow.copy;
    copy.outerShadow = self.outerShadow.copy;
    return copy;
}

@end