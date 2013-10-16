//
//  BYImageRenderingLayer.m
//  Beautify
//
//  Created by Chris Grant on 22/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYTopShadowRenderingLayer.h"
#import "BYRenderUtils.h"
#import "BYStyleRenderer_Private.h"

@implementation BYTopShadowRenderingLayer {
    BYViewRenderer *_renderer;
}

-(id)initWithRenderer:(BYViewRenderer*)renderer {
    if(self = [super init]) {
        _renderer = renderer;
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

-(void)drawInContext:(CGContextRef)ctx {
    UIGraphicsPushContext(ctx);
    [self drawLayerInRect:self.bounds withContext:ctx];
    UIGraphicsPopContext();
}

-(void)drawLayerInRect:(CGRect)rect withContext:(CGContextRef)ctx {
    BYBorder *border = [_renderer propertyValueForNameWithCurrentState:@"border"];
    BYShadow *innerShadow = [_renderer propertyValueForNameWithCurrentState:@"innerShadow"];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:border.cornerRadius];
    RenderInnerShadow(ctx, innerShadow, path);
}

@end