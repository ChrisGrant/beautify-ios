//
//  SCViewControllerRenderer.h
//  Beautify
//
//  Created by Colin Eberhardt on 18/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCStyleRenderer.h"

@class SCGradient;
@class SCNineBoxedImage;

@interface SCViewControllerRenderer : SCStyleRenderer

/*
 Set the background color for the view controller associated with this renderer.
 */
-(void)setBackgroundColor:(UIColor*)backgroundColor forState:(UIControlState)state;

/*
 Set the background gradient for the view controller associated with this renderer.
 */
-(void)setBackgroundGradient:(SCGradient*)backgroundGradient forState:(UIControlState)state;

/*
 Set the background image for the view controller associated with this renderer.
 */
-(void)setBackgroundImage:(SCNineBoxedImage*)backgroundImage forState:(UIControlState)state;

@end
