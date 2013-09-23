//
//  Gradient.m
//  Beautify
//
//  Created by Chris Grant on 20/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYGradient.h"
#import "BYGradientStop.h"

@implementation BYGradient

-(id)initWithStops:(NSArray*)stops {
    if (self = [super init]) {
        _stops = stops;
        _radial = NO;
    }
    return self;
}

-(id)initWithStops:(NSArray*)stops isRadial:(BOOL)isRadial radialOffset:(CGSize)radialOffset {
    if (self = [self initWithStops:stops]) {
        _radial = isRadial;
        _radialOffset = radialOffset;
    }
    return self;
}

-(NSString *)description {
    NSMutableString* str = [NSMutableString new];
    for (BYGradientStop* stop in self.stops) {
        [str appendString:@", "];
        [str appendString:stop.description];
    }
    return str;
}

-(id)copyWithZone:(NSZone*)zone {
    BYGradient *gradient = [[BYGradient allocWithZone:zone] init];
    gradient.radial = self.radial;
    gradient.radialOffset = self.radialOffset;
    gradient.stops = self.stops.copy;
    return gradient;
}

@end