//
//  SwitchBorderLayer.m
//  Beautify
//
//  Created by Colin Eberhardt on 13/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCSwitchBorderLayer.h"
#import "SCBorder.h"
#import "SCShadow.h"
#import "SCRenderUtils.h"
#import "SCStyleRenderer_Private.h"

@implementation SCSwitchBorderLayer

+(UIBezierPath*)borderPathForBounds:(CGRect)bounds andBorder:(SCBorder*)border {
    CGRect frameInsideBorder = CGRectInset(bounds, border.width/2, border.width/2);
    UIBezierPath* borderPath;
    if(border.cornerRadius > 0) {
        borderPath = [UIBezierPath bezierPathWithRoundedRect:frameInsideBorder cornerRadius:border.cornerRadius];
    }
    else {
        borderPath = [UIBezierPath bezierPathWithRect:frameInsideBorder];
    }
    return borderPath;
}

-(void)drawInContext:(CGContextRef)ctx {
    
    UIImage* borderLayerImage = [self.renderer propertyValueForNameWithCurrentState:@"borderLayerImage"];
    
    if (borderLayerImage != nil) {
        // flip the context, see
        // http://stackoverflow.com/questions/506622/cgcontextdrawimage-draws-image-upside-down-when-passed-uiimage-cgimage
        CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        
        CGContextDrawImage(ctx, self.bounds, borderLayerImage.CGImage);
    }
    else {
        SCBorder* border = [self.renderer propertyValueForNameWithCurrentState:@"border"];
        UIBezierPath *borderPath = [SCSwitchBorderLayer borderPathForBounds:self.bounds andBorder:border];
        
        NSArray* innerShadows = [self.renderer propertyValueForNameWithCurrentState:@"innerShadows"];
        UIColor* highlightColor = [self.renderer propertyValueForNameWithCurrentState:@"highlightColor"];

        if(highlightColor) {
            CGRect rect = CGRectMake(border.cornerRadius/2, self.frame.size.height/2,
                                     self.frame.size.width - border.cornerRadius, self.frame.size.height/2);
            UIBezierPath* highlightPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                                     cornerRadius:border.cornerRadius];
            CGContextAddPath(ctx, highlightPath.CGPath);
            CGContextSetFillColorWithColor(ctx, highlightColor.CGColor);
            CGContextFillPath(ctx);
        }
        
        RenderInnerShadows(ctx, border, innerShadows, self.bounds);
        
        // render the border
        CGContextAddPath(ctx, borderPath.CGPath);
        CGContextSetStrokeColorWithColor(ctx, border.color.CGColor);
        CGContextSetLineWidth(ctx, border.width);
        CGContextStrokePath(ctx);
    }
    
}
    
@end