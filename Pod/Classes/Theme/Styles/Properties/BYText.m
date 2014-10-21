//
//  BYText.m
//  Beautify
//
//  Created by Adrian Conlin on 23/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYText.h"
#import "BYFont.h"

@implementation BYText

+(BYText *)textWithFont:(BYFont *)font color:(UIColor *)color {
    BYText *text = [BYText new];
    text.font = font;
    text.color = color;
    return text;
}

-(id)copyWithZone:(NSZone *)zone {
    BYText *copy = [[BYText allocWithZone:zone] init];
    copy.font = self.font.copy;
    copy.color = self.color.copy;
    return copy;
}

@end