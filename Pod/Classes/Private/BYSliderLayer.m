//
//  BYSliderLayer.m
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYSliderLayer.h"

@implementation BYSliderLayer {
    BYSliderRenderer* _renderer;
}

-(id)initWithRenderer:(BYSliderRenderer *)renderer {
    if (self = [super init] ) {
        _renderer = renderer;
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

@end
