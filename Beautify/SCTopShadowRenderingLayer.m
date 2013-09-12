//
//  SCImageRenderingLayer.m
//  Beautify
//
//  Created by Chris Grant on 22/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCTopShadowRenderingLayer.h"
#import "SCRenderUtils.h"
#import "SCStyleRenderer_Private.h"

@implementation SCTopShadowRenderingLayer {
    SCViewRenderer *_renderer;
}

-(id)initWithRenderer:(SCViewRenderer*)renderer {
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
    SCBorder *border = [_renderer propertyValueForNameWithCurrentState:@"border"];
    NSArray *innerShadows = [_renderer propertyValueForNameWithCurrentState:@"innerShadows"];
    
    RenderInnerShadows(ctx, border, innerShadows, rect);
}

@end