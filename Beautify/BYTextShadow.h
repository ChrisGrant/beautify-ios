//
//  BYTextShadow.h
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYTextShadow : NSObject <NSCopying>

@property CGSize offset;

@property UIColor *color;

/*
 Create a text shadow with the specified offset and color.
 */
+(BYTextShadow*)shadowWithOffset:(CGSize)offset andColor:(UIColor*)color;

@end