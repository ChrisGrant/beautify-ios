//
//  UIImage+Base64.h
//  Beautify
//
//  Created by Chris Grant on 01/10/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Base64)

+(UIImage*)imageFromBase64String:(NSString*)string;
+(NSString*)base64StringFromUIImage:(UIImage*)image;

@end