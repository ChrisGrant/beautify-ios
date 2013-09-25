//
//  BackgroundImage.h
//  Beautify
//
//  Created by Colin Eberhardt on 27/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 A style property representing an image for use as a background for a view.
 */
@interface BYBackgroundImage : NSObject <NSCopying>

/*
 The image data.
 */
@property UIImage* image;

@end