//
//  ViewStyle.m
//  Beautify
//
//  Created by Adrian Conlin on 02/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYViewStyle.h"

@implementation BYViewStyle

-(id)init {
    if (self = [super init]) {
        self.alpha = 1.0;
    }
    return self;
}

-(id)copyWithZone:(NSZone*)zone {
    id copy = [[[self class] allocWithZone:zone] init];
    [copy setAlpha:self.alpha];
    return copy;
}

+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return [propertyName isEqualToString:@"alpha"];
}

@end