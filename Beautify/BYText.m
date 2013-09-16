//
//  BYText.m
//  Beautify
//
//  Created by Adrian Conlin on 23/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYText.h"
#import "BYFont.h"

@implementation BYText

-(id)initWithFont:(BYFont*)font color:(UIColor*)color {
    if (self = [super init]) {
        _font = font;
        _color = color;
    }
    return self;
}

@end