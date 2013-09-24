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

-(id)copyWithZone:(NSZone *)zone {
    BYBorder *copy = [[BYBorder allocWithZone:zone] init];
    copy.color = self.color;
    copy.width = self.width;
    copy.cornerRadius = self.cornerRadius;
    return copy;
}

@end