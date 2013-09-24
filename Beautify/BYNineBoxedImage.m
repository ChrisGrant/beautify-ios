//
//  NineBoxedImage.m
//  Beautify
//
//  Created by Colin Eberhardt on 27/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYNineBoxedImage.h"
#import "BYNineBoxedImage_Private.h"

@implementation BYNineBoxedImage

-(UIImage *)createNineBoxedImage {
    return [self.data resizableImageWithCapInsets:UIEdgeInsetsMake(self.top, self.left, self.bottom, self.right)
                                     resizingMode:UIImageResizingModeStretch];
}

-(id)copyWithZone:(NSZone *)zone {
    BYNineBoxedImage *copy = [[BYNineBoxedImage allocWithZone:zone] init];
    copy.top = self.top;
    copy.left = self.left;
    copy.bottom = self.bottom;
    copy.right = self.right;
    copy.data = self.data.copy;
    return copy;
}

@end