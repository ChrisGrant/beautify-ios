//
//  SwitchShadowLayer.m
//  Beautify
//
//  Created by Colin Eberhardt on 29/04/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYSwitchShadowLayer.h"
#import "BYRenderUtils.h"
#import "BYStyleRenderer_Private.h"

@implementation BYSwitchShadowLayer{
    CGRect originalFrame;
}

-(void)setFrame:(CGRect)frame {
    BYShadow *outerShadow = [self.renderer propertyValueForNameWithCurrentState:@"outerShadow"];
    UIEdgeInsets insets = ComputeExpandingInsetsForShadows(outerShadow, YES);
    
    originalFrame = frame;
    
    // Inflate the frame to make space for outer shadows
    frame = UIEdgeInsetsInsetRect(frame, insets);
    
    // Move the origin of the 'original' frame to compensate
    originalFrame.origin = CGPointMake(-frame.origin.x, -frame.origin.y);
    
    self.masksToBounds = NO;
    [super setFrame:frame];
}

-(void)drawInContext:(CGContextRef)ctx {
    BYBorder* border = [self.renderer propertyValueForNameWithCurrentState:@"border"];
    BYShadow* outerShadow = [self.renderer propertyValueForNameWithCurrentState:@"outerShadow"];
    
    // render outer shadows
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:originalFrame cornerRadius:border.cornerRadius];
    RenderOuterShadow(ctx, outerShadow, path);
}

@end