//
//  BackgroundImage.h
//  Beautify
//
//  Created by Colin Eberhardt on 27/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BYImageContentMode) {
    BYImageContentModeFill,
    BYImageContentModeAspectFill,
    BYImageContentModeTile
};

/*
 A style property representing an image for use as a background for a view.
 */
@interface BYBackgroundImage : NSObject <NSCopying>

/*	
 The image.
 */
@property UIImage* image;

/*
 The content mode for the image when it is displayed
 */
@property BYImageContentMode contentMode;

@end