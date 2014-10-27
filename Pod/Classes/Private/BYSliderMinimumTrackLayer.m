//
//  BYSliderMinimumTrackLayer.m
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYSliderMinimumTrackLayer.h"
#import "BYFont.h"
#import "BYFont_Private.h"
#import "BYStyleRenderer_Private.h"
#import "BYPlatformVersionUtils.h"
#import "BYRenderUtils.h"

@implementation BYSliderMinimumTrackLayer

-(void)drawInContext:(CGContextRef)ctx {
    
    UIImage *minimumTrackImage = [self.renderer propertyValueForNameWithCurrentState:@"minimumTrackImage"];
    
    if (minimumTrackImage != nil) {
        CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        CGContextDrawImage(ctx, self.bounds, minimumTrackImage.CGImage);
    }
    else {
        
        BYGradient *minimumTrackBackgroundGradient = [self.renderer propertyValueForNameWithCurrentState:@"minimumTrackBackgroundGradient"];
        
        // Draw the background gradient
        if (minimumTrackBackgroundGradient.stops.count > 0) {
            RenderGradient(minimumTrackBackgroundGradient, ctx, self.bounds);
        }
        else{
            UIColor *minimumTrackColor = [self.renderer propertyValueForNameWithCurrentState:@"minimumTrackColor"];
            CGRect minimumTrackTrackRect = self.bounds;
            CGContextSetFillColorWithColor(ctx, minimumTrackColor.CGColor);
            CGContextFillRect(ctx, minimumTrackTrackRect);
        }
                
        UIGraphicsPushContext(ctx);
        UIGraphicsPopContext();
    }
}

@end