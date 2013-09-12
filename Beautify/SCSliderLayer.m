//
//  SCSliderLayer.m
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCSliderLayer.h"

@implementation SCSliderLayer {
    SCSliderRenderer* _renderer;
}

-(id)initWithRenderer:(SCSliderRenderer *)renderer {
    if (self = [super init] ) {
        _renderer = renderer;
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

@end
