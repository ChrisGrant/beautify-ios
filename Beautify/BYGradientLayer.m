//
//  BYGradientLayer.m
//  Beautify
//
//  Created by Adrian Conlin on 24/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYGradientLayer.h"
#import "BYViewControllerStyle.h"
#import "BYStyleRenderer_Private.h"
#import "BYRenderUtils.h"

@implementation BYGradientLayer {
    __weak BYViewControllerRenderer* _renderer;
}

-(id)initWithRenderer:(BYViewControllerRenderer*)renderer {
    if (self = [super init] ) {
        _renderer = renderer;
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

-(BYViewControllerStyle*)viewControllerStyle {
    return _renderer.style;
}

-(void)drawInContext:(CGContextRef)ctx {
    UIGraphicsPushContext(ctx);
    [self drawGradientInRect:self.frame withContext:ctx];
    UIGraphicsPopContext();
}

-(void)drawGradientInRect:(CGRect)rect withContext:(CGContextRef)ctx {
    BYGradient *backgroundGradient = [_renderer propertyValueForNameWithCurrentState:@"backgroundGradient"];
    
    // Draw the background gradient
    if (backgroundGradient.stops.count > 0) {
        RenderGradient(backgroundGradient, ctx, rect);
    }
}

-(id<CAAction>)actionForKey:(NSString*)key {
    // This stops the animation of the layer when drawInContext is called.
    if ([key isEqualToString:@"contents"]) {
        return nil;
    }
    return [super actionForKey:key];
}

@end