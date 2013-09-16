//
//  ButtonStyle.m
//  Beautify
//
//  Created by Chris Grant on 28/02/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYButtonStyle.h"
#import "BYBorder.h"
#import "BYFont.h"
#import "UIColor+HexColors.h"

@implementation BYButtonStyle

+(BYButtonStyle*)defaultStyle {
    BYButtonStyle *style = [BYButtonStyle new];
    style.title = [[BYText alloc] initWithFont:[BYFont new] color:[UIColor whiteColor]];
    style.backgroundColor = [UIColor clearColor];
    return style;
}

@end