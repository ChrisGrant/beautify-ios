//
//  BYViewControllerRenderer.h
//  Beautify
//
//  Created by Colin Eberhardt on 18/03/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYStyleRenderer.h"

@class BYGradient;
@class BYBackgroundImage;

@interface BYViewControllerRenderer : BYStyleRenderer

/*
 Set the background color for the view controller associated with this renderer.
 */
-(void)setBackgroundColor:(UIColor*)backgroundColor;

/*
 Set the background gradient for the view controller associated with this renderer.
 */
-(void)setBackgroundGradient:(BYGradient*)backgroundGradient;

/*
 Set the background image for the view controller associated with this renderer.
 */
-(void)setBackgroundImage:(BYBackgroundImage*)backgroundImage;

@end
