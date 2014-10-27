//
//  BYSliderBorderLayer.m
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYSliderBarBorderLayer.h"
#import "BYBorder.h"
#import "BYShadow.h"
#import "BYRenderUtils.h"
#import "BYStyleRenderer_Private.h"
#import "BYSwitchBorderLayer.h"

@implementation BYSliderBarBorderLayer

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
        BYBorder* border = [self.renderer propertyValueForNameWithCurrentState:@"barBorder"];
        UIBezierPath *borderPath = [BYSwitchBorderLayer borderPathForBounds:self.bounds andBorder:border];
        
        BYShadow* barInnerShadow = [self.renderer propertyValueForNameWithCurrentState:@"barInnerShadow"];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:border.cornerRadius];
        RenderInnerShadow(ctx, barInnerShadow, path);
        
        // render the border
        CGContextAddPath(ctx, borderPath.CGPath);
        CGContextSetStrokeColorWithColor(ctx, border.color.CGColor);
        CGContextSetLineWidth(ctx, border.width);
        CGContextStrokePath(ctx);
    }
    
}

@end