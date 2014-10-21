//
//  BYTextShadow.h
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

@interface BYTextShadow : JSONModel <NSCopying>

@property CGSize offset;

@property UIColor<Optional> *color;

/*
 Create a text shadow with the specified offset and color.
 */
+(BYTextShadow*)shadowWithOffset:(CGSize)offset andColor:(UIColor*)color;

@end