//
//  SCSliderBorderLayer.m
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCSliderBarBorderLayer.h"
#import "SCBorder.h"
#import "SCShadow.h"
#import "SCRenderUtils.h"
#import "SCStyleRenderer_Private.h"
#import "SCSwitchBorderLayer.h"

@implementation SCSliderBarBorderLayer

-(void)drawInContext:(CGContextRef)ctx {
    
    UIImage* barBorderLayerImage = [self.renderer propertyValueForNameWithCurrentState:@"borderLayerImage"];
    
    if (barBorderLayerImage != nil) {
        // flip the context, see
        // http://stackoverflow.com/questions/506622/cgcontextdrawimage-draws-image-upside-down-when-passed-uiimage-cgimage
        CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        
        CGContextDrawImage(ctx, self.bounds, barBorderLayerImage.CGImage);
    }
    else {
        SCBorder* border = [self.renderer propertyValueForNameWithCurrentState:@"barBorder"];
        UIBezierPath *borderPath = [SCSwitchBorderLayer borderPathForBounds:self.bounds andBorder:border];
        
        NSArray* barInnerShadows = [self.renderer propertyValueForNameWithCurrentState:@"barInnerShadows"];
        RenderInnerShadows(ctx, border, barInnerShadows, self.bounds);
        
        // render the border
        CGContextAddPath(ctx, borderPath.CGPath);
        CGContextSetStrokeColorWithColor(ctx, border.color.CGColor);
        CGContextSetLineWidth(ctx, border.width);
        CGContextStrokePath(ctx);
    }
    
}

@end
