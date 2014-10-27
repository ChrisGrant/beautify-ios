//
//  Border.h
//  Beautify
//
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

/**
 * A style property representing the border for a UIView.
 */
@interface BYBorder : JSONModel <NSCopying>

/**
 * The border width.
 */
@property float width;

/**
 * The radius of the border corners.
 */
@property float cornerRadius;

/**
 * The color of the border.
 */
@property UIColor<Optional> *color;

/**
 *  Creates a BYBorder with the specified properties.
 *
 *  @param color  The border's color.
 *  @param width  The border's width.
 *  @param radius The border's corner radius.
 *
 *  @return A new BYBorder instance with the specified color, width, and corner radius.
 */
+ (BYBorder*)borderWithColor:(UIColor*)color width:(float)width radius:(float)radius;

@end