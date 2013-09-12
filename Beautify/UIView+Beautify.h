//
//  UIView+Beautify.h
//  Beautify
//
//  Created by Colin Eberhardt on 15/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 This category is responsible for adding a renderer property to each UI element.
 */
@interface UIView (Beautify)

/*
 Return the renderer which enchances the UI for this view.
 */
@property (readonly) __weak id renderer;

/*
 + Whether this UIView is 'immune' to the streamed style, i.e. it will maintain the style defined by the
 developer when the UI was designed, either in the Interface Bulder or in code.
 */
-(BOOL)isImmuneToBeautify;

/*
 Set whether this UIView is 'immune' to streamed styles.
 */
-(void)setImmuneToBeautify:(BOOL)immuneToBeautify;

@end

/*
 The following categories are used to strongly type the renderer properties on each control. Without this you would have
 to cast the renderer to the appropriate type when using the framework, i.e. ((SCSwitchRenderer*)myswitch).style etc...
 */
#import "SCSwitchRenderer.h"
@interface UISwitch (BeautifyRendererTyping)
@property (readonly) __weak SCSwitchRenderer *renderer;
@end

#import "SCSliderRenderer.h"
@interface UISlider (BeautifyRendererTyping)
@property (readonly) __weak SCSliderRenderer *renderer;
@end

#import "SCTableViewRenderer.h"
@interface UITableView (BeautifyRendererTyping)
@property (readonly) __weak SCTableViewRenderer *renderer;
@end

#import "SCTableViewCellRenderer.h"
@interface UITableViewCell (BeautifyRendererTyping)
@property (readonly) __weak SCTableViewCellRenderer *renderer;
@end

#import "SCNavigationBarRenderer.h"
@interface UINavigationBar (BeautifyRendererTyping)
@property (readonly) __weak SCNavigationBarRenderer *renderer;
@end

#import "SCTextFieldRenderer.h"
@interface UITextField (BeautifyRendererTyping)
@property (readonly) __weak SCTextFieldRenderer *renderer;
@end

#import "SCLabelRenderer.h"
@interface UILabel (BeautifyRendererTyping)
@property (readonly) __weak SCLabelRenderer *renderer;
@end

#import "SCButtonRenderer.h"
@interface UIButton (BeautifyRendererTyping)
@property (readonly) __weak SCButtonRenderer *renderer;
@end

#import "SCImageViewRenderer.h"
@interface UIImageView (BeautifyRendererTyping)
@property (readonly) __weak SCImageViewRenderer *renderer;
@end