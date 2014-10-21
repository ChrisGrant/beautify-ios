//
//  BYSearchBarStyle.m
//  Beautify
//
//  Created by Chris Grant on 06/02/2014.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYSearchBarStyle.h"

@implementation BYSearchBarStyle

+(BYSearchBarStyle*)defaultStyle {
    BYSearchBarStyle *sbs = [BYSearchBarStyle new];
    
    sbs.backgroundColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:205/255.0f alpha:1.0f];
    
    return sbs;
}

@end