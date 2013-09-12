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
@interface SCShadow : NSObject

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
 Whether the shadow should be rendered inside the UI element.
 */
@property BOOL inset;

/*
 Init with the specified offset, blur radius, color and inset.
 */
-(id)initWithOffset:(CGSize)offset radius:(float)radius color:(UIColor*)color isInset:(BOOL)inset;

@end
