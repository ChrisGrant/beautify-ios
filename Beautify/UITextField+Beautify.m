//
//  UITextField+Beautify.m
//  Beautify
//
//  Created by Colin Eberhardt on 29/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UITextField+Beautify.h"
#import "BYRenderUtils.h"
#import <objc/runtime.h>
#import "BYDelegateMultiplexer.h"

@implementation UITextField (Beautify)

-(void)setTextInsets:(UIEdgeInsets)insets {
    NSValue* value = [NSValue valueWithUIEdgeInsets:insets];
    objc_setAssociatedObject(self, @"textInsets", value, OBJC_ASSOCIATION_RETAIN);
}

// get / lazy initialize the proxy
-(BYDelegateMultiplexer*)getDelegateProxy {
    BYDelegateMultiplexer* proxy = (BYDelegateMultiplexer*)objc_getAssociatedObject(self, @"delegateProxy");
    if (proxy == nil) {
        // create a new proxy
        proxy = [BYDelegateMultiplexer new];
        // set the proxy as the delegate for the text field
        [self override_setDelegate:(id<UITextFieldDelegate>)proxy];
        objc_setAssociatedObject(self, @"delegateProxy", proxy, OBJC_ASSOCIATION_RETAIN);
    }
    return proxy;
}

-(void)override_setDelegate:(id<UITextFieldDelegate>)delegate {
    // get the proxy
    BYDelegateMultiplexer* proxy = [self getDelegateProxy];
    // set as the delegate
    proxy.delegate = delegate;
}

-(CGRect)override_textRectForBounds:(CGRect)bounds {
    NSValue* value = (NSValue*)objc_getAssociatedObject(self, @"textInsets");
    if (value!=nil) {
        CGRect rect = [self override_textRectForBounds:bounds];
        UIEdgeInsets insets = [value UIEdgeInsetsValue];
        // the standard UITextField style has a 1 pixel shadow on the bottom. We do not want this to result in a 1-pixel
        // offset, so we remove it here
        UIEdgeInsets adjustedInsets = UIEdgeInsetsMake(insets.top, insets.left, insets.bottom - 1.0, insets.right);
        return UIEdgeInsetsInsetRect(rect, adjustedInsets);
    }
    else {
        return [self override_textRectForBounds:bounds];
    }
}

@end