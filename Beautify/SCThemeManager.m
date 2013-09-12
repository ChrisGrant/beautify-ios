//
//  SCThemeManager.m
//  Beautify
//
//  Created by Adrian Conlin on 21/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UIView+Beautify.h"
#import "SCStyleRenderer_Private.h"
#import "SCThemeManager_Private.h"

@implementation SCThemeManager

+(SCThemeManager*)instance {
    static SCThemeManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SCThemeManager new];
        instance.renderers = @{ @"UISwitch" : @"SCSwitchRenderer",
                                @"UIButton" : @"SCButtonRenderer",
                                @"UILabel" : @"SCLabelRenderer",
                                @"UINavigationBar" : @"SCNavigationBarRenderer",
                                @"UIViewController" : @"SCViewControllerRenderer",
                                @"UITextField" : @"SCTextFieldRenderer",
                                @"UIImageView" : @"SCImageViewRenderer",
                                @"UITableViewCell" : @"SCTableViewCellRenderer",
                                @"UIBarButtonItem" : @"SCBarButtonItemRenderer",
                                @"UISlider" : @"SCSliderRenderer"};
    });
    return instance;
}

#pragma mark - Themes

-(void)applyTheme:(SCTheme*)theme {
    if (theme != nil) {
        _currentTheme = theme;
        [[NSNotificationCenter defaultCenter] postNotificationName:CSThemeUpdatedNotification object:_currentTheme];
    }
    else {
        NSLog(@"Error: Theme is nil and therefore cannot be applied.");
    }
}

// Recursively apply the style
-(void)applyThemeToView:(UIView*)view {
    if (view.renderer != nil) {
        [view.renderer setTheme:_currentTheme];
    }
    
    for (UIView* subView in view.subviews) {
        [self applyThemeToView:subView];
    }
}

-(SCTheme*)currentTheme {
    return _currentTheme;
}

#pragma mark - Handlers

-(SCStyleRenderer*)rendererForView:(id)view {
    // Some controls should not be styled at all.
    if ([view isKindOfClass:NSClassFromString(@"UIButtonLabel")] ||
        [view isKindOfClass:NSClassFromString(@"UINavigationController")] ||
        [view isKindOfClass:NSClassFromString(@"UICalloutBarButton")] ||
        [view isKindOfClass:NSClassFromString(@"UITextFieldLabel")] ||
        [view isKindOfClass:NSClassFromString(@"UIAlertButton")] ||
        [view isKindOfClass:NSClassFromString(@"UINavigationButton")] ||
        [view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")] ||
        [view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]||
        [view isKindOfClass:NSClassFromString(@"_UITextFieldRoundedRectBackgroundViewNeue")]||
        [view isKindOfClass:NSClassFromString(@"_UIToolbarBackground")]) {
        return nil;
    }

    // Iterate over the view to renderer map
    for (NSString* viewType in self.renderers) {
        id viewClass = NSClassFromString(viewType);
        
        // does the given view match the kind?
        if ([view isKindOfClass:viewClass]) {
            
            id rendererClass = (self.renderers)[viewType];
            id rendererClassInstance = [NSClassFromString(rendererClass) alloc];
            
            SCStyleRenderer* renderer = [rendererClassInstance initWithView:view
                                                                      theme:[[SCThemeManager instance] currentTheme]];
            return renderer;
        }
    }
    return nil;
}

@end