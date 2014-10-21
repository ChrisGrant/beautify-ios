//
//  BYImageViewStyle.h
//  Beautify
//
//  Created by Chris Grant on 18/07/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYViewStyle.h"
#import <UIKit/UIKit.h>
#import "BYShadow.h"

@class BYBorder;

@interface BYImageViewStyle : BYViewStyle

@property BYBorder<Optional> *border;
@property BYShadow<Optional> *innerShadow;
@property BYShadow<Optional> *outerShadow;

+(BYImageViewStyle*)defaultStyle;

@end