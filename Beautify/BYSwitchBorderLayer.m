//
//  SwitchBorderLayer.m
//  Beautify
//
//  Created by Colin Eberhardt on 13/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYSwitchBorderLayer.h"
#import "BYBorder.h"
#import "BYShadow.h"
#import "BYRenderUtils.h"
#import "BYStyleRenderer_Private.h"

@implementation BYSwitchBorderLayer

+(UIBezierPath*)borderPathForBounds:(CGRect)bounds andBorder:(BYBorder*)border {
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
        BYBorder* border = [self.renderer propertyValueForNameWithCurrentState:@"border"];
        UIBezierPath *borderPath = [BYSwitchBorderLayer borderPathForBounds:self.bounds andBorder:border];
        
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
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:border.cornerRadius];
        RenderInnerShadows(ctx, innerShadows, path);
        
        if (border.width > 0) {
            UISwitch *view = self.renderer.adaptedView;
            NSString *propName = view.on ? @"onState" : @"offState";
            BYSwitchState *state = [self.renderer propertyValueForNameWithCurrentState:propName];
            // Use the state's border color if it has one - otherwise use the borders own color.
            UIColor *borderColor = state.borderColor != nil ? state.borderColor : border.color;
            
            // render the border
            CGContextAddPath(ctx, borderPath.CGPath);
            CGContextSetStrokeColorWithColor(ctx, borderColor.CGColor);
            CGContextSetLineWidth(ctx, border.width);
            CGContextStrokePath(ctx);
        }
    }
}

@end