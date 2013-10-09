//
//  BYRenderUtils.h
//  Beautify
//
//  Created by Chris Grant on 02/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYBorder.h"
#import "BYGradient.h"

#ifndef Beautify_RenderUtils_h
#define Beautify_RenderUtils_h

UIEdgeInsets UIEdgeInsetsInflate(UIEdgeInsets insets, float dx, float dy);

// Computes the insets requires to accomodate the given outer shadows
UIEdgeInsets ComputeInsetsForShadows(NSArray* outerShadows);
UIEdgeInsets ComputeExpandingInsetsForShadows(NSArray* outerShadows, BOOL expanding);

void RenderInnerShadows(CGContextRef ctx, NSArray *innerShadows, UIBezierPath *path);
void RenderOuterShadows(CGContextRef ctx, NSArray *outerShadows, UIBezierPath *path);

/*
 * Renders a gradient within the given rectangle
 */
void RenderGradient(BYGradient* gradient, CGContextRef ctx, CGRect rect);

NSString* DescriptionForState(UIControlState state);

#endif