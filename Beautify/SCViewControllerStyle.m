//
//  SCViewControllerConfig.m
//  Beautify
//
//  Created by Chris Grant on 06/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UIColor+HexColors.h"
#import "SCViewControllerStyle.h"

@implementation SCViewControllerStyle

+(SCViewControllerStyle*)defaultStyle {
    SCViewControllerStyle *style = [SCViewControllerStyle new];
    style.backgroundColor = [UIColor whiteColor];
    style.backgroundImage = nil;
    style.backgroundGradient = nil;
    return style;
}

@end