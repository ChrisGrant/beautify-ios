//
//  BYSearchBarStyle.h
//  Beautify
//
//  Created by Chris Grant on 06/02/2014.
//  Copyright (c) 2014 Beautify. All rights reserved.
//

#import <Beautify/Beautify.h>

@interface BYSearchBarStyle : BYViewStyle

@property UIColor<Optional> *backgroundColor;
@property BYGradient<Optional> *backgroundGradient;
@property BYBackgroundImage<Optional> *backgroundImage;

@property BYBorder<Optional> *border;
@property BYShadow<Optional> *innerShadow;
@property BYShadow<Optional> *outerShadow;

#pragma mark Text Field Properties 

@property BYText *textFieldText;

@property UIColor<Optional> *textFieldBackgroundColor;
@property BYGradient<Optional> *textFieldBackgroundGradient;
@property BYBackgroundImage<Optional> *textFieldBackgroundImage;

@property BYBorder<Optional> *textFieldBorder;
@property BYShadow<Optional> *textFieldInnerShadow;
@property BYShadow<Optional> *textFieldOuterShadow;

+(BYSearchBarStyle*)defaultStyle;

@end