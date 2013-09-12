//
//  SCRenderUtils.h
//  Beautify
//
//  Created by Chris Grant on 02/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCBorder.h"
#import "SCGradient.h"

#ifndef Beautify_RenderUtils_h
#define Beautify_RenderUtils_h

UIEdgeInsets UIEdgeInsetsInflate(UIEdgeInsets insets, float dx, float dy);

// Computes the insets requires to accomodate the given outer shadows
UIEdgeInsets ComputeInsetsForShadows(NSArray* outerShadows);
UIEdgeInsets ComputeExpandingInsetsForShadows(NSArray* outerShadows, BOOL expanding);

// Renders all of the given shadows with 'inset = YES'
void RenderInnerShadows(CGContextRef ctx, SCBorder* border, NSArray* innerShadows, CGRect rect);
void RenderOuterShadows(CGContextRef ctx, SCBorder* border, NSArray* outerShadows, CGRect rect);

/*
 * Renders a gradient within the given rectangle
 */
void RenderGradient(SCGradient* gradient, CGContextRef ctx, CGRect rect);

NSString* DescriptionForState(UIControlState state);

#endif