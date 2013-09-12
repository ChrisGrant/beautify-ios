//
//  SCTextShadow.h
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCTextShadow : NSObject

+(SCTextShadow*)shadowWithOffset:(CGSize)offset andColor:(UIColor*)color;

@property CGSize offset;

@property UIColor *color;

@end