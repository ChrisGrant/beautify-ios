//
//  Theme.h
//  Beautify
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

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
@interface BYTheme : JSONModel <NSCopying>

@property BYButtonStyle<Optional> *buttonStyle;
@property BYSwitchStyle<Optional> *switchStyle;
@property BYLabelStyle<Optional> *labelStyle;
@property BYViewControllerStyle<Optional> *viewControllerStyle;
@property BYTextFieldStyle<Optional> *textFieldStyle;
@property BYNavigationBarStyle<Optional> *navigationBarStyle;
@property BYTableViewCellStyle<Optional> *tableViewCellStyle;
@property BYImageViewStyle<Optional> *imageViewStyle;
@property BYBarButtonStyle<Optional> *barButtonItemStyle;
@property BYBarButtonStyle<Optional> *backBarButtonItemStyle;
@property BYSliderStyle<Optional> *sliderStyle;

+(BYTheme*)fromFile:(NSString*)file;

+(BYTheme*)fromDictionary:(NSDictionary*)dict;

@end