//
//  BYSliderMaximumTrackLayer.m
//  Beautify
//
//  Created by Daniel Allsop on 22/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYSliderMaximumTrackLayer.h"
#import "BYFont.h"
#import "BYFont_Private.h"
#import "BYStyleRenderer_Private.h"
#import "BYPlatformVersionUtils.h"
#import "BYRenderUtils.h"

@implementation BYSliderMaximumTrackLayer

-(void)drawInContext:(CGContextRef)ctx {
    
    UIImage *maximumTrackLayerImage = [self.renderer propertyValueForNameWithCurrentState:@"maximumTrackLayerImage"];
    
    if (maximumTrackLayerImage != nil) {
        CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        CGContextDrawImage(ctx, self.bounds, maximumTrackLayerImage.CGImage);
    }
    else {
                
        BYGradient *maximumTrackBackgroundGradient = [self.renderer propertyValueForNameWithCurrentState:@"maximumTrackBackgroundGradient"];
        
        // Draw the background gradient
        if (maximumTrackBackgroundGradient.stops.count > 0) {
            RenderGradient(maximumTrackBackgroundGradient, ctx, self.bounds);
        }
        else{
            UIColor *maximumTrackColor = [self.renderer propertyValueForNameWithCurrentState:@"maximumTrackColor"];
            CGRect maximumTrackTrackRect = self.bounds;
            CGContextSetFillColorWithColor(ctx, maximumTrackColor.CGColor);
            CGContextFillRect(ctx, maximumTrackTrackRect);
        }
        
        UIGraphicsPushContext(ctx);
        UIGraphicsPopContext();
    }
}

@end
