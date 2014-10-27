//
//  UIImageView+Beautify.h
//  Beautify
//
//  Created by Chris Grant on 22/07/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImageView (Beautify)

-(void)setBeautifyBackingImage:(UIImage*)backingImage;
-(UIImage*)beautifyBackingImage;

@end