//
//  Theme.h
//  Beautify
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SCButtonStyle;
@class SCSwitchStyle;
@class SCLabelStyle;
@class SCViewControllerStyle;
@class SCTextFieldStyle;
@class SCNavigationBarStyle;
@class SCTableViewCellStyle;
@class SCImageViewStyle;
@class SCSliderStyle;
@class SCBarButtonStyle;

/**
 * Represents a rendering configuration, typically containing a number of
 * style configurations for a range of UI elements.
 */
@interface SCTheme : NSObject

@property NSString *name;
@property SCButtonStyle *buttonStyle;
@property SCSwitchStyle *switchStyle;
@property SCLabelStyle *labelStyle;
@property SCViewControllerStyle *viewControllerStyle;
@property SCTextFieldStyle *textFieldStyle;
@property SCNavigationBarStyle *navigationBarStyle;
@property SCTableViewCellStyle *tableViewCellStyle;
@property SCImageViewStyle *imageViewStyle;
@property SCBarButtonStyle *barButtonItemStyle;
@property SCSliderStyle *sliderStyle;

+(SCTheme*)default;

+(SCTheme*)fromFile:(NSString*)file;

+(SCTheme*)fromDictionary:(NSDictionary*)dict;

@end