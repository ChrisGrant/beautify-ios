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
#import "BYBarButtonItemRenderer.h"

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
        else if ([self class] == NSClassFromString(@"UINavigationButton")) {
            renderer = [[BYBarButtonItemRenderer alloc] initWithView:self theme:[[BYThemeManager instance] currentTheme]];
            ((BYBarButtonItemRenderer*)renderer).isBackButtonRenderer = NO;
        }
        else if ([self isKindOfClass:[UIButton class]] && [self isChildOfTableViewCell]) {
            // Don't style buttons that are inside of tableviewcells (yet).
            return;
        }
        else {
            renderer = [[BYThemeManager instance] rendererForView:self];
        }
    }
}

-(void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context{
    [self.renderer redraw];
}

-(void)override_dealloc {
    BYStyleRenderer *renderer = objc_getAssociatedObject(self, @"renderer");
    if(renderer) {
        [self removeObserver:self forKeyPath:@"frame"];
        [self removeObserver:self forKeyPath:@"bounds"];
    }
    [self override_dealloc];
}

-(void)associateRenderer:(BYStyleRenderer*)renderer {
    if (renderer != nil) {
        // Subscribe to changes to the frame and the bounds here. Yes, we do subscribe to both. Sometimes bounds changes
        // without frame changing... (UIKit is not strictly KVO compliant).
        [self addObserver:self forKeyPath:@"frame"
                  options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                  context:nil];
        [self addObserver:self forKeyPath:@"bounds"
                  options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                  context:nil];
        
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
    UIResponder *resp = self;
    while (resp != nil) {
        if([resp isKindOfClass:[UIView class]]) {
            UIView *v = (UIView*)resp;
            if(v.isImmuneToBeautify) {
                return NO;
            }
            for(NSString *className in exceptionNames) {
                if([v isKindOfClass:NSClassFromString(className)] ) {
                    return NO;
                }
            }
        }
        else if ([resp isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController*)resp;
            if([vc isImmuneToBeautify]) {
                return NO;
            }
        }
        resp = [resp nextResponder];
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
        [names addObjectsFromArray:@[@"_UIStepperButton", @"UITextField"]];
    }
    
    // UINavigationBar and UITabBar labels should not be styled by the standard UILabel styling.
    if([self isKindOfClass:[UILabel class]]) {
        [names addObjectsFromArray:@[@"UINavigationBar", @"UITabBar"]];
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
    
    if([[self class] isKindOfClass:NSClassFromString(@"UINavigationButton")]){
        [names addObject:@"UINavigationButton"];
    }
    
    if([self class] == NSClassFromString(@"UINavigationItemView")) {
        [names addObject:@"UINavigationItemView"];
    }
    
    return names;
}

@end