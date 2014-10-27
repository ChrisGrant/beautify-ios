//
//  SwitchLayer.m
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYSwitchLayer.h"

@implementation BYSwitchLayer {
    BYSwitchRenderer* _renderer;
}

-(id)initWithRenderer:(BYSwitchRenderer *)renderer {
    if (self = [super init] ) {
        _renderer = renderer;
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

@end