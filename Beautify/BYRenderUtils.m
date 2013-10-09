//
//  BYRenderUtils.m
//  Beautify
//
//  Created by Chris Grant on 02/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYRenderUtils.h"
#import "BYShadow.h"
#import "BYGradientStop.h"

UIEdgeInsets UIEdgeInsetsInflate(UIEdgeInsets insets, float dx, float dy) {
    return UIEdgeInsetsMake(insets.top + dy, insets.left + dx, insets.bottom + dy, insets.right + dx);
}

// Computes the insets requires to accomodate the given outer shadows
UIEdgeInsets ComputeInsetsForShadows(NSArray* outerShadows) {
    UIEdgeInsets inset = UIEdgeInsetsZero;
    
    for (BYShadow *ss in outerShadows) {
        inset.top = MAX(inset.top, ss.radius + MIN(ss.offset.height, 0));
        inset.bottom = MAX(inset.bottom, ss.radius + MAX(ss.offset.height, 0));
        inset.left = MAX(inset.left, ss.radius + MIN(ss.offset.width, 0));
        inset.right = MAX(inset.right, ss.radius + MAX(ss.offset.width, 0));
    }
    return inset;
}

UIEdgeInsets ComputeExpandingInsetsForShadows(NSArray* outerShadows, BOOL expanding) {
    UIEdgeInsets inset = ComputeInsetsForShadows(outerShadows);
    if(expanding){
        inset = UIEdgeInsetsMake(-inset.top * 2, -inset.left * 2,
                                 -inset.bottom * 2, -inset.right * 2);
    }
    return inset;
}

// Renders all of the given inner Shadows with 'inset = YES'
void RenderInnerShadows(CGContextRef ctx, NSArray *innerShadows, UIBezierPath *path) {
    for(BYShadow *shadow in innerShadows) {
        // These should all be inset
        if(!(CGSizeEqualToSize(CGSizeZero, shadow.offset) && shadow.radius == 0.0f)) {
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
    }
}

void RenderOuterShadows(CGContextRef ctx, NSArray *outerShadows, UIBezierPath *path) {
    for (BYShadow *ss in outerShadows) {
        CGContextSaveGState(ctx);
        {
            // create a shadow
            CGContextSetShadowWithColor(ctx, ss.offset, ss.radius, ss.color.CGColor);
            
            // render the path
            CGContextAddPath(ctx, path.CGPath);
            CGContextSetFillColorWithColor(ctx, ss.color.CGColor);
            CGContextSetLineWidth(ctx, 1.0);
            
            CGContextFillPath(ctx);
        }
        CGContextRestoreGState(ctx);
    }
}

/*
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