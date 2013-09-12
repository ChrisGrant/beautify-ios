//
//  Border.h
//  Beautify
//
//  Created by Chris Grant on 14/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 A style property representing the border for a UIView.
 */
@interface SCBorder : NSObject

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
@property UIColor *color;

/*
 Init an SCBorder with the specified properties.
 */
-(id)initWithColor:(UIColor*)color width:(float)width radius:(float)radius;

@end
