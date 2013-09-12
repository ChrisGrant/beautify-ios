//
//  SCGradientLayer.m
//  Beautify
//
//  Created by Adrian Conlin on 24/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCGradientLayer.h"
#import "SCViewControllerStyle.h"
#import "SCStyleRenderer_Private.h"
#import "SCRenderUtils.h"

@implementation SCGradientLayer {
    __weak SCViewControllerRenderer* _renderer;
}

-(id)initWithRenderer:(SCViewControllerRenderer*)renderer {
    if (self = [super init] ) {
        _renderer = renderer;
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

-(SCViewControllerStyle*)viewControllerStyle {
    return _renderer.style;
}

-(void)drawInContext:(CGContextRef)ctx {
    UIGraphicsPushContext(ctx);
    
    [self drawGradientInRect:self.frame withContext:ctx];
    
    UIGraphicsPopContext();
}

-(void)drawGradientInRect:(CGRect)rect withContext:(CGContextRef)ctx {
    SCGradient *backgroundGradient = [_renderer propertyValueForNameWithCurrentState:@"backgroundGradient"];
    
    // Draw the background gradient
    if (backgroundGradient.stops.count > 0) {
        RenderGradient(backgroundGradient, ctx, rect);
    }
}

-(id<CAAction>)actionForKey:(NSString*)key {
    // This stops the animation of the layer when drawInContext is called.
    if ([key isEqualToString: @"contents"]) {
        return nil;
    }
    return [super actionForKey:key];
}

@end