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
    style.title = [BYText textWithFont:[BYFont new] color:[UIColor blackColor]];
    return style;
}

-(id)copyWithZone:(NSZone *)zone {
    BYTableViewCellStyle *copy = [super copyWithZone:zone];
    
    copy.title = self.title.copy;
    copy.titleShadow = self.titleShadow.copy;

    copy.backgroundColor = self.backgroundColor.copy;
    copy.backgroundGradient = self.backgroundGradient.copy;
    copy.backgroundImage = self.backgroundImage.copy;
    
    copy.border = self.border.copy;
    copy.innerShadows = self.innerShadows.copy;
    copy.outerShadows = self.outerShadows.copy;
    
    copy.accessoryViewImage = self.accessoryViewImage.copy;
    copy.editingAccessoryViewImage = self.editingAccessoryViewImage.copy;
    
    return copy;
}

@end