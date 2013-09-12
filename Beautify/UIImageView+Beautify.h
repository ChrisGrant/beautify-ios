//
//  UIImageView+Beautify.h
//  Beautify
//
//  Created by Chris Grant on 22/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImageView (Beautify)

-(void)setBeautifyBackingImage:(UIImage*)backingImage;
-(UIImage*)BeautifyBackingImage;

@end