//
//  SCText.h
//  Beautify
//
//  Created by Adrian Conlin on 23/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCFont;

@interface SCText : NSObject

/*
 Font for the text.
 */
@property SCFont *font;

/*
 Color for the text.
 */
@property UIColor *color;

/*
 Init with the specified font and color.
 */
-(id)initWithFont:(SCFont*)font color:(UIColor*)color;

@end
