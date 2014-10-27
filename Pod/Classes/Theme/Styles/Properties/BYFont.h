//
//  Font.h
//  Beautify
//
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

/**
 *  A style property representing the font for the text on a UIView.
 */
@interface BYFont : JSONModel <NSCopying>

/**
 *  The font name.
 */
@property NSString* name;

/**
 *  The font size in points
 */
@property float size;

/**
 *  Init with the specified font name
 *
 *  @param name The name of the font.
 *
 *  @return A new BYFont instance with the specified font name.
 */
+ (BYFont*)fontWithName:(NSString*)name;

/**
 *  Create with the specified font name and size
 *
 *  @param name The name of the font.
 *  @param size The size of the font.
 *
 *  @return A new BYFont instance with the specified font name and size.
 */
+ (BYFont*)fontWithName:(NSString*)name andSize:(float)size;

@end