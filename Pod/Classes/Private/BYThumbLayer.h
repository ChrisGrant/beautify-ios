//
//  BYThumbLayer.h
//  Beautify
//
//  Created by Colin Eberhardt on 14/03/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYStyleLayer.h"
#import "BYViewRenderer.h"

/**
 * A layer that renders the thumb
 */
@interface BYThumbLayer  : BYStyleLayer

@property (readonly) BYViewRenderer* renderer;

-(id)initWithRenderer:(BYViewRenderer*)style;

@end