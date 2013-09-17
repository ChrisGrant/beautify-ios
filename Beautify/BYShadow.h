//
//  Shadow.h
//  Beautify
//
//  Created by Chris Grant on 14/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 A style property representing a shadow for a UIView.
 */
@interface BYShadow : NSObject

/*
 The blur radius for the shadow.
 */
@property float radius;

/*
 The offset of the shadow from the associated UI element.
 */
@property CGSize offset;

/*
 Color for the shadow.
 */
@property UIColor *color;

/*
 Init with the specified offset, blur radius and color.
 */
-(id)initWithOffset:(CGSize)offset radius:(float)radius color:(UIColor*)color;

@end