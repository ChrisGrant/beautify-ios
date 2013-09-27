//
//  UIView+Utilities.m
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UIView+Utilities.h"
#import <objc/runtime.h>

@implementation UIView (Utilities)

- (void)dumpViewHierarchy {
    [self dumpViewHierarchy:self indent:@""];
}

- (void)dumpViewHierarchy:(UIView*)view indent:(NSString*)indent {
    NSLog(@"%@%@ @ %p", indent, [view class], view);
    NSString* newIndent = [NSString stringWithFormat:@"%@  ", indent];
    for (UIView* subView in view.subviews) {
        [self dumpViewHierarchy:subView indent:newIndent];
    }
}

-(void)dumpParentViewHierarchy {
    [self dumpParentViewHierarchy:self indent:@""];
}

-(void)dumpParentViewHierarchy:(UIView*)view indent:(NSString*)indent {
    NSLog(@"%@%@", indent, [view class]);
    NSString* newIndent = [NSString stringWithFormat:@"%@  ", indent];
    if(view.superview) {
        [self dumpParentViewHierarchy:view.superview indent:newIndent];
    }
}

-(void)hideAllSubViews {
    [self hideAllSubViews:self];
}

-(void)hideAllSubViews:(UIView*)view {
    for (UIView* subView in view.subviews) {
        if(![view isKindOfClass:NSClassFromString(@"_UISwitchInternalView")]){
            [subView setHidden:YES];
            [self hideAllSubViews:subView];
        }
        else {
            return;
        }
    }
}

-(void)setPreviousFont:(UIFont*)previousFont {
    objc_setAssociatedObject(self, @"previousFont", previousFont, OBJC_ASSOCIATION_RETAIN);
}

-(UIFont*)previousFont {
    return (UIFont*) objc_getAssociatedObject(self, @"previousFont");
}

@end