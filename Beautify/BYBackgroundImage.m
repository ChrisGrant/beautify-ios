//
//  BackgroundImage.m
//  Beautify
//
//  Created by Colin Eberhardt on 27/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYBackgroundImage.h"

@implementation BYBackgroundImage

-(id)copyWithZone:(NSZone *)zone {
    BYBackgroundImage *copy = [[BYBackgroundImage allocWithZone:zone] init];
    copy.image = self.image.copy;
    return copy;
}

@end