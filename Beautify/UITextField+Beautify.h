//
//  UITextField+Extras.h
//  Beautify
//
//  Created by Colin Eberhardt on 29/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYDelegateMultiplexer.h"

/*
 Text offsets with UITextField are applied by subclassing UITextField and overriding textRectForBounds.
 We do not want to subclass (because this is incompatible with theme rolling), so we swizzle the method
 in order to apply the given offsets.
 */
@interface UITextField (Beautify)

// sets the insets used to offset the text
- (void)setTextInsets:(UIEdgeInsets)insets;

// gets a proxy which is used to send delegate methods invocations to multiple delegates
- (BYDelegateMultiplexer*) getDelegateProxy;

@end