//
//  Shadow.h
//  Beautify
//
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

// Used to tell JSONModel to look for shadow in arrays.
@protocol BYShadow
@end

@interface NSArray (Shadow)<BYShadow> // This will remove warnings that NSArrays don't conform to BYShadow protocols.
@end

/**
 *  A style property representing a shadow for a UIView.
 */
@interface BYShadow : JSONModel <NSCopying, BYShadow>

/**
 *  The blur radius for the shadow.
 */
@property float radius;

/**
 *  The offset of the shadow from the associated UI element.
 */
@property CGSize offset;

/**
 *  Color for the shadow. Defaults to black.
 */
@property UIColor<Optional> *color;

/**
 *  Creates a BYShadow with the specified offset, blur radius and color.
 *
 *  @param offset The offset for the shadow.
 *  @param radius The blur radius for the shadow.
 *  @param color  The color of the shadow.
 *
 *  @return A new BYShadow instance with the specified offset, blur and color.
 */
+(BYShadow*)shadowWithOffset:(CGSize)offset radius:(float)radius color:(UIColor*)color;

@end