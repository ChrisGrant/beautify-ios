//
//  BYText.h
//  Beautify
//
//  Created by Adrian Conlin on 23/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BYFont;

@interface BYText : NSObject <NSCopying>

/*
 Font for the text.
 */
@property BYFont *font;

/*
 Color for the text.
 */
@property UIColor *color;

/*
 Init with the specified font and color.
 */
-(id)initWithFont:(BYFont*)font color:(UIColor*)color;

@end
