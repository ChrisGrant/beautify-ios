//
//  SwitchToggleLayer.m
//  Beautify
//
//  Created by Colin Eberhardt on 13/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCSwitchToggleLayer.h"
#import "SCFont.h"
#import "SCFont_Private.h"
#import "SCStyleRenderer_Private.h"
#import "SCSwitchState.h"
#import "SCVersionUtils.h"

@implementation SCSwitchToggleLayer

-(void)drawInContext:(CGContextRef)ctx {
    
    UIImage *trackLayerImage = [self.renderer propertyValueForNameWithCurrentState:@"trackLayerImage"];
    
    if (trackLayerImage != nil) {
        CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        CGContextDrawImage(ctx, self.bounds, trackLayerImage.CGImage);
    }
    else {

        SCSwitchState *onState = [self.renderer propertyValueForNameWithCurrentState:@"onState"];
        SCSwitchState *offState = [self.renderer propertyValueForNameWithCurrentState:@"offState"];
        
        // the length of each track
        CGFloat trackLength = self.bounds.size.width;
        
        // track to the left of the thumb
        CGRect leftTrackRect = CGRectMake(0, 0, trackLength / 2, self.frame.size.height);
        CGContextSetFillColorWithColor(ctx, onState.backgroundColor.CGColor);
        CGContextFillRect(ctx, leftTrackRect);
        
        // track to the left of the right of the thumb
        CGRect rightTrackRect = CGRectOffset(leftTrackRect, trackLength / 2, 0);
        CGContextSetFillColorWithColor(ctx, offState.backgroundColor.CGColor);
        CGContextFillRect(ctx, rightTrackRect);
        
        UIGraphicsPushContext(ctx);
        
        // Need to have a separate left and right text rect so text alignment looks correct.

        // Consider the width of the thumb - the text rects shouldn't intersect the thumb's frame.
        CGFloat halfThumbWidth = self.frame.size.height / 2;
        
        // Consider the radius of the corners, as the text doesn't look visually correct if we don't. Add padding when there
        // is corner radius so that the amount of visual space is equal.
        SCBorder *border = [self.renderer propertyValueForNameWithCurrentState:@"border"];
        CGFloat quarterCornerRadius = border.cornerRadius / 4;
        
        CGRect leftTextRect = CGRectMake(leftTrackRect.origin.x + quarterCornerRadius,
                                         leftTrackRect.origin.y,
                                         leftTrackRect.size.width - halfThumbWidth - quarterCornerRadius,
                                         leftTrackRect.size.height);
        
        CGRect rightTextRect = CGRectMake(rightTrackRect.origin.x + halfThumbWidth - quarterCornerRadius,
                                          rightTrackRect.origin.y,
                                          rightTrackRect.size.width - halfThumbWidth,
                                          rightTrackRect.size.height);
        
        [self drawStateText:onState inRect:leftTextRect];
        [self drawStateText:offState inRect:rightTextRect];
        
        UIGraphicsPopContext();
    }
}

-(void)drawStateText:(SCSwitchState*)state inRect:(CGRect)rect {
    UIFont* font = [state.textStyle.font createFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    if(!font) {
        // If we can't create a font, use the default bold font, as we need a font to calculate the frame size.
        font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    }
    
    CGFloat fontHeight = [state.text sizeWithFont:font].height;
    CGFloat yOffset = (rect.size.height - fontHeight) / 2.0 + 1.0;
    CGRect textRect = CGRectMake(rect.origin.x, yOffset, rect.size.width, fontHeight);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [paragraphStyle setLineBreakMode:NSLineBreakByClipping];
    
    NSDictionary *textAttributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    
    if(state.textShadow && !CGSizeEqualToSize(CGSizeZero, state.textShadow.offset)) {
        CGRect shadowRect = CGRectMake(textRect.origin.x + state.textShadow.offset.width,
                                       textRect.origin.y + state.textShadow.offset.height,
                                       textRect.size.width,
                                       textRect.size.height);
        [state.textShadow.color set];

        // Different text drawing methods for iOS 6 and 7.
        if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
            [state.text drawInRect:shadowRect withAttributes:textAttributes];
        }
        else {
            [state.text drawInRect:shadowRect withFont:font lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
        }
    }
    
    if(state.textStyle.color) {
        [state.textStyle.color set];
    }
    else {
        // If there's not a colour, use black otherwise we can end up using the same color as the shadow color set above.
        [[UIColor blackColor] set];
    }
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        [state.text drawInRect:textRect withAttributes:textAttributes];
    }
    else {
        [state.text drawInRect:textRect withFont:font lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
    }
}

@end