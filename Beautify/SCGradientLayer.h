//
//  SCGradientLayer.h
//  Beautify
//
//  Created by Adrian Conlin on 24/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCViewControllerRenderer.h"
#import "SCStyleLayer.h"

/*
 A layer that is used to render a background gradient.
 */
@interface SCGradientLayer : SCStyleLayer

-(id)initWithRenderer:(SCViewControllerRenderer*)renderer;

@end