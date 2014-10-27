//
//  BYRenderUtils.m
//  Beautify
//
//  Created by Chris Grant on 02/07/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYRenderUtils.h"
#import "BYShadow.h"
#import "BYGradientStop.h"

UIEdgeInsets UIEdgeInsetsInflate(UIEdgeInsets insets, float dx, float dy) {
    return UIEdgeInsetsMake(insets.top + dy, insets.left + dx, insets.bottom + dy, insets.right + dx);
}

UIEdgeInsets ComputeInsetsForShadowAndBorder(BYShadow *shadow, BYBorder *border) {
    UIEdgeInsets inset = UIEdgeInsetsZero;
    // For each inset property, take the max of the shadow radius + the abs value of the shadow offset, and half the border width.
    inset.top = MAX(MAX(0, shadow.radius) + fabs(shadow.offset.height), border.width / 2);
    inset.bottom = MAX(MAX(0, shadow.radius) + fabs(shadow.offset.height), border.width / 2);
    inset.left = MAX(MAX(0, shadow.radius) + fabs(shadow.offset.width), border.width / 2);
    inset.right = MAX(MAX(0, shadow.radius) + fabs(shadow.offset.width), border.width / 2);
    return inset;
}

UIEdgeInsets ComputeExpandingInsetsForShadowAndBorder(BYShadow *shadow, BYBorder *border, BOOL expanding) {
    if(!shadow && !border) {
        return UIEdgeInsetsZero;
    }
    
    UIEdgeInsets inset = ComputeInsetsForShadowAndBorder(shadow, border);
    if(expanding){
        inset = UIEdgeInsetsMake(-fabs(inset.top) * 2, -fabs(inset.left) * 2,
                                 -fabs(inset.bottom) * 2, -fabs(inset.right) * 2);
    }
    return inset;
}

void RenderInnerShadow(CGContextRef ctx, BYShadow *shadow, UIBezierPath *path) {
        if(CGSizeEqualToSize(shadow.offset, CGSizeZero) && shadow.radius <= 0) {
            // Don't render a shadow if the offset's values and the radius are 0.
            return;
        }
        
        CGContextSaveGState(ctx);
        {
            CGFloat shadowBlurRadius = shadow.radius;
            CGFloat shadowWidth = shadow.offset.width;
            CGFloat shadowHeight = shadow.offset.height;
            
            CGRect ovalBorderRect = CGRectInset([path bounds], -shadowBlurRadius, -shadowBlurRadius);
            ovalBorderRect = CGRectOffset(ovalBorderRect, -shadowWidth, -shadowHeight);
            ovalBorderRect = CGRectInset(CGRectUnion(ovalBorderRect, [path bounds]), -1, 1);
            
            UIBezierPath *ovalNegativePath = [UIBezierPath bezierPathWithRect:ovalBorderRect];
            [ovalNegativePath appendPath:path];
            [ovalNegativePath setUsesEvenOddFillRule:YES];
            
            CGContextSaveGState(ctx);
            {
                CGFloat xOffset = shadowWidth + round(ovalBorderRect.size.width);
                CGFloat yOffset = shadowHeight;
                
                CGContextSetShadowWithColor(ctx, CGSizeMake(xOffset + copysign(0.1, xOffset),
                                                            yOffset + copysign(0.1, yOffset)),
                                            shadowBlurRadius,
                                            shadow.color.CGColor);
                [path addClip];
                
                CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(ovalBorderRect.size.width), 0);
                [ovalNegativePath applyTransform:transform];
                [shadow.color setFill];
                [ovalNegativePath fill];
            }
            CGContextRestoreGState(ctx);
        }
        CGContextRestoreGState(ctx);
}

void RenderOuterShadow(CGContextRef ctx, BYShadow *shadow, UIBezierPath *path) {
        if(CGSizeEqualToSize(shadow.offset, CGSizeZero) && shadow.radius <= 0) {
            // Don't render a shadow if the offset's values and the radius are 0.
            return;
        }
        
        CGContextSaveGState(ctx);
        {
            // create a shadow
            CGContextSetShadowWithColor(ctx, shadow.offset, shadow.radius, shadow.color.CGColor);
            
            // render the path
            CGContextAddPath(ctx, path.CGPath);
            CGContextSetFillColorWithColor(ctx, shadow.color.CGColor);
            CGContextSetLineWidth(ctx, 1.0);
            
            CGContextFillPath(ctx);
        }
        CGContextRestoreGState(ctx);
}

/**
 * Renders a gradient within the given rectangle
 */
void RenderGradient(BYGradient* gradient, CGContextRef ctx, CGRect rect) {
    NSMutableArray *gradientArray = [NSMutableArray new];
    
    CGFloat locations[gradient.stops.count];
    
    for (BYGradientStop *gs in gradient.stops) {
        [gradientArray addObject:(id)gs.color.CGColor];
        locations[[gradient.stops indexOfObject:gs]] = gs.position;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientArray, locations);
    CGGradientDrawingOptions options = kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation;
    
    if (gradient.radial) {
        CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
        CGPoint location = CGPointMake(center.x + gradient.radialOffset.width * center.x,
                                       center.y + gradient.radialOffset.height * center.y);
        CGContextDrawRadialGradient(ctx, gradientRef, location, 0, location, rect.size.width, options);
    } else {
        CGPoint start = CGPointMake(rect.size.width / 2, rect.origin.x);
        CGPoint end = CGPointMake(rect.size.width / 2, rect.origin.x + rect.size.height);
        CGContextDrawLinearGradient(ctx, gradientRef, start, end, options);
    }
    
    CGGradientRelease(gradientRef);
    CGColorSpaceRelease(colorSpace);
}

NSString* DescriptionForState(UIControlState state) {
    switch (state) {
        case UIControlStateNormal:
            return @"Normal";
        case UIControlStateHighlighted:
            return @"Highlighted";
        case UIControlStateDisabled:
            return @"Disabled";
        case UIControlStateSelected:
            return @"Selected";
        case UIControlStateApplication:
            return @"Application";
        case UIControlStateReserved:
            return @"Reserved";
        default:
            return @"Unknown";
    }
}