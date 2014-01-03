//
//  BYTabBarStyle.h
//  Beautify
//
//  Created by CG on 24/11/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import <Beautify/Beautify.h>

@interface BYTabBarStyle : BYViewStyle

@property UIColor<Optional> *imageTintColor;

// background
@property UIColor<Optional> *backgroundColor;
@property BYGradient<Optional> *backgroundGradient;
@property BYBackgroundImage<Optional> *backgroundImage;

// border
@property BYBorder<Optional> *border;
@property BYShadow<Optional> *innerShadow;
@property BYShadow<Optional> *outerShadow;

+(BYTabBarStyle*)defaultStyle;

@end