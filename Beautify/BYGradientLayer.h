//
//  BYGradientLayer.h
//  Beautify
//
//  Created by Adrian Conlin on 24/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYViewControllerRenderer.h"
#import "BYStyleLayer.h"

/*
 A layer that is used to render a background gradient.
 */
@interface BYGradientLayer : BYStyleLayer

-(id)initWithRenderer:(BYViewControllerRenderer*)renderer;

@end