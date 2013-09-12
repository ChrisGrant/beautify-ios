//
//  SCTextFieldStyle.m
//  Beautify
//
//  Created by Colin Eberhardt on 29/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCTextFieldStyle.h"
#import "SCBorder.h"
#import "SCVersionUtils.h"

@implementation SCTextFieldStyle

+(SCTextFieldStyle*)defaultStyle {
    SCTextFieldStyle *style = [SCTextFieldStyle new];
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        SCFont* titleFont = [SCFont new];
        style.title = [[SCText alloc] initWithFont:titleFont color:[UIColor blackColor]];
        style.backgroundColor = [UIColor whiteColor];
        style.border = [[SCBorder alloc] initWithColor:[UIColor colorWithWhite:0.76 alpha:1.0] width:1 radius:5];
    }
    else {
        SCFont* titleFont = [SCFont new];
        style.title = [[SCText alloc] initWithFont:titleFont color:[UIColor blackColor]];
        style.backgroundColor = [UIColor whiteColor];
        style.border = [[SCBorder alloc] initWithColor:[UIColor colorWithWhite:0.33 alpha:1.0] width:2 radius:7.0];
        style.outerShadows = @[[[SCShadow alloc] initWithOffset:CGSizeMake(0, 1.0) radius:1.0f color:[UIColor colorWithWhite:1.0 alpha:0.8f] isInset:NO]];
        style.innerShadows = @[[[SCShadow alloc] initWithOffset:CGSizeMake(0, 1.0) radius:2.0f color:[UIColor colorWithWhite:0.0 alpha:0.8f] isInset:YES]];
    }
    return style;
}

@end