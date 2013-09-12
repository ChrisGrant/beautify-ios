//
//  SwitchShadowLayer.m
//  Beautify
//
//  Created by Colin Eberhardt on 29/04/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCSwitchShadowLayer.h"
#import "SCRenderUtils.h"
#import "SCStyleRenderer_Private.h"

@implementation SCSwitchShadowLayer{
    CGRect originalFrame;
}

-(void)setFrame:(CGRect)frame {
    NSArray *outerShadows = [self.renderer propertyValueForNameWithCurrentState:@"outerShadows"];
    UIEdgeInsets insets = ComputeExpandingInsetsForShadows(outerShadows, YES);
    
    originalFrame = frame;
    
    // Inflate the frame to make space for outer shadows
    frame = UIEdgeInsetsInsetRect(frame, insets);
    
    // Move the origin of the 'original' frame to compensate
    originalFrame.origin = CGPointMake(-frame.origin.x, -frame.origin.y);
    
    self.masksToBounds = NO;
    [super setFrame:frame];
}

-(void)drawInContext:(CGContextRef)ctx {
    SCBorder* border = [self.renderer propertyValueForNameWithCurrentState:@"border"];
    NSArray* outerShadows = [self.renderer propertyValueForNameWithCurrentState:@"outerShadows"];
    
    // render outer shadows
    RenderOuterShadows(ctx, border, outerShadows, originalFrame);
}

@end