//
//  Border.m
//  Beautify
//
//  Created by Chris Grant on 14/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYBorder.h"

@implementation BYBorder

-(id)initWithColor:(UIColor*)color width:(float)width radius:(float)radius {
    if (self = [super init]) {
        _color = color;
        _width = width;
        _cornerRadius = radius;
    }
    return self;
}

@end