//
//  BYDropShadow.m
//  Beautify
//
//  Created by Daniel Allsop on 24/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYDropShadow.h"

@implementation BYDropShadow

+(BYDropShadow *)shadowWithColor:(UIColor *)color andHeight:(float)height {
    BYDropShadow *shadow = [BYDropShadow new];
    shadow.color = color;
    shadow.height = height;
    return shadow;
}

-(id)copyWithZone:(NSZone *)zone {
    BYDropShadow *copy = [[BYDropShadow allocWithZone:zone] init];
    copy.color = self.color.copy;
    copy.height = self.height;
    return copy;
}

@end