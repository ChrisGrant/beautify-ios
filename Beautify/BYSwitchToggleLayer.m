//
//  SwitchToggleLayer.m
//  Beautify
//
//  Created by Colin Eberhardt on 13/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYSwitchToggleLayer.h"
#import "BYFont.h"
#import "BYFont_Private.h"
#import "BYStyleRenderer_Private.h"
#import "BYSwitchState.h"
#import "BYPlatformVersionUtils.h"

@implementation BYSwitchToggleLayer

-(void)drawInContext:(CGContextRef)ctx {
    BYSwitchState *onState = [self.renderer propertyValueForNameWithCurrentState:@"onState"];
    BYSwitchState *offState = [self.renderer propertyValueForNameWithCurrentState:@"offState"];
    
    // Consider the radius of the corners, as the text doesn't look visually correct if we don't. Add padding when there
    // is corner radius so that the amount of visual space is equal.
    BYBorder *border = [self.renderer propertyValueForNameWithCurrentState:@"border"];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        
        CGFloat eigthCornerRadius = border.cornerRadius / 8;
        
        if(((UISwitch*)self.renderer.adaptedView).on) {
            // track to the left of the thumb
            CGRect leftTrackRect = self.bounds;
            CGContextSetFillColorWithColor(ctx, onState.backgroundColor.CGColor);
            CGContextFillRect(ctx, leftTrackRect);
            
            UIGraphicsPushContext(ctx);
            [self drawStateText:onState inRect:CGRectMake(0, 0, self.bounds.size.width - self.bounds.size.height + eigthCornerRadius, self.bounds.size.height)];
            UIGraphicsPopContext();
        }
        else {
            // track to the left of the thumb
            CGRect leftTrackRect = self.bounds;
            CGContextSetFillColorWithColor(ctx, offState.backgroundColor.CGColor);
            CGContextFillRect(ctx, leftTrackRect);
            [self drawStateText:offState inRect:CGRectMake(self.bounds.size.height - eigthCornerRadius, 0, self.bounds.size.width - self.bounds.size.height + eigthCornerRadius, self.bounds.size.height)];
            
        }
    }
    else {
        UIImage *trackLayerImage = [self.renderer propertyValueForNameWithCurrentState:@"trackLayerImage"];
        
        if (trackLayerImage != nil) {
            CGContextTranslateCTM(ctx, 0, self.bounds.size.height);
            CGContextScaleCTM(ctx, 1.0, -1.0);
            CGContextDrawImage(ctx, self.bounds, trackLayerImage.CGImage);
        }
        else {
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
}

-(void)drawStateText:(BYSwitchState*)state inRect:(CGRect)rect {
    if(state.text.length > 0) {
        UIFont *font = [state.textStyle.font createFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
        if(!font) {
            // If we can't create a font, use the default bold font, as we need a font to calculate the frame size.
            font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        }
        
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:state.text
                                                                             attributes:@{NSFontAttributeName:font}];
        CGRect desiredRect = [attributedText boundingRectWithSize:(CGSize){CGFLOAT_MAX, CGFLOAT_MAX}
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                          context:nil];
        CGSize size = desiredRect.size;
        
        CGFloat fontHeight = ceilf(size.height);
        CGFloat yOffset = (rect.size.height - fontHeight) / 2.0 + 1.0;
        CGRect textRect = CGRectMake(rect.origin.x, yOffset, rect.size.width, fontHeight);
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        [paraStyle setAlignment:NSTextAlignmentCenter];
        [paraStyle setLineBreakMode:NSLineBreakByClipping];
        
        NSMutableDictionary *textAttributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle}.mutableCopy;
        
        // Draw the text offset by the shadow offset to represent the shadow first.
        if(state.textShadow && !CGSizeEqualToSize(CGSizeZero, state.textShadow.offset)) {
            CGRect shadowRect = CGRectMake(textRect.origin.x + state.textShadow.offset.width,
                                           textRect.origin.y + state.textShadow.offset.height,
                                           textRect.size.width, textRect.size.height);
            [self drawText:state.text inRect:shadowRect withFont:font andColor:state.textShadow.color andAttributes:textAttributes];
        }
        
        // Draw the real text in the original location on top of the shadow.
        [self drawText:state.text inRect:textRect withFont:font andColor:state.textStyle.color andAttributes:textAttributes];
    }
}

-(void)drawText:(NSString*)text inRect:(CGRect)rect withFont:(UIFont*)font andColor:(UIColor*)color andAttributes:(NSMutableDictionary*)attributes {
    // If there's not a colour, use black.
    UIColor *textColor = color ? color : [UIColor blackColor];
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        // In iOS7 we have to add the text color as the foreground color in the dict.
        [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
        [text drawInRect:rect withAttributes:attributes];
    }
    else {
        // In iOS6, we 'set' the color instead
        [textColor set];
        // We're checking if it's iOS6 anyway, so we don't care that this method is only available in < iOS7
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [text drawInRect:rect withFont:font lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
#pragma clang diagnostic pop
    }
}

@end