//
//  BYRenderUtils.h
//  Beautify
//
//  Created by Chris Grant on 02/07/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BYBorder.h"
#import "BYGradient.h"
#import "BYShadow.h"

#ifndef Beautify_RenderUtils_h
#define Beautify_RenderUtils_h

UIEdgeInsets UIEdgeInsetsInflate(UIEdgeInsets insets, float dx, float dy);

// Computes the insets requires to accomodate the given outer shadow
UIEdgeInsets ComputeInsetsForShadowAndBorder(BYShadow *shadow, BYBorder *border);
UIEdgeInsets ComputeExpandingInsetsForShadowAndBorder(BYShadow *shadow, BYBorder *border, BOOL expanding);

void RenderInnerShadow(CGContextRef ctx, BYShadow *shadow, UIBezierPath *path);
void RenderOuterShadow(CGContextRef ctx, BYShadow *shadow, UIBezierPath *path);

/**
 * Renders a gradient within the given rectangle
 */
void RenderGradient(BYGradient* gradient, CGContextRef ctx, CGRect rect);

NSString* DescriptionForState(UIControlState state);

#endif