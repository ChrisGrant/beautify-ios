//
//  UIView+BeautifyPrivate.h
//  Beautify
//
//  Created by Colin Eberhardt on 18/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BYTheme;

@interface UIView (BeautifyPrivate)

-(void)createRenderer;

-(void)applyTheme:(BYTheme*)theme;

@end