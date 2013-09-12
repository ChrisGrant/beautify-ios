//
//  SCImageViewStyle.h
//  Beautify
//
//  Created by Chris Grant on 18/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCViewStyle.h"
#import <UIKit/UIKit.h>

@class SCBorder;

@interface SCImageViewStyle : SCViewStyle

@property SCBorder *border;
@property NSArray *innerShadows;
@property NSArray *outerShadows;

+(SCImageViewStyle*)defaultStyle;

@end