//
//  BYImageViewStyle.m
//  Beautify
//
//  Created by Chris Grant on 18/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYImageViewStyle.h"
#import "BYBorder.h"

@implementation BYImageViewStyle

+(BYImageViewStyle*)defaultStyle {
    return [BYImageViewStyle new];
}

-(id)copyWithZone:(NSZone *)zone {
    BYImageViewStyle *copy = [super copyWithZone:zone];
    copy.border = self.border.copy;
    copy.innerShadow = [self.innerShadow copyWithZone:zone];
    copy.outerShadow = [self.outerShadow copyWithZone:zone];
    return copy;
}

@end