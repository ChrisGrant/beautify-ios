//
//  SCSliderMinimumTrackLayer.m
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCSliderMinimumTrackLayer.h"
#import "SCFont.h"
#import "SCFont_Private.h"
#import "SCStyleRenderer_Private.h"
#import "SCVersionUtils.h"

#import "SCRenderUtils.h"

@implementation SCSliderMinimumTrackLayer

-(void)drawInContext:(CGContextRef)ctx {
    
    UIImage *minimumTrackImage = [self.renderer propertyValueForNameWithCurrentState:@"minimumTrackImage"];
    
    if (minimumTrackImage != nil) {
        CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        CGContextDrawImage(ctx, self.bounds, minimumTrackImage.CGImage);
    }
    else {
        
        SCGradient *minimumTrackBackgroundGradient = [self.renderer propertyValueForNameWithCurrentState:@"minimumTrackBackgroundGradient"];
        
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