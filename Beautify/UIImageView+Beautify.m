//
//  UIImageView+Beautify.m
//  Beautify
//
//  Created by Chris Grant on 22/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <objc/runtime.h>
#import "UIImageView+Beautify.h"
#import "UIView+Beautify.h"

#define THEME_ROLLER_BACKING_IMAGE_NAME @"backingImage"

@implementation UIImageView (Beautify)

-(void)override_setImage:(UIImage*)image {
    if([self isImmuneToBeautify]) {
        [self override_setImage:image];
        [self setBeautifyBackingImage:nil];
    }
    else {
        // Store it somewhere else!
        [self override_setImage:nil];
        [self setBeautifyBackingImage:image];
    }
}

-(UIImage*)override_image {
    if([self isImmuneToBeautify]) {
        return [self override_image];
    }
    else {
        return [self BeautifyBackingImage];
    }
}

-(void)setImmuneToBeautify:(BOOL)immuneToBeautify {
    if([self isImmuneToBeautify] != immuneToBeautify) {
        
        UIImage *image = self.image;
        [super setImmuneToBeautify:immuneToBeautify];
        
        if(immuneToBeautify) {
            [self setImage:[self BeautifyBackingImage]];
        }
        else {
            [self setImage:image];
        }
    }
}

-(void)setBeautifyBackingImage:(UIImage*)backingImage {
    objc_setAssociatedObject(self, THEME_ROLLER_BACKING_IMAGE_NAME, backingImage, OBJC_ASSOCIATION_RETAIN);
}

-(UIImage*)BeautifyBackingImage {
    return objc_getAssociatedObject(self, THEME_ROLLER_BACKING_IMAGE_NAME);
}

@end