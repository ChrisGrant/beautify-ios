//
//  SCImageRenderingLayer.h
//  Beautify
//
//  Created by Chris Grant on 22/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SCStyleLayer.h"
#import "SCViewRenderer.h"

@interface SCTopShadowRenderingLayer : SCStyleLayer

-(id)initWithRenderer:(SCViewRenderer*)renderer;

@property UIImage *image;

@end