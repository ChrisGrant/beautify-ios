//
//  BackgroundImage.h
//  Beautify
//
//  Created by Colin Eberhardt on 27/03/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

typedef NS_ENUM(NSInteger, BYImageContentMode) {
    BYImageContentModeFill,
    BYImageContentModeAspectFill,
    BYImageContentModeTile
};

/**
 A style property representing an image for use as a background for a view.
 */
@interface BYBackgroundImage : JSONModel <NSCopying>

/**
 The image.
 */
@property UIImage* data;

/**
 The content mode for the image when it is displayed
 */
@property BYImageContentMode contentMode;

/**
 Creates a background image with the specified image and content mode.
 */
+(BYBackgroundImage*)backgroundImageWithImage:(UIImage*)image andContentMode:(BYImageContentMode)contentMode;

@end