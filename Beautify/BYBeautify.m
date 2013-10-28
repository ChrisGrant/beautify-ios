//
//  BYBeautify.m
//  Beautify
//
//  Created by Adrian Conlin on 21/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "BYBeautify_Private.h"
#import "BYThemeManager_Private.h"
#import "BYVersionUtils.h"

@implementation BYBeautify

+(NSString*)getInfo {
    return [NSString stringWithFormat:@"Version: %s", BEAUTIFY_VERSION_NUMBER[0] ? BEAUTIFY_VERSION_NUMBER : "Unversioned"];
}

-(NSString*)getInfo {
    return [BYBeautify getInfo];
}

+(BYBeautify*)instance {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [self new];
    });
    return _sharedObject;
}

#pragma mark - Activation

-(void)activate {
    [self activateInternal];
}

-(void)activateWithStyle:(NSString*)styleName {
    // load and apply the style
    BYTheme* theme = [BYTheme fromFile:styleName];
    if(theme) {
        [[BYThemeManager instance] applyTheme:theme];
    }
    [self activateInternal];
}

-(void)activateInternal {
    // only swizzle the UI controls once
    if (!_active) {
        [self swizzleAll];
        _active = YES;
    }
    
    // Warn the user that Beautify is currently iOS7 only.
    if(SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        NSLog(@"Warning! Beautify is not fully compatible with this version of iOS. Beautify currently only supports iOS 7.0 and higher.");
    }
}

#pragma mark - Swizzling

-(void)swizzleAll {
    // Creates renderers for the class specified here [BYBeautify instance].renderers
    for (NSString *classToSwizzle in [BYThemeManager instance].renderers.keyEnumerator) {
        [self swizzleClass:NSClassFromString(classToSwizzle) method:@"didMoveToWindow"];
    }
    
    // Creates renderer for the UIViewController
    [self swizzleClass:[UIViewController class] method:@"viewDidLoad"];
    [self swizzleClass:[UIViewController class] method:@"viewWillLayoutSubviews"];
    // Stops UIViewController listening for CSThemeUpdatedNotifications
    [self swizzleClass:[UIViewController class] method:@"dealloc"];
    
    // Removes the standard UITextField style 1 pixel shadow on the bottom of text
    [self swizzleClass:[UITextField class] method:@"textRectForBounds:"];
    // Creates a instance of BYDelegatemultiplexer to act as a proxy delegate for UITextField
    [self swizzleClass:[UITextField class] method:@"setDelegate:"];
    
    // Undoes the modifing of the background colour of the various labels in the UITableView by the original setSelected method by setting it back to transparent.
    [self swizzleClass:[UITableViewCell class] method:@"setSelected:"];
    
    // Creates renderers for each of the UIBarButtonItems in the UINavigationBar
    [self swizzleClass:[UINavigationBar class] method:@"layoutSubviews"];
    
    // Sets image as associatedObject if not immuneToBeautify so it is customised by framework
    [self swizzleClass:[UIImageView class] method:@"setImage:"];
    // Returns image set as associatedObject if not immuneToBeautify
    [self swizzleClass:[UIImageView class] method:@"image"];
    
    // Used to style the back button item
    [self swizzleClass:[UINavigationBar class] method:@"pushNavigationItem:"];
    
    // Remove KVO.
    [self swizzleClass:[UIView class] method:@"dealloc"];
}

-(void)swizzleClass:(Class)class method:(NSString*)methodName {
    SEL originalMethod = NSSelectorFromString(methodName);
    SEL newMethod = NSSelectorFromString([NSString stringWithFormat:@"%@%@", @"override_", methodName]);
    [self swizzle:class from:originalMethod to:newMethod];
}

-(void)swizzle:(Class)class from:(SEL)original to:(SEL)new {
    Method originalMethod = class_getInstanceMethod(class, original);
    Method newMethod = class_getInstanceMethod(class, new);
    if(class_addMethod(class, original, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(class, new, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

@end