//
//  Border.h
//  Beautify
//
//  Created by Chris Grant on 14/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

/*
 A style property representing the border for a UIView.
 */
@interface BYBorder : JSONModel <NSCopying>

/*
 The border width.
 */
@property float width;

/*
 The radius of the border corners.
 */
@property float cornerRadius;

/*
 The color of the border.
 */
@property UIColor<Optional> *color;

/*
 Create a BYBorder with the specified properties.
 */
+(BYBorder*)borderWithColor:(UIColor*)color width:(float)width radius:(float)radius;

@end