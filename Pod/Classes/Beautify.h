//
//  Beautify.h
//  Beautify
//
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for Beautify.
FOUNDATION_EXPORT double BeautifyVersionNumber;

//! Project version string for Beautify.
FOUNDATION_EXPORT const unsigned char BeautifyVersionString[];

// The types which are used for style property values
#import "BYBorder.h"
#import "BYFont.h"
#import "BYGradient.h"
#import "BYGradientStop.h"
#import "BYShadow.h"
#import "BYBackgroundImage.h"
#import "BYText.h"
#import "BYTextShadow.h"
#import "BYSwitchState.h"
#import "BYDropShadow.h"

// renderers
#import "BYSwitchRenderer.h"
#import "BYSliderRenderer.h"
#import "BYTableViewRenderer.h"
#import "BYTableViewCellRenderer.h"
#import "BYNavigationBarRenderer.h"
#import "BYTextFieldRenderer.h"
#import "BYLabelRenderer.h"
#import "BYButtonRenderer.h"
#import "BYImageViewRenderer.h"
#import "BYBarButtonItemRenderer.h"
#import "BYTabBarRenderer.h"
#import "BYSearchBarRenderer.h"

// theme and styles
#import "BYTheme.h"
#import "BYButtonStyle.h"
#import "BYSwitchStyle.h"
#import "BYLabelStyle.h"
#import "BYViewControllerStyle.h"
#import "BYTextFieldStyle.h"
#import "BYNavigationBarStyle.h"
#import "BYTableViewCellStyle.h"
#import "BYImageViewStyle.h"
#import "BYSliderStyle.h"
#import "BYBarButtonStyle.h"
#import "BYStyleProtocol.h"
#import "BYTabBarStyle.h"
#import "BYSearchBarStyle.h"

// categories that provide access to the renderers
#import "UIView+Beautify.h"
#import "UIViewController+Beautify.h"
#import "UIBarButtonItem+Beautify.h"
#import "UISwitch+Beautify.h"

#import "BYBeautify.h"
#import "BYThemeManager.h"

#import "BYTableViewCellLabelRenderer.h"