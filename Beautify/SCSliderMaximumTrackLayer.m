//
//  SCSliderMaximumTrackLayer.m
//  Beautify
//
//  Created by Daniel Allsop on 22/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCSliderMaximumTrackLayer.h"
#import "SCFont.h"
#import "SCFont_Private.h"
#import "SCStyleRenderer_Private.h"
#import "SCVersionUtils.h"

#import "SCRenderUtils.h"

@implementation SCSliderMaximumTrackLayer

-(void)drawInContext:(CGContextRef)ctx {
    
    UIImage *maximumTrackLayerImage = [self.renderer propertyValueForNameWithCurrentState:@"maximumTrackLayerImage"];
    
    if (maximumTrackLayerImage != nil) {
        CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        CGContextDrawImage(ctx, self.bounds, maximumTrackLayerImage.CGImage);
    }
    else {
                
        SCGradient *maximumTrackBackgroundGradient = [self.renderer propertyValueForNameWithCurrentState:@"maximumTrackBackgroundGradient"];
        
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
