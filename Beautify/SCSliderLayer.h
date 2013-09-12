//
//  SCSliderLayer.h
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCSliderStyle.h"
#import "SCStyleLayer.h"
#import "SCSliderRenderer.h"

/*
 * A base class for slider layers
 */
@interface SCSliderLayer : SCStyleLayer

@property (readonly) SCSliderRenderer* renderer;

-(id)initWithRenderer:(SCSliderRenderer*)style;

@end