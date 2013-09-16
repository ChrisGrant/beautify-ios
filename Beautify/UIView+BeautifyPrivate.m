//
//  UIView+BeautifyPrivate.m
//  Beautify
//
//  Created by Colin Eberhardt on 18/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+BeautifyPrivate.h"
#import "UIView+Beautify.h"
#import "BYThemeManager.h"
#import "BYStyleRenderer.h"
#import "BYStyleRenderer_Private.h"
#import "BYTableViewCellLabelRenderer.h"
#import "BYTableViewRenderer.h"
#import "UIView+Utilities.h"
#import "BYBeautify.h"
#import "BYBeautify_Private.h"
#import "BYThemeManager_Private.h"
#import "NSObject+Beautify.h"

@implementation UIView (BeautifyPrivate)

-(void)createRenderer {
    if(![[BYBeautify instance] active]) {
        // Don't create a renderer if theme loader isn't active.
        return;
    }
    
    BYStyleRenderer *renderer = objc_getAssociatedObject(self, @"renderer");
    if (renderer != nil) {
        [renderer viewDidMoveToWindow];
        return;
    }
    
    if ([self isImmuneToBeautify])
        return;
    
    if ([self validHierarchy]) {
        BYStyleRenderer* renderer;
        if ([self isKindOfClass:[UILabel class]]) {
            if ([self isChildOfTableViewCell]) {
                renderer = [[BYTableViewCellLabelRenderer alloc] initWithView:self
                                                                        theme:[[BYThemeManager instance] currentTheme]];
            }
            else {
                renderer = [[BYThemeManager instance] rendererForView:self];
            }
        }
        else if ([self isKindOfClass:[UITableView class]]) {
            renderer = [[BYTableViewRenderer alloc] initWithView:self theme:[[BYThemeManager instance] currentTheme]];
        }
        else if ([self isKindOfClass:[UIButton class]] && [self isChildOfTableViewCell]) {
            // Don't style buttons that are inside of tableviewcells (yet).
            return;
        }
        else {
            renderer = [[BYThemeManager instance] rendererForView:self];
        }
        [self associateRenderer:renderer];
    }
}

-(void)associateRenderer:(BYStyleRenderer*)renderer {
    if (renderer != nil) {
        objc_setAssociatedObject(self, @"renderer", renderer, OBJC_ASSOCIATION_RETAIN);
    }
}

-(BOOL)isChildOfTableViewCell {
    UIView* view = self;
    while(view!=nil) {
        if ([[view class] isSubclassOfClass:[UITableViewCell class]])
            return YES;
        view = [view superview];
    }
    return NO;
}

-(BOOL)validHierarchy {
    NSArray *exceptionNames = [self heirarchyExceptionClassNames];
    if(exceptionNames.count < 1) {
        return YES;
    }
    
    UIView* view = self;
    while(view != nil) {
        for(NSString *className in exceptionNames) {
            if([view isKindOfClass:NSClassFromString(className)] || view.isImmuneToBeautify) {
                return NO;
            }
        }
        view = view.superview;
    }
    return YES;
}

-(void)applyTheme:(BYTheme*)theme {
    [self.renderer setTheme:theme];
    
    for (UIView* subView in self.subviews) {
        UIResponder *nextResponder = [subView nextResponder];
        
        // If the view has its own controller, let that handle the theme change appropriately
        if(![nextResponder isKindOfClass:[UIViewController class]]) {
            [subView applyTheme:theme];
        }
    }
}

-(NSArray*)heirarchyExceptionClassNames {
    // Builds an array of specific controls to exclude from specific parents. We want to exclude certain classes from
    // styling when they are underneath other certain classes in the view heirarchy.
    NSMutableArray *names = [NSMutableArray new];
    
    // UISteppers
    if([self isKindOfClass:[UIButton class]]) {
        [names addObject:@"_UIStepperButton"];
    }
    
    // Modal/Alert Views
    if([NSStringFromClass([self class]) isEqualToString:@"_UIModalItemTableViewCell"] ||
       [self isKindOfClass:[UILabel class]] ||
       [self isKindOfClass:[UITableView class]])
    {
        [names addObjectsFromArray:@[@"_UIModalItemTableViewCell", @"_UIModalItemAlertContentView"]];
    }
    
    // Picker Views
    if([NSStringFromClass([self class]) isEqualToString:@"UIPickerTableView"] ||
       [NSStringFromClass([self class]) isEqualToString:@"UIPickerTableViewWrapperCell"] ||
       [self isKindOfClass:[UILabel class]])
    {
        [names addObjectsFromArray:@[@"UIPickerTableView", @"UIPickerTableViewWrapperCell"]];
    }
    
    // Keyboard Buttons (iPad split/merge dock/undock buttons)
    if([self isKindOfClass:[UILabel class]] ||
       [self isKindOfClass:[UITableView class]] ||
       [self isKindOfClass:[UITableViewCell class]])
    {
        [names addObjectsFromArray:@[@"UIInputSwitcherTableCell", @"UIInputSwitcherTableView"]];
    }
    
    if([self isKindOfClass:[UIImageView class]]) {
        [names addObjectsFromArray:@[@"UINavigationBar", @"_UIToolbarBackground", @"UILabel"]];
    }
    
    if([self isKindOfClass:NSClassFromString(@"UINavigationButton")]){
        [names addObject:@"UINavigationButton"];
    }
    
    return names;
}

@end