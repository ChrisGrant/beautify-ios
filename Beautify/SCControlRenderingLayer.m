//
//  SCControlRenderingLayer.m
//  Beautify
//
//  Created by Chris Grant on 26/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCControlRenderingLayer.h"
#import "SCGradientStop.h"
#import "SCRenderUtils.h"
#import "SCStyleRenderer_Private.h"

@implementation SCControlRenderingLayer {
    SCViewRenderer* _renderer;
    BOOL _useSuppliedState;
    UIControlState _state;
    CGRect originalFrame;
}

-(id)initWithRenderer:(SCViewRenderer *)renderer {
    if (self = [super init] ) {
        _renderer = renderer;
        _useSuppliedState = NO;
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

-(id)initWithRenderer:(SCViewRenderer *)renderer state:(UIControlState)state {
    if (self = [super init] ) {
        _renderer = renderer;
        _useSuppliedState = YES;
        _state = state;
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

-(void)setFrame:(CGRect)frame {
    NSArray *outerShadows = [self propertyValue:@"outerShadows"];
    UIEdgeInsets insets = ComputeExpandingInsetsForShadows(outerShadows, YES);
    
    originalFrame = frame;
    // Inflate the frame to make space for outer shadows
    frame = UIEdgeInsetsInsetRect(frame, insets);

    // Move the origin of the 'original' frame to compensate
    originalFrame.origin = CGPointMake(-frame.origin.x, -frame.origin.y);

    self.masksToBounds = NO;
    [super setFrame:frame];
}

-(void)drawInContext:(CGContextRef)ctx {
    UIGraphicsPushContext(ctx);

    [self drawLayerInRect:originalFrame withContext:ctx];
    
    UIGraphicsPopContext();
}

-(id)propertyValue:(NSString*)propertyName {
    if (_useSuppliedState) {
        return [_renderer propertyValueForName:propertyName forState:_state];
    } else {
        return [_renderer propertyValueForNameWithCurrentState:propertyName];
    }
}

-(void)drawLayerInRect:(CGRect)rect withContext:(CGContextRef)ctx {
    NSArray *outerShadows = [self propertyValue:@"outerShadows"];
    UIColor* backgroundColor = [self propertyValue:@"backgroundColor"];
    SCGradient *backgroundGradient = [self propertyValue:@"backgroundGradient"];
    NSArray *innerShadows = [self propertyValue:@"innerShadows"];
    SCBorder *border = [self propertyValue:@"border"];
    
    // a rounded rectangle bezier path that describes the layer
    UIBezierPath *layerPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                         cornerRadius:border.cornerRadius];
    // Draw the outer shadows
    RenderOuterShadows(ctx, border, outerShadows, rect);
    
    // Use the bezier as a clipping path
    [layerPath addClip];
    
    if(backgroundColor) {
        // draw the background color
        CGContextSetFillColorWithColor(ctx, backgroundColor.CGColor);
        CGContextFillRect(ctx, rect);
    }
    
    // Draw the background gradient
    if (backgroundGradient.stops.count > 0) {
        RenderGradient(backgroundGradient, ctx, originalFrame);
    }
    
    RenderInnerShadows(ctx, border, innerShadows, rect);
    
    // Draw the border

    if (border.width > 0) {                
        CGContextSetStrokeColorWithColor(ctx, border.color.CGColor);
        layerPath.lineWidth = border.width;
        [layerPath stroke];
    }
}

-(id<CAAction>)actionForKey:(NSString *)key {
    // This stops the animation of the layer when drawInContext is called.
    if ([key isEqualToString: @"contents"]) {
        return nil;
    }
    return [super actionForKey:key];
}

@end