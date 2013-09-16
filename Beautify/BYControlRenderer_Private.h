//
//  BYControlRenderer_Private.h
//  Beautify
//
//  Created by Colin Eberhardt on 30/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYControlRenderer.h"

@class BYControlRenderingLayer, UIImageView;

@interface BYControlRenderer ()

@property BYControlRenderingLayer *controlLayer;

@property UIImageView* nineBoxImage;

// indicates whether the control this renderer is associated with is currenlty highlighted.
@property BOOL highlighted;

-(void)addNineBoxAndRendererLayers:(UIView*)view;

-(void)addNineBoxAndRendererLayers;

@end