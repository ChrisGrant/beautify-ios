//
//  ButtonLayer.h
//  Beautify
//
//  Created by Chris Grant on 26/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYButtonRenderer.h"
#import "BYStyleLayer.h"

/*
 A layer that is used to render a background border and shadows. 
 */
@interface BYControlRenderingLayer : BYStyleLayer

// creates a layer and associates it with the given renderer. The layer will use the current control state
// when re-drawing.
-(id)initWithRenderer:(BYViewRenderer*)renderer;

// creates a layer and associates it with the given renderer. The layer will always
// use the given state when rendering.
-(id)initWithRenderer:(BYViewRenderer*)renderer state:(UIControlState)state;

@end