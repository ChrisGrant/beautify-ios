//
//  SwitchRenderer.h
//  Beautify
//
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYViewRenderer.h"

@class BYFont, BYGradient, BYBorder, BYSwitchState, BYShadow;

/**
 A renderer responsible for enhancing a UISwitch.
 
 The style properties for a UISwitch can be customized using methods defined in this class.
 */
@interface BYSwitchRenderer : BYViewRenderer <UIGestureRecognizerDelegate>

#pragma mark - ON / OFF state customizers

/**
 *  Set the style of slider in the 'ON' position for the switch associated with this renderer.
 *
 *  @param switchState The switch state style to use.
 *  @param state       The state that this style applies to.
 */
- (void)setOnState:(BYSwitchState *)switchState forState:(UIControlState)state;

/**
 *  Set the style of slider in the 'OFF' position for the switch associated with this renderer.
 *
 *  @param switchState The switch state style to use.
 *  @param state       The state that this style applies to.
 */
- (void)setOffState:(BYSwitchState *)switchState forState:(UIControlState)state;

/**
 *  Set the image for the track layer on the switch associated with this renderer.
 *
 *  @param trackLayerImage The track layer image to use for the specified state.
 *  @param state           The state to set the
 */
- (void)setTrackLayerImage:(UIImage *)trackLayerImage forState:(UIControlState)state;


#pragma mark - Background customizers

/**
 *  Set the background highlight color for the labels on the switch associated with this renderer.
 *
 *  @param highlightColor The highlight color to use for the given state.
 *  @param state          The state to use the highlight color for.
 */
- (void)setHighlightColor:(UIColor *)highlightColor forState:(UIControlState)state;

#pragma mark - Border customizers

/**
 *  Set the border for the switch associated with this renderer.
 *
 *  @param border The border for the given state.
 *  @param state  The state to use the border for.
 */
- (void)setBorder:(BYBorder *)border forState:(UIControlState)state;

/**
 *  Set the inner shadow for the switch associated with this renderer.
 *
 *  @param innerShadow The inner shadow to use for the given state.
 *  @param state       The state to use the inner shadow for.
 */
- (void)setInnerShadow:(BYShadow *)innerShadow forState:(UIControlState)state;

/**
 *  Set the outer shadow for the switch associated with this renderer.
 *
 *  @param outerShadow The outer shadow to use for the given state.
 *  @param state       The state to use the outer shadow for.
 */
- (void)setouterShadow:(BYShadow *)outerShadow forState:(UIControlState)state;

/**
 *  Set the image for the border layer on the switch associated with this renderer.
 *
 *  @param borderLayerImage The border layer image to use for the given state.
 *  @param state            The state to use the border layer image for.
 */
- (void)setBorderLayerImage:(UIImage *)borderLayerImage forState:(UIControlState)state;

#pragma mark - Thumb customizers

/**
 *  Set the border for the thumb on the switch associated with this renderer.
 *
 *  @param border The thumb border to use for the given state.
 *  @param state  The state to use the thumb border for.
 */
- (void)setThumbBorder:(BYBorder *)border forState:(UIControlState)state;

/**
 *  Set the background color for the thumb on the switch associated with this renderer.
 *
 *  @param thumbBackgroundColor The thumb background color to use for the given state.
 *  @param state                The state to use the thumb background color for.
 */
- (void)setThumbBackgroundColor:(UIColor *)thumbBackgroundColor forState:(UIControlState)state;

/**
 *  Set the highlight color for the thumb on the switch associated with this renderer.
 *
 *  @param thumbHighlightColor The highlight color to use for the given state.
 *  @param state               The state to use the thumb highlight color for.
 */
- (void)setThumbHighlightColor:(UIColor *)thumbHighlightColor forState:(UIControlState)state;

/**
 *  Set the background gradient for the thumb on the switch associated with this renderer.
 *
 *  @param thumbBackgroundGradient The thumb background gradient to use for the given state.
 *  @param state                   The state to use the thumb background gradient for.
 */
- (void)setThumbBackgroundGradient:(BYGradient *)thumbBackgroundGradient forState:(UIControlState)state;

/**
 *  Set the inner shadow for the thumb on the switch associated with this renderer.
 *
 *  @param thumbInnerShadow The thumb inner shadow to use for the given state.
 *  @param state            The state to use the thumb inner shadow for.
 */
- (void)setThumbInnerShadow:(BYShadow *)thumbInnerShadow forState:(UIControlState)state;

/**
 *  Set the outer shadow for the thumb on the switch associated with this renderer.
 *
 *  @param thumbOuterShadow The thumb outer shadow for the given state.
 *  @param state            The state to use the thumb outer shadow for.
 */
- (void)setThumbouterShadow:(BYShadow *)thumbOuterShadow forState:(UIControlState)state;

/**
 *  Set the image for the thumb on the switch associated with this renderer.
 *
 *  @param thumbImage The thumb image to use for the given state.
 *  @param state      The state to use the thumb image for.
 */
- (void)setThumbImage:(UIImage *)thumbImage forState:(UIControlState)state;

@end
