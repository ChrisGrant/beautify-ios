//
//  SwitchLayer.h
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYSwitchStyle.h"
#import "BYStyleLayer.h"
#import "BYSwitchRenderer.h"

/*
 * A base class for switch layers
 */
@interface BYSwitchLayer : BYStyleLayer

@property (readonly) BYSwitchRenderer* renderer;

-(id)initWithRenderer:(BYSwitchRenderer*)style;

@end