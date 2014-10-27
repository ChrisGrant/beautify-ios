//
//  UITableViewCell+Beautify.m
//  Beautify
//
//  Created by Colin Eberhardt on 03/06/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "UITableViewCell+Beautify.h"
#import "UIView+Beautify.h"
#import "BYStyleRenderer_Private.h"

@implementation UITableViewCell (Beautify)

// The UITableViewCell implementation of setSelected modifies the background colour of the various labels.
// here we set them back to transparent once again.
-(void)override_setSelected:(BOOL)selected {
    [self override_setSelected:selected];
    [self internalSetSelected];
}
-(void)override_setSelected:(BOOL)selected animated:(BOOL)animated {
    [self override_setSelected:selected animated:animated];
    [self internalSetSelected];
}

-(void)internalSetSelected {
    [self makeLabelBackgroundTransparent:self];
    [[self renderer] redraw];
}

// Recursively find labels and make their background color transparent.
-(void)makeLabelBackgroundTransparent:(UIView*)view {
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel*)view;
        label.backgroundColor = [UIColor clearColor];
    }
    for(UIView *child in view.subviews) {
        [self makeLabelBackgroundTransparent:child];
    }
}

@end