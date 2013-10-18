//
//  BYThumbLayer.m
//  Beautify
//
//  Created by Colin Eberhardt on 14/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYThumbLayer.h"
#import "BYRenderUtils.h"
#import "BYBorder.h"
#import "BYStyleRenderer_Private.h"
#import "BYViewRenderer.h"

@implementation BYThumbLayer{
    BYViewRenderer* _renderer;
    CGRect _originalFrame;
}

-(id)initWithRenderer:(BYViewRenderer*)renderer {
    if (self = [super init] ) {
        _renderer = renderer;
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

-(void)setFrame:(CGRect)frame {
    BYShadow *outerShadow = [self.renderer propertyValueForNameWithCurrentState:@"thumbOuterShadow"];
    UIEdgeInsets insets = ComputeExpandingInsetsForShadows(outerShadow, YES);
    
    _originalFrame = frame;
    
    // Inflate the frame to make space for outer shadows
    frame = UIEdgeInsetsInsetRect(frame, insets);
    
    // Move the origin of the 'original' frame to compensate
    _originalFrame.origin = CGPointMake(-insets.left, -insets.top);
    
    self.masksToBounds = NO;
    [super setFrame:frame];
}

-(void)drawInContext:(CGContextRef)ctx {
    UIGraphicsPushContext(ctx);

    UIImage* thumbImage = [self.renderer propertyValueForNameWithCurrentState:@"thumbImage"];
    
    if (thumbImage != nil) {
        // flip the context, see
        // http://stackoverflow.com/questions/506622/cgcontextdrawimage-draws-image-upside-down-when-passed-uiimage-cgimage
        CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        
        CGContextDrawImage(ctx, self.bounds, thumbImage.CGImage);
    }
    else {
        BYBorder *thumbBorder = [self.renderer propertyValueForNameWithCurrentState:@"thumbBorder"];
        BYGradient *thumbBackgroundGradient = [self.renderer propertyValueForNameWithCurrentState:@"thumbBackgroundGradient"];
        BYShadow *thumbInnerShadow = [self.renderer propertyValueForNameWithCurrentState:@"thumbInnerShadow"];
        BYShadow *thumbOuterShadow = [self.renderer propertyValueForNameWithCurrentState:@"thumbOuterShadow"];
        UIColor *thumbBackgroundColor = [self.renderer propertyValueForNameWithCurrentState:@"thumbBackgroundColor"];
        
        CGRect thumbRect = CGRectInset(_originalFrame, thumbBorder.width/2, thumbBorder.width/2);
        UIBezierPath* thumbPath = [UIBezierPath bezierPathWithRoundedRect:thumbRect
                                                            cornerRadius:thumbBorder.cornerRadius];

        RenderOuterShadow(ctx, thumbOuterShadow, thumbPath);

        // fill the thumb background
        CGContextAddPath(ctx, thumbPath.CGPath);
        CGContextSetFillColorWithColor(ctx, thumbBackgroundColor.CGColor);
        CGContextFillPath(ctx);
        
        // gradient fill
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, thumbPath.CGPath);
            CGContextClip(ctx);
            
            if (thumbBackgroundGradient.stops.count > 0) {
                RenderGradient(thumbBackgroundGradient, ctx, thumbRect);
            }
        }
        CGContextRestoreGState(ctx);

        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:thumbRect cornerRadius:thumbBorder.cornerRadius];
        RenderInnerShadow(ctx, thumbInnerShadow, path);

        // render the border
        CGContextAddPath(ctx, thumbPath.CGPath);
        CGContextSetStrokeColorWithColor(ctx, thumbBorder.color.CGColor);
        CGContextSetLineWidth(ctx, thumbBorder.width);
        CGContextStrokePath(ctx);
    }
}

@end