//
//  Gradient.m
//  Beautify
//
//  Created by Chris Grant on 20/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCGradient.h"
#import "SCGradientStop.h"

@implementation SCGradient

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
    for (SCGradientStop* stop in self.stops) {
        [str appendString:@", "];
        [str appendString:stop.description];
    }
    return str;
}

@end