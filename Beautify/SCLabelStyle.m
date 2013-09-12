//
//  LabelStyle.m
//  Beautify
//
//  Created by Adrian Conlin on 30/04/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCLabelStyle.h"

@implementation SCLabelStyle

+(SCLabelStyle*)defaultStyle {
    SCLabelStyle *style = [SCLabelStyle new];
    SCFont* textFont = [SCFont new];
    style.title = [[SCText alloc] initWithFont:textFont color:[UIColor blackColor]];
    style.titleShadow = nil;
    return style;
}

@end