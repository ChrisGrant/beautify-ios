//
//  BYThemeManager.m
//  Beautify
//
//  Created by Adrian Conlin on 21/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UIView+Beautify.h"
#import "BYStyleRenderer_Private.h"
#import "BYThemeManager_Private.h"

@implementation BYThemeManager

+(BYThemeManager*)instance {
    static BYThemeManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [BYThemeManager new];
        instance.renderers = @{ @"UISwitch" : @"BYSwitchRenderer",
                                @"UIButton" : @"BYButtonRenderer",
                                @"UILabel" : @"BYLabelRenderer",
                                @"UINavigationBar" : @"BYNavigationBarRenderer",
                                @"UIViewController" : @"BYViewControllerRenderer",
                                @"UITextField" : @"BYTextFieldRenderer",
                                @"UIImageView" : @"BYImageViewRenderer",
                                @"UITableViewCell" : @"BYTableViewCellRenderer",
                                @"UISlider" : @"BYSliderRenderer",
                                @"UINavigationButton" : @"BYBarButtonItemRenderer",
                                @"UINavigationItemView" : @"BYBarButtonItemRenderer" };
    });
    return instance;
}

#pragma mark - Themes

-(void)applyTheme:(BYTheme*)theme {
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

-(BYTheme*)currentTheme {
    return _currentTheme;
}

#pragma mark - Handlers

-(BYStyleRenderer*)rendererForView:(id)view {
    // Some controls should not be styled at all.
    if ([view isKindOfClass:NSClassFromString(@"UIButtonLabel")] ||
        [view isKindOfClass:[UINavigationController class]] ||
        [view isKindOfClass:NSClassFromString(@"UICalloutBarButton")] ||
        [view isKindOfClass:NSClassFromString(@"UITextFieldLabel")] ||
        [view isKindOfClass:NSClassFromString(@"UIAlertButton")] ||
        [view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")] ||
        [view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]||
        [view isKindOfClass:NSClassFromString(@"_UITextFieldRoundedRectBackgroundViewNeue")]||
        [view isKindOfClass:NSClassFromString(@"_UIToolbarBackground")] ||
        [view isKindOfClass:NSClassFromString(@"_UIModalItemAppViewController")] ||
        [view isKindOfClass:[UITabBarController class]]) {
        return nil;
    }

    // Iterate over the view to renderer map
    for (NSString* viewType in self.renderers) {
        id viewClass = NSClassFromString(viewType);
        
        // does the given view match the kind?
        if ([view isKindOfClass:viewClass]) {
            
            id rendererClass = (self.renderers)[viewType];
            id rendererClassInstance = [NSClassFromString(rendererClass) alloc];
            
            BYStyleRenderer* renderer = [rendererClassInstance initWithView:view theme:[[BYThemeManager instance] currentTheme]];
            return renderer;
        }
    }
    return nil;
}

@end