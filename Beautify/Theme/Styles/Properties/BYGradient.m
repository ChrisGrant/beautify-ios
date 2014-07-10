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

+(BYGradient*)gradientWithStops:(NSArray *)stops {
    BYGradient *gradient = [BYGradient new];
    gradient.stops = stops;
    return gradient;
}

-(instancetype)initWithStops:(NSArray*)stops {
    if (self = [super init]) {
        _stops = stops;
        _radial = NO;
    }
    return self;
}

+(BYGradient*)gradientWithStops:(NSArray*)stops isRadial:(BOOL)isRadial radialOffset:(CGSize)radialOffset {
    BYGradient *gradient = [BYGradient new];
    gradient.stops = stops;
    gradient.radial = isRadial;
    gradient.radialOffset = radialOffset;
    return gradient;
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

+(BOOL)propertyIsOptional:(NSString *)propertyName {
    if([[propertyName lowercaseString] isEqualToString:@"radial"] ||
       [[propertyName lowercaseString] isEqualToString:@"radialoffset"]) {
        return YES;
    }
    return NO;
}

@end