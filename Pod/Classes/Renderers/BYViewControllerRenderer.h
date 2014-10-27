//
//  BYViewControllerRenderer.h
//  Beautify
//
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYStyleRenderer.h"

@class BYGradient;
@class BYBackgroundImage;

@interface BYViewControllerRenderer : BYStyleRenderer

/**
*  Set the background color for the view controller associated with this renderer.
*
*  @param backgroundColor The color to set the background to.
*/
- (void)setBackgroundColor:(UIColor *)backgroundColor;

/**
 *  Set the background gradient for the view controller associated with this renderer.
 *
 *  @param backgroundGradient The background gradient to set the background to.
 */
- (void)setBackgroundGradient:(BYGradient *)backgroundGradient;

/**
 *  Set the background image for the view controller associated with this renderer.
 *
 *  @param backgroundImage The background image to set the background to.
 */
- (void)setBackgroundImage:(BYBackgroundImage *)backgroundImage;

@end
