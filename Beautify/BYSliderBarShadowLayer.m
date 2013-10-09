//
//  BYSliderBarShadowLayer.m
//  Beautify
//
//  Created by Daniel Allsop on 21/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYSliderBarShadowLayer.h"
#import "BYRenderUtils.h"
#import "BYStyleRenderer_Private.h"

@implementation BYSliderBarShadowLayer{
    CGRect originalFrame;
}

-(void)setFrame:(CGRect)frame withWidthPadding:(float)widthPadding {
    NSArray *outerShadows = [self.renderer propertyValueForNameWithCurrentState:@"barOuterShadows"];
    UIEdgeInsets insets = ComputeExpandingInsetsForShadows(outerShadows, YES);
   
    originalFrame = frame;
    
    // Inflate the frame to make space for outer shadows
    frame = UIEdgeInsetsInsetRect(frame, insets);
    
    // Move the origin of the 'original' frame to compensate
    originalFrame.origin = CGPointMake(-frame.origin.x + widthPadding, (frame.size.height / 2) - (originalFrame.size.height / 2) + 0.5);
    
    self.masksToBounds = NO;
    [super setFrame:frame];
}

-(void)drawInContext:(CGContextRef)ctx {
    BYBorder* border = [self.renderer propertyValueForNameWithCurrentState:@"barBorder"];
    NSArray* outerShadows = [self.renderer propertyValueForNameWithCurrentState:@"barOuterShadows"];
    
    // render outer shadows
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:originalFrame cornerRadius:border.cornerRadius];
    RenderOuterShadows(ctx, outerShadows, path);
}

@end