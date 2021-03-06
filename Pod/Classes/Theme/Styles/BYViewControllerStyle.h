//
//  BYViewControllerConfig.h
//  Beautify
//
//  Created by Chris Grant on 06/03/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYStyle.h"
#import "BYBackgroundImage.h"
#import "BYGradient.h"

@interface BYViewControllerStyle : BYStyle

@property UIColor *backgroundColor;

@property BYBackgroundImage<Optional> *backgroundImage;

@property BYGradient<Optional> *backgroundGradient;

@property UIStatusBarStyle statusBarStyle;

+ (BYViewControllerStyle*)defaultStyle;

@end