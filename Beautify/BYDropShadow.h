//
//  BYDropShadow.h
//  Beautify
//
//  Created by Daniel Allsop on 24/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYDropShadow : NSObject <NSCopying>

@property UIColor *color;

@property float height;

/*
 Create a drop shadow with the specified color and height.
 */
+(BYDropShadow*)shadowWithColor:(UIColor*)color andHeight:(float)height;

@end