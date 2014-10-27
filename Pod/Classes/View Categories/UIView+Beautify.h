//
//  UIView+Beautify.h
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 This category is responsible for adding a renderer property to each UI element.
 */
@interface UIView (Beautify)

/**
 Return the renderer which enchances the UI for this view.
 */
@property (readonly) __weak id renderer;

/**
 Whether this view is 'immune' to the globally applied theme, i.e. it will maintain the style defined by the
 developer when the UI was designed, either in the Interface Bulder or in code.
 
 This value is recursively passed to all of the subviews of this view. i.e. when setting this value, the same value is
 passed to all of this view's subviews, and all of their subviews etc.
 */
@property (nonatomic, getter=isImmuneToBeautify) BOOL immuneToBeautify;

@end

/**
 The following categories are used to strongly type the renderer properties on each control. Without this you would have
 to cast the renderer to the appropriate type when using the framework, i.e. ((BYSwitchRenderer*)myswitch).style etc...
 */
#import "BYSwitchRenderer.h"
@interface UISwitch (BeautifyRendererTyping)
@property (readonly) __weak BYSwitchRenderer *renderer;
@end

#import "BYSliderRenderer.h"
@interface UISlider (BeautifyRendererTyping)
@property (readonly) __weak BYSliderRenderer *renderer;
@end

#import "BYTableViewRenderer.h"
@interface UITableView (BeautifyRendererTyping)
@property (readonly) __weak BYTableViewRenderer *renderer;
@end

#import "BYTableViewCellRenderer.h"
@interface UITableViewCell (BeautifyRendererTyping)
@property (readonly) __weak BYTableViewCellRenderer *renderer;
@end

#import "BYNavigationBarRenderer.h"
@interface UINavigationBar (BeautifyRendererTyping)
@property (readonly) __weak BYNavigationBarRenderer *renderer;
@end

#import "BYTextFieldRenderer.h"
@interface UITextField (BeautifyRendererTyping)
@property (readonly) __weak BYTextFieldRenderer *renderer;
@end

#import "BYLabelRenderer.h"
@interface UILabel (BeautifyRendererTyping)
@property (readonly) __weak BYLabelRenderer *renderer;
@end

#import "BYButtonRenderer.h"
@interface UIButton (BeautifyRendererTyping)
@property (readonly) __weak BYButtonRenderer *renderer;
@end

#import "BYImageViewRenderer.h"
@interface UIImageView (BeautifyRendererTyping)
@property (readonly) __weak BYImageViewRenderer *renderer;
@end