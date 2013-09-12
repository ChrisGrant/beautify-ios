//
//  SCTextShadow.m
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCTextShadow.h"

@implementation SCTextShadow

+(SCTextShadow*)shadowWithOffset:(CGSize)offset andColor:(UIColor*)color {
    SCTextShadow *shadow = [SCTextShadow new];
    
    shadow.offset = offset;
    shadow.color = color;
    
    return shadow;
}

@end