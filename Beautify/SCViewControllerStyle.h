//
//  SCViewControllerConfig.h
//  Beautify
//
//  Created by Chris Grant on 06/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCStyle.h"
#import "SCNineBoxedImage.h"
#import "SCGradient.h"

@interface SCViewControllerStyle : SCStyle

@property UIColor *backgroundColor;

@property SCNineBoxedImage *backgroundImage;

@property SCGradient *backgroundGradient;

+(SCViewControllerStyle*)defaultStyle;

@end