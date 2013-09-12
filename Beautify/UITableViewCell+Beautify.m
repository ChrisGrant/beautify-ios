//
//  UITableViewCell+Beautify.m
//  Beautify
//
//  Created by Colin Eberhardt on 03/06/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UITableViewCell+Beautify.h"

@implementation UITableViewCell (Beautify)

-(void)override_setSelected:(BOOL)selected {
    // the UITableViewCell implementation of setSelected modifies the background colour of the various labels.
    // here we set them back to transparent once again.
    [self override_setSelected:selected];
    [self makeLabelBackgroundTransparant:self];
}

// recursively find labels and make their background color transparant.
- (void)makeLabelBackgroundTransparant:(UIView*)view {
    
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel* label = (UILabel*)view;
        label.backgroundColor = [UIColor clearColor];
    }
    for(UIView* child in view.subviews) {
        [self makeLabelBackgroundTransparant:child];
    }
}

@end