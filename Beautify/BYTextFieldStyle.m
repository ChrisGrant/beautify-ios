//
//  BYTextFieldStyle.m
//  Beautify
//
//  Created by Colin Eberhardt on 29/05/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYTextFieldStyle.h"
#import "BYBorder.h"
#import "BYVersionUtils.h"

@implementation BYTextFieldStyle

+(BYTextFieldStyle*)defaultStyle {
    BYTextFieldStyle *style = [BYTextFieldStyle new];
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        BYFont* titleFont = [BYFont new];
        style.title = [[BYText alloc] initWithFont:titleFont color:[UIColor blackColor]];
        style.backgroundColor = [UIColor whiteColor];
        style.border = [[BYBorder alloc] initWithColor:[UIColor colorWithWhite:0.76 alpha:1.0] width:1 radius:5];
    }
    else {
        BYFont* titleFont = [BYFont new];
        style.title = [[BYText alloc] initWithFont:titleFont color:[UIColor blackColor]];
        style.backgroundColor = [UIColor whiteColor];
        style.border = [[BYBorder alloc] initWithColor:[UIColor colorWithWhite:0.33 alpha:1.0] width:2 radius:7.0];
        style.outerShadows = @[[[BYShadow alloc] initWithOffset:CGSizeMake(0, 1.0) radius:1.0f color:[UIColor colorWithWhite:1.0 alpha:0.8f] isInset:NO]];
        style.innerShadows = @[[[BYShadow alloc] initWithOffset:CGSizeMake(0, 1.0) radius:2.0f color:[UIColor colorWithWhite:0.0 alpha:0.8f] isInset:YES]];
    }
    return style;
}

@end