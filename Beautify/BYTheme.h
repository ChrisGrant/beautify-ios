//
//  Theme.h
//  Beautify
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BYButtonStyle;
@class BYSwitchStyle;
@class BYLabelStyle;
@class BYViewControllerStyle;
@class BYTextFieldStyle;
@class BYNavigationBarStyle;
@class BYTableViewCellStyle;
@class BYImageViewStyle;
@class BYSliderStyle;
@class BYBarButtonStyle;

/**
 * Represents a rendering configuration, typically containing a number of
 * style configurations for a range of UI elements.
 */
@interface BYTheme : NSObject

@property NSString *name;
@property BYButtonStyle *buttonStyle;
@property BYSwitchStyle *switchStyle;
@property BYLabelStyle *labelStyle;
@property BYViewControllerStyle *viewControllerStyle;
@property BYTextFieldStyle *textFieldStyle;
@property BYNavigationBarStyle *navigationBarStyle;
@property BYTableViewCellStyle *tableViewCellStyle;
@property BYImageViewStyle *imageViewStyle;
@property BYBarButtonStyle *barButtonItemStyle;
@property BYSliderStyle *sliderStyle;

+(BYTheme*)fromFile:(NSString*)file;

+(BYTheme*)fromDictionary:(NSDictionary*)dict;

@end