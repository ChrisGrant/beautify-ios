//
//  SwitchLayer.m
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCSwitchLayer.h"

@implementation SCSwitchLayer {
    SCSwitchRenderer* _renderer;
}

-(id)initWithRenderer:(SCSwitchRenderer *)renderer {
    if (self = [super init] ) {
        _renderer = renderer;
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

@end