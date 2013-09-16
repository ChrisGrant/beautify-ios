//
//  LabelStyle.m
//  Beautify
//
//  Created by Adrian Conlin on 30/04/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYLabelStyle.h"

@implementation BYLabelStyle

+(BYLabelStyle*)defaultStyle {
    BYLabelStyle *style = [BYLabelStyle new];
    BYFont* textFont = [BYFont new];
    style.title = [[BYText alloc] initWithFont:textFont color:[UIColor blackColor]];
    style.titleShadow = nil;
    return style;
}

@end