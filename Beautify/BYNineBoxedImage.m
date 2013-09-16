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

@end