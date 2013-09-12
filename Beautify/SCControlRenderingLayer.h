//
//  ButtonLayer.h
//  Beautify
//
//  Created by Chris Grant on 26/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCButtonRenderer.h"
#import "SCStyleLayer.h"

/*
 A layer that is used to render a background border and shadows. 
 */
@interface SCControlRenderingLayer : SCStyleLayer

// creates a layer and associates it with the given renderer. The layer will use the current control state
// when re-drawing.
-(id)initWithRenderer:(SCViewRenderer*)renderer;

// creates a layer and associates it with the given renderer. The layer will always
// use the given state when rendering.
-(id)initWithRenderer:(SCViewRenderer*)renderer state:(UIControlState)state;

@end