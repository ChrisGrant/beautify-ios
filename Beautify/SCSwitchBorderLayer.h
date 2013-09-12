//
//  SwitchBorderLayer.h
//  Beautify
//
//  Created by Colin Eberhardt on 13/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCSwitchLayer.h"

/*
 * A layer that renders the border, inner shadow and highlight
 */
@interface SCSwitchBorderLayer : SCSwitchLayer

// gets the path that this border uses.
+(UIBezierPath*)borderPathForBounds:(CGRect)bounds andBorder:(SCBorder*)border;


@end