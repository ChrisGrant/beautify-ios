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

#define BEAUTIFY_BACKING_IMAGE_NAME @"backingImage"

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
    return [self beautifyBackingImage];
}

-(void)setImmuneToBeautify:(BOOL)immuneToBeautify {
    if([self isImmuneToBeautify] != immuneToBeautify) {
        
        UIImage *image = self.image;
        [super setImmuneToBeautify:immuneToBeautify];
        if(immuneToBeautify) {
            [self setImage:[self beautifyBackingImage]];
        }
        else {
            [self setImage:image];
        }
    }
}

-(BOOL)isImmuneToBeautify {
    if ([super isImmuneToBeautify]) {
        return YES;
    }
    
    // This image view isn't immune, but check that none of it's parents are immune to beautify.
    id resp = [self nextResponder];
    while (resp != nil) {
        if([resp respondsToSelector:@selector(isImmuneToBeautify)]) {
            if([resp isImmuneToBeautify]) {
                return YES;
            }
        }
        resp = [resp nextResponder];
    }
    
    return NO;
}

-(void)setBeautifyBackingImage:(UIImage*)backingImage {
    objc_setAssociatedObject(self, BEAUTIFY_BACKING_IMAGE_NAME, backingImage, OBJC_ASSOCIATION_RETAIN);
}

-(UIImage*)beautifyBackingImage {
    return objc_getAssociatedObject(self, BEAUTIFY_BACKING_IMAGE_NAME);
}

@end