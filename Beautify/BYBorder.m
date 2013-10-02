//
//  Border.m
//  Beautify
//
//  Created by Chris Grant on 14/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYBorder.h"

@implementation BYBorder

+(BYBorder*)borderWithColor:(UIColor*)color width:(float)width radius:(float)radius {
    BYBorder *border = [BYBorder new];
    border.color = color;
    border.width = width;
    border.cornerRadius = radius;
    return border;
}

-(id)copyWithZone:(NSZone *)zone {
    BYBorder *copy = [[BYBorder allocWithZone:zone] init];
    copy.color = self.color;
    copy.width = self.width;
    copy.cornerRadius = self.cornerRadius;
    return copy;
}

+(BOOL)propertyIsOptional:(NSString *)propertyName {
    return [propertyName.lowercaseString isEqualToString:@"cornerradius"];
}

@end