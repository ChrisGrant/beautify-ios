//
//  BYImageViewStyle.h
//  Beautify
//
//  Created by Chris Grant on 18/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYViewStyle.h"
#import <UIKit/UIKit.h>

@class BYBorder;

@interface BYImageViewStyle : BYViewStyle

@property BYBorder *border;
@property NSArray *innerShadows;
@property NSArray *outerShadows;

+(BYImageViewStyle*)defaultStyle;

@end