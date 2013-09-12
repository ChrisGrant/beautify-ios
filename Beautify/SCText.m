//
//  SCText.m
//  Beautify
//
//  Created by Adrian Conlin on 23/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCText.h"
#import "SCFont.h"

@implementation SCText

-(id)initWithFont:(SCFont*)font color:(UIColor*)color {
    if (self = [super init]) {
        _font = font;
        _color = color;
    }
    return self;
}

@end