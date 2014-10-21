//
//  BYText.h
//  Beautify
//
//  Created by Adrian Conlin on 23/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"
#import "BYFont.h"

@interface BYText : JSONModel <NSCopying>

/*
 Font for the text.
 */
@property BYFont *font;

/*
 Color for the text.
 */
@property UIColor *color;

/*
 Create with the specified font and color.
 */
+(BYText*)textWithFont:(BYFont*)font color:(UIColor*)color;

@end