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
    BYShadow *outerShadow = [self.renderer propertyValueForNameWithCurrentState:@"barouterShadow"];
    UIEdgeInsets insets = ComputeExpandingInsetsForShadows(outerShadow, YES);
   
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
    BYShadow* outerShadow = [self.renderer propertyValueForNameWithCurrentState:@"barouterShadow"];
    
    // render outer shadows
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:originalFrame cornerRadius:border.cornerRadius];
    RenderOuterShadow(ctx, outerShadow, path);
}

@end