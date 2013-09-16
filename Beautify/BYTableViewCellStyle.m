//
//  BYTableViewCellStyle.m
//  Beautify
//
//  Created by Colin Eberhardt on 02/06/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYTableViewCellStyle.h"

@implementation BYTableViewCellStyle

+(BYTableViewCellStyle*)defaultStyle {
    BYTableViewCellStyle *style = [BYTableViewCellStyle new];
    style.title = [[BYText alloc] initWithFont:[BYFont new] color:[UIColor blackColor]];
    return style;
}

@end