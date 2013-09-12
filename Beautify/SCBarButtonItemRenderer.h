//
//  SCBarButtonItemRenderer.h
//  Beautify
//
//  Created by Daniel Allsop on 06/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCControlRenderer.h"

@class SCText;

/*
 A renderer responsible for enhancing a UIBarButtonItem.
*/
@interface SCBarButtonItemRenderer : SCControlRenderer

@property NSMutableArray *values;
@property NSMutableArray *names;
@property NSMutableArray *controlStates;

-(void)styleViaStoredValueNamesAndStates;

/*
 Set the text style for the UIBarButtonItem associated with this renderer.
*/
-(void)setTitleStyle:(SCText*)titleStyle forState:(UIControlState)state;

@end