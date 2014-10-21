//
//  LabelStyle.m
//  Beautify
//
//  Created by Adrian Conlin on 30/04/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYLabelStyle.h"

@implementation BYLabelStyle

+(BYLabelStyle*)defaultStyle {
    BYLabelStyle *style = [BYLabelStyle new];
    BYFont* textFont = [BYFont new];
    style.title = [BYText textWithFont:textFont color:[UIColor blackColor]];
    style.titleShadow = nil;
    return style;
}

-(id)copyWithZone:(NSZone*)zone {
    BYLabelStyle *copy = [super copyWithZone:zone];
    copy.title = self.title.copy;
    copy.titleShadow = self.titleShadow.copy;
    return copy;
}

@end