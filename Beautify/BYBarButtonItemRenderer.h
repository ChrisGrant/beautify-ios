//
//  BYBarButtonItemRenderer.h
//  Beautify
//
//  Created by Daniel Allsop on 06/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYControlRenderer.h"

@class BYText;

/*
 A renderer responsible for enhancing a UIBarButtonItem.
*/
@interface BYBarButtonItemRenderer : BYControlRenderer

@property NSMutableArray *values;
@property NSMutableArray *names;
@property NSMutableArray *controlStates;

-(void)styleViaStoredValueNamesAndStates;

/*
 Set the text style for the UIBarButtonItem associated with this renderer.
*/
-(void)setTitleStyle:(BYText*)titleStyle forState:(UIControlState)state;

@end