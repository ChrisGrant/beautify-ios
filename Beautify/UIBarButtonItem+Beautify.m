//
//  UIBarButtonItem+Beautify.m
//  Beautify
//
//  Created by Daniel Allsop on 02/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "UIBarButtonItem+Beautify.h"
#import "UIView+Beautify.h"

@implementation UIBarButtonItem (Beautify)

-(BYStyleRenderer*)renderer {
    UIView *v = [self valueForKey:@"view"];
    return v.renderer;
}

-(BOOL)isImmuneToBeautify{
    UIView *v = [self valueForKey:@"view"];
    return v.isImmuneToBeautify;
}

-(void)setImmuneToBeautify:(BOOL)immuneToBeautify{
    UIView *v = [self valueForKey:@"view"];
    [v setImmuneToBeautify:immuneToBeautify];
}

@end