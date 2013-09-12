//
//  Shadow.m
//  Beautify
//
//  Created by Chris Grant on 14/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCShadow.h"

@implementation SCShadow

-(id)initWithOffset:(CGSize)offset radius:(float)radius color:(UIColor*)color isInset:(BOOL)inset {
    if (self = [super init]) {
        _offset = offset;
        _radius = radius;
        _color = color;
        _inset = inset;
    }
    return self;
}

@end