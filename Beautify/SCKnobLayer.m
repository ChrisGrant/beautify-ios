//
//  SwitchKnobLayer.m
//  Beautify
//
//  Created by Colin Eberhardt on 14/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCKnobLayer.h"
#import "SCRenderUtils.h"
#import "SCBorder.h"
#import "SCStyleRenderer_Private.h"
#import "SCViewRenderer.h"

@implementation SCKnobLayer{
    SCViewRenderer* _renderer;
    CGRect _originalFrame;
}

-(id)initWithRenderer:(SCViewRenderer*)renderer {
    if (self = [super init] ) {
        _renderer = renderer;
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

-(void)setFrame:(CGRect)frame {
    NSArray *outerShadows = [self.renderer propertyValueForNameWithCurrentState:@"knobOuterShadows"];
    UIEdgeInsets insets = ComputeExpandingInsetsForShadows(outerShadows, YES);
    
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

    UIImage* knobImage = [self.renderer propertyValueForNameWithCurrentState:@"knobImage"];
    
    if (knobImage != nil) {
        // flip the context, see
        // http://stackoverflow.com/questions/506622/cgcontextdrawimage-draws-image-upside-down-when-passed-uiimage-cgimage
        CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        
        CGContextDrawImage(ctx, self.bounds, knobImage.CGImage);
    }
    else {
        SCBorder* knobBorder = [self.renderer propertyValueForNameWithCurrentState:@"knobBorder"];
        SCGradient* knobBackgroundGradient = [self.renderer propertyValueForNameWithCurrentState:@"knobBackgroundGradient"];
        NSArray* knobInnerShadows = [self.renderer propertyValueForNameWithCurrentState:@"knobInnerShadows"];
        NSArray* knobOuterShadows = [self.renderer propertyValueForNameWithCurrentState:@"knobOuterShadows"];
        UIColor* knobBackgroundColor = [self.renderer propertyValueForNameWithCurrentState:@"knobBackgroundColor"];
        
        CGRect knobRect = CGRectInset(_originalFrame, knobBorder.width/2, knobBorder.width/2);
        UIBezierPath* knobPath = [UIBezierPath bezierPathWithRoundedRect:knobRect
                                                            cornerRadius:knobBorder.cornerRadius];

        RenderOuterShadows(ctx, knobBorder, knobOuterShadows, _originalFrame);

        // fill the knob background
        CGContextAddPath(ctx, knobPath.CGPath);
        CGContextSetFillColorWithColor(ctx, knobBackgroundColor.CGColor);
        CGContextFillPath(ctx);
        
        // gradient fill
        CGContextSaveGState(ctx);
        {
            CGContextAddPath(ctx, knobPath.CGPath);
            CGContextClip(ctx);
            
            if (knobBackgroundGradient.stops.count > 0) {
                RenderGradient(knobBackgroundGradient, ctx, knobRect);
            }
        }
        CGContextRestoreGState(ctx);

        RenderInnerShadows(ctx, knobBorder, knobInnerShadows, knobRect);

        // render the border
        CGContextAddPath(ctx, knobPath.CGPath);
        CGContextSetStrokeColorWithColor(ctx, knobBorder.color.CGColor);
        CGContextSetLineWidth(ctx, knobBorder.width);
        CGContextStrokePath(ctx);
    }
}

@end