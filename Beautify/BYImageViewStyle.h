//
//  BYImageViewStyle.h
//  Beautify
//
//  Created by Chris Grant on 18/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYViewStyle.h"
#import <UIKit/UIKit.h>
#import "BYShadow.h"

@class BYBorder;

@interface BYImageViewStyle : BYViewStyle

@property BYBorder<Optional> *border;
@property NSArray<BYShadow, Optional> *innerShadows;
@property NSArray<BYShadow, Optional> *outerShadows;

+(BYImageViewStyle*)defaultStyle;

@end