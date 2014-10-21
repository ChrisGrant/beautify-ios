//
//  BYSliderLayer.h
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYSliderStyle.h"
#import "BYStyleLayer.h"
#import "BYSliderRenderer.h"

/*
 * A base class for slider layers
 */
@interface BYSliderLayer : BYStyleLayer

@property (readonly) BYSliderRenderer* renderer;

-(id)initWithRenderer:(BYSliderRenderer*)style;

@end