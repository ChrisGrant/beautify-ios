//
//  fsdfasdf.h
//  Beautify
//
//  Created by Daniel Allsop on 22/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYSliderLayer.h"

/*
 * A layer that renders the border and inner shadow
 */
@interface BYSliderBackgroundLayer : BYSliderLayer

// gets the path that this border uses.
-(UIBezierPath*)backgroundPath;

@end
