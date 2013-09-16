//
//  SCThumbLayer.h
//  Beautify
//
//  Created by Colin Eberhardt on 14/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCStyleLayer.h"
#import "SCViewRenderer.h"

/*
 * A layer that renders the thumb
 */
@interface SCThumbLayer  : SCStyleLayer

@property (readonly) SCViewRenderer* renderer;

-(id)initWithRenderer:(SCViewRenderer*)style;

@end