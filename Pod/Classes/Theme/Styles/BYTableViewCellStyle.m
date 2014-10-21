//
//  BYTableViewCellStyle.m
//  Beautify
//
//  Created by Colin Eberhardt on 02/06/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYTableViewCellStyle.h"

@implementation BYTableViewCellStyle

+(BYTableViewCellStyle*)defaultStyle {
    BYTableViewCellStyle *style = [BYTableViewCellStyle new];
    style.title = [BYText textWithFont:[BYFont new] color:[UIColor blackColor]];
    
    BYStateSetter *selectedStateSetter = [BYStateSetter new];
    selectedStateSetter.propertyName = @"backgroundColor";
    selectedStateSetter.state = UIControlStateHighlighted;
    selectedStateSetter.value = [UIColor colorWithWhite:202.0f/255.0f alpha:1.0f];
    if(selectedStateSetter) {
        style.stateSetters = @[selectedStateSetter];
    }
    
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
    copy.innerShadow = self.innerShadow.copy;
    copy.outerShadow = self.outerShadow.copy;
    
    copy.accessoryViewImage = self.accessoryViewImage.copy;
    copy.editingAccessoryViewImage = self.editingAccessoryViewImage.copy;
    
    return copy;
}

@end