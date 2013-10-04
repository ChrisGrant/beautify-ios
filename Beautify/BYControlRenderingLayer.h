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

/*
 Creates a layer and associates it with the given renderer. The layer will use the current control state when redrawing.
 */
-(id)initWithRenderer:(BYStyleRenderer*)renderer;

/*
 Creates a layer and associates it with the given renderer. The layer will always use the given control state when redrawing.
 */
-(id)initWithRenderer:(BYStyleRenderer*)renderer state:(UIControlState)state;

/*
 Set this property to make the control layer draw with a custom path. The layer will use bezierPathWithRoundedRect by default if this property is nil.
 */
@property UIBezierPath *customPath;

@end