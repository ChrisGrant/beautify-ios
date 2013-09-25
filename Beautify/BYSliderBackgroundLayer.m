//
//  fsdfasdf.m
//  Beautify
//
//  Created by Daniel Allsop on 22/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYSliderBackgroundLayer.h"
#import "BYBorder.h"
#import "BYStyleRenderer_Private.h"

@implementation BYSliderBackgroundLayer

-(UIBezierPath*)backgroundPath {
    BYBorder* border = [self.renderer propertyValueForNameWithCurrentState:@"border"];
    CGRect frameInsideBorder = CGRectInset(self.bounds, border.width / 2, border.width / 2);
    UIBezierPath* backgroundPath = [UIBezierPath bezierPathWithRoundedRect:frameInsideBorder cornerRadius:border.cornerRadius];
    return backgroundPath;
}

-(void)drawInContext:(CGContextRef)ctx {
    UIBezierPath *backgroundPath = [self backgroundPath];
    BYBorder* border = [self.renderer propertyValueForNameWithCurrentState:@"border"];
    UIColor *backgroundColor = [self.renderer propertyValueForNameWithCurrentState:@"backgroundColor"];
    
    // render the border
    CGContextAddPath(ctx, backgroundPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, border.color.CGColor);
    CGContextSetLineWidth(ctx, border.width);
    CGContextStrokePath(ctx);
    
    // fill the background
    CGContextAddPath(ctx, backgroundPath.CGPath);
    CGContextSetFillColorWithColor(ctx, backgroundColor.CGColor);
    CGContextFillPath(ctx);
}

@end