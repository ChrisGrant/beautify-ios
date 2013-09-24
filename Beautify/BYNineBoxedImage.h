//
//  NineBoxedImage.h
//  Beautify
//
//  Created by Colin Eberhardt on 27/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 A style property representing a nine-boxed image for use as a background for a UIView.
 */
@interface BYNineBoxedImage : NSObject <NSCopying>

/*
 The top inset.
 */
@property int top;

/*
 The left inset.
 */
@property int left;

/*
 The bottom inset.
 */
@property int bottom;

/*
 The right inset.
 */
@property int right;

/*
 The image data.
 */
@property UIImage* data;

@end
