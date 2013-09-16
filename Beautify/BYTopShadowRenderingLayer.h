//
//  BYImageRenderingLayer.h
//  Beautify
//
//  Created by Chris Grant on 22/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BYStyleLayer.h"
#import "BYViewRenderer.h"

@interface BYTopShadowRenderingLayer : BYStyleLayer

-(id)initWithRenderer:(BYViewRenderer*)renderer;

@property UIImage *image;

@end