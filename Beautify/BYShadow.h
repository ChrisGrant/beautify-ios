//
//  Shadow.h
//  Beautify
//
//  Created by Chris Grant on 14/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSONModel.h"

// Used to tell JSONModel to look for shadow in arrays.
@protocol BYShadow
@end

// This will remove warnings that NSArrays don't conform to BYShadow protocols.
@interface NSArray (Shadow)<BYShadow>
@end

/*
 A style property representing a shadow for a UIView.
 */
@interface BYShadow : JSONModel <NSCopying, BYShadow>

/*
 The blur radius for the shadow.
 */
@property float radius;

/*
 The offset of the shadow from the associated UI element.
 */
@property CGSize offset;

/*
 Color for the shadow. Defaults to black.
 */
@property UIColor<Optional> *color;

/*
 Create with the specified offset, blur radius and color.
 */
+(BYShadow*)shadowWithOffset:(CGSize)offset radius:(float)radius color:(UIColor*)color;

@end