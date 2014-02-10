//
//  BYTextFieldRenderer.h
//  Beautify
//
//  Created by Colin Eberhardt on 29/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYControlRenderer.h"
@class BYText;

@interface BYTextFieldRenderer : BYControlRenderer

-(void)setTitle:(BYText*)title forState:(UIControlState)state;

@end