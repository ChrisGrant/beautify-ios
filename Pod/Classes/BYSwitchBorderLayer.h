//
//  SwitchBorderLayer.h
//  Beautify
//
//  Created by Colin Eberhardt on 13/03/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYSwitchLayer.h"

/*
 * A layer that renders the border, inner shadow and highlight
 */
@interface BYSwitchBorderLayer : BYSwitchLayer

// gets the path that this border uses.
+(UIBezierPath*)borderPathForBounds:(CGRect)bounds andBorder:(BYBorder*)border;


@end