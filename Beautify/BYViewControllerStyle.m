//
//  BYViewControllerConfig.m
//  Beautify
//
//  Created by Chris Grant on 06/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UIColor+HexColors.h"
#import "BYViewControllerStyle.h"

@implementation BYViewControllerStyle

+(BYViewControllerStyle*)defaultStyle {
    BYViewControllerStyle *style = [BYViewControllerStyle new];
    style.backgroundColor = [UIColor whiteColor];
    style.backgroundImage = nil;
    style.backgroundGradient = nil;
    return style;
}

-(id)copyWithZone:(NSZone *)zone {
    BYViewControllerStyle *copy = [[BYViewControllerStyle allocWithZone:zone] init];
    copy.backgroundColor = self.backgroundColor.copy;
    copy.backgroundGradient = self.backgroundGradient.copy;
    copy.backgroundImage = self.backgroundImage.copy;
    return copy;
}

@end