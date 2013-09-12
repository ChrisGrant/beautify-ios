//
//  LabelStyle.h
//  Beautify
//
//  Created by Adrian Conlin on 30/04/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCViewStyle.h"
#import "SCText.h"
#import "SCFont.h"
#import "SCShadow.h"
#import "SCTextShadow.h"

/*
 Represents a group of rendering properties for a given label style.
 */
@interface SCLabelStyle : SCViewStyle

// text
@property SCText *title;

@property SCTextShadow* titleShadow;

+(SCLabelStyle*)defaultStyle;

@end