//
//  SwitchLayer.h
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCSwitchStyle.h"
#import "SCStyleLayer.h"
#import "SCSwitchRenderer.h"

/*
 * A base class for switch layers
 */
@interface SCSwitchLayer : SCStyleLayer

@property (readonly) SCSwitchRenderer* renderer;

-(id)initWithRenderer:(SCSwitchRenderer*)style;

@end