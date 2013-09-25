//
//  GradientStop.m
//  Beautify
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYGradientStop.h"
#import "UIColor+HexColors.h"

@implementation BYGradientStop

+(BYGradientStop*)stopWithColor:(UIColor*)color at:(float)stopLocation {
    BYGradientStop *stop = [BYGradientStop new];
    stop.color = color;
    stop.stop = stopLocation;
    return stop;
}

-(id)copyWithZone:(NSZone *)zone {
    BYGradientStop *copy = [[BYGradientStop allocWithZone:zone] init];
    copy.color = self.color.copy;
    copy.stop = self.stop;
    return copy;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"(%@, %f)", self.color, self.stop];
}

@end