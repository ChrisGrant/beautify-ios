//
//  BYTextShadow.m
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYTextShadow.h"

@implementation BYTextShadow

+(BYTextShadow*)shadowWithOffset:(CGSize)offset andColor:(UIColor*)color {
    BYTextShadow *shadow = [BYTextShadow new];
    
    shadow.offset = offset;
    shadow.color = color;
    
    return shadow;
}

@end