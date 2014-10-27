//
//  ButtonRenderer.h
//  Beautify
//
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYControlRenderer.h"
@class BYText;
@class BYTextShadow;

/**
 *  A renderer responsible for enhancing a UIButton. 
 *  The style properties for a UIButton can be customized using methods defined in this class.
 */
@interface BYButtonRenderer : BYControlRenderer

#pragma mark - Text customizers

/**
 *  Set the text style for the button associated with this renderer
 *
 *  @param titleStyle The text style for the title when set to the specified control state.
 *  @param state      The control state to use the text style for.
 */
- (void)setTitleStyle:(BYText *)titleStyle forState:(UIControlState)state;

/**
 *  Set the title shadow style for the button associated with this renderer.
 *
 *  @param titleShadowStyle The text shadow style for the title when set to the specified control state.
 *  @param state            The control state to use the shadow for.
 */
- (void)setTitleShadowStyle:(BYTextShadow *)titleShadowStyle forState:(UIControlState)state;

@end