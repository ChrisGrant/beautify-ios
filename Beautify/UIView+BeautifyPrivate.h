//
//  UIView+BeautifyPrivate.h
//  Beautify
//
//  Created by Colin Eberhardt on 18/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BYTheme;
@class BYStyleRenderer;

@interface UIView (BeautifyPrivate)

-(void)createRenderer;

-(void)applyTheme:(BYTheme*)theme;
-(void)associateRenderer:(BYStyleRenderer*)renderer;

@end