//
//  Font.m
//  Beautify
//
//  Created by Colin Eberhardt on 21/03/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYFont.h"
#import "BYFont_Private.h"

@implementation BYFont

+(BYFont*)fontWithName:(NSString*)name {
    BYFont *font = [BYFont new];
    font.name = name;
    return font;
}

+(BYFont*)fontWithName:(NSString *)name andSize:(float)size {
    BYFont *font = [BYFont new];
    font.name = name;
    font.size = size;
    return font;
}

-(instancetype)init {
    if(self = [super init]) {
        self.name = [UIFont systemFontOfSize:1.0f].fontName;
    }
    return self;
}

-(UIFont*)createFont:(UIFont*)font {
    if (_size != 0.0 || font == nil) {
        return [UIFont fontWithName:self.name size:self.size];
    }
    return [UIFont fontWithName:self.name size:font.pointSize];
}

-(id)copyWithZone:(NSZone *)zone {
    BYFont *copy = [[BYFont allocWithZone:zone] init];
    copy.name = self.name.copy;
    copy.size = self.size;
    return copy;
}

@end