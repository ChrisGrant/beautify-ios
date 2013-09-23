//
//  Shadow.m
//  Beautify
//
//  Created by Chris Grant on 14/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYShadow.h"

@implementation BYShadow

-(id)initWithOffset:(CGSize)offset radius:(float)radius color:(UIColor*)color {
    if (self = [super init]) {
        _offset = offset;
        _radius = radius;
        _color = color;
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone {
    BYShadow *copy = [[BYShadow allocWithZone:zone] init];
    copy.offset = self.offset;
    copy.radius = self.radius;
    copy.color = self.color.copy;
    return copy;
}

@end