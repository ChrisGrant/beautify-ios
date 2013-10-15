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

@implementation BYBeautify

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
}

#pragma mark - Swizzling

-(void)swizzleAll {
    // Creates renderers for the class specified here [BYBeautify instance].renderers
    for (NSString *classToSwizzle in [BYThemeManager instance].renderers.keyEnumerator) {
        [self swizzleMethod:NSClassFromString(classToSwizzle) method:@"didMoveToWindow"];
    }
    
    // Creates renderer for the UIViewController
    [self swizzleMethod:[UIViewController class] method:@"viewDidLoad"];
    // Stops UIViewController listening for CSThemeUpdatedNotifications
    [self swizzleMethod:[UIViewController class] method:@"dealloc"];
    
    // Removes the standard UITextField style 1 pixel shadow on the bottom of text
    [self swizzleMethod:[UITextField class] method:@"textRectForBounds:"];
    // Creates a instance of BYDelegatemultiplexer to act as a proxy delegate for UITextField
    [self swizzleMethod:[UITextField class] method:@"setDelegate:"];
    
    // Undoes the modifing of the background colour of the various labels in the UITableView by the original setSelected method by setting it back to transparent.
    [self swizzleMethod:[UITableViewCell class] method:@"setSelected:"];
    
    // Creates renderers for each of the UIBarButtonItems in the UINavigationBar
    [self swizzleMethod:[UINavigationBar class] method:@"layoutSubviews"];
    // Stops UINavigationBar listening for CSThemeUpdatedNotifications
    [self swizzleMethod:[UINavigationBar class] method:@"dealloc"];
    
    // Stops UIBarButtonItem listening for CSThemeUpdatedNotifications
    [self swizzleMethod:[UIBarButtonItem class] method:@"dealloc"];
    
    // Sets image as associatedObject if not immuneToBeautify so it is customised by framework
    [self swizzleMethod:[UIImageView class] method:@"setImage:"];
    // Returns image set as associatedObject if not immuneToBeautify
    [self swizzleMethod:[UIImageView class] method:@"image"];
    
    // Used to style the back button item
    [self swizzleMethod:[UINavigationBar class] method:@"pushNavigationItem:"];
    
    // Remove KVO.
    [self swizzleMethod:[UIView class] method:@"dealloc"];
}

-(void)swizzleMethod:(Class)class method:(NSString*) methodName {
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