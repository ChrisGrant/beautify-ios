//
//  SCTableViewCellStyle.m
//  Beautify
//
//  Created by Colin Eberhardt on 02/06/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCTableViewCellStyle.h"

@implementation SCTableViewCellStyle

+(SCTableViewCellStyle*)defaultStyle {
    SCTableViewCellStyle *style = [SCTableViewCellStyle new];
    style.title = [[SCText alloc] initWithFont:[SCFont new] color:[UIColor blackColor]];
    return style;
}

@end