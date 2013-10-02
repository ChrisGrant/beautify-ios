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

-(instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    id style = [super initWithDictionary:dict error:err];
    // Alpha defaults to 0. So check to see if it is present. If not, set it to 1.
    if(![dict.allKeys containsObject:@"alpha"]) {
        ((BYViewStyle*)style).alpha = 1.0;
    }
    return style;
}

-(id)copyWithZone:(NSZone*)zone {
    id copy = [[[self class] allocWithZone:zone] init];
    [copy setAlpha:self.alpha];
    return copy;
}

+(BOOL)propertyIsOptional:(NSString *)propertyName {
     // Alpha is optional. But we must default to 1. See above custom initWithDictionary constructor.
    return [[propertyName lowercaseString] isEqualToString:@"alpha"];
}

@end