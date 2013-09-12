//
//  Font.m
//  Beautify
//
//  Created by Colin Eberhardt on 21/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCFont.h"
#import "SCFont_Private.h"

@implementation SCFont

-(id)init {
    return [self initWithName:[UIFont systemFontOfSize:1.0f].fontName];
}

-(id)initWithName:(NSString*)name {
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

-(UIFont*)createFont:(UIFont*)font {
    if (_size != 0.0 || font == nil) {
        return [UIFont fontWithName:self.name size:self.size];
    }
    return [UIFont fontWithName:self.name size:font.pointSize];
}

@end