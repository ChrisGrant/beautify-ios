//
//  ButtonStyle.m
//  Beautify
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCButtonStyle.h"
#import "SCBorder.h"
#import "SCFont.h"
#import "UIColor+HexColors.h"

@implementation SCButtonStyle

+(SCButtonStyle*)defaultStyle {
    SCButtonStyle *style = [SCButtonStyle new];
    style.title = [[SCText alloc] initWithFont:[SCFont new] color:[UIColor whiteColor]];
    style.backgroundColor = [UIColor clearColor];
    return style;
}

@end