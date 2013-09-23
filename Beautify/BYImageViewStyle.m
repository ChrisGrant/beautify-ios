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
    copy.innerShadows = [self.innerShadows copyWithZone:zone];
    copy.outerShadows = [self.outerShadows copyWithZone:zone];
    return copy;
}

@end