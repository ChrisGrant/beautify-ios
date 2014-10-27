//
//  BYTableViewCellLabelRenderer.m
//  Beautify
//
//  Created by Colin Eberhardt on 03/06/2013.
//  Copyright (c) Beautify. All rights reserved.
//

#import "BYTableViewCellLabelRenderer.h"
#import "BYStyleRenderer_Private.h"
#import "BYViewRenderer_Private.h"
#import "BYTheme.h"
#import "BYTextShadow.h"
#import "BYText.h"
#import "BYFont.h"
#import "BYShadow.h"
#import "BYFont_Private.h"
#import "UIView+Utilities.h"
#import "BYTableViewCellStyle.h"

@implementation BYTableViewCellLabelRenderer {
    UITableViewCell *_parentCell;
}

-(instancetype)initWithView:(id)view theme:(BYTheme*)theme {
    if (self = [super initWithView:view theme:theme]) {
        // Hijack the label rendering
        _parentCell = [self findParentCellFromLabel:view];
        [self setup:(UILabel*)view];
        
        // Redraw isn't always called unless we observe these properties on the cell.
        [_parentCell addObserver:self forKeyPath:@"selected"
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
        [_parentCell addObserver:self forKeyPath:@"highlighted"
                         options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    }
    return self;
}

-(void)dealloc {
    [_parentCell removeObserver:self forKeyPath:@"selected"];
    [_parentCell removeObserver:self forKeyPath:@"highlighted"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self configureFromStyle];
}

-(void)setup:(UILabel*)label {
    [self configureFromStyle];
}

-(id)styleFromTheme:(BYTheme*)theme {
    if(theme.tableViewCellStyle) {
        return theme.tableViewCellStyle;
    }
    return [BYTableViewCellStyle defaultStyle];
}

-(void)configureFromStyle {
    BYText *textStyle = [self propertyValueForName:@"title" forState:UIControlStateNormal];
    BYText *highlightedTextStyle = [self propertyValueForName:@"title" forState:UIControlStateHighlighted];
    
    BYTextShadow *textShadow = [self propertyValueForName:@"titleShadow" forState:UIControlStateNormal];
    BYTextShadow *highlightedShadow = [self propertyValueForName:@"titleShadow" forState:UIControlStateHighlighted];
    
    UILabel* label = [self adaptedView];
    
    BYText *currentTextStyle = textStyle;
    BYTextShadow *currentShadowStyle = textShadow;
    
    if(_parentCell.selected || _parentCell.highlighted) {
        currentTextStyle = highlightedTextStyle;
        currentShadowStyle = highlightedShadow;
    }
    
    // store the previous font value, so that we do not loose the size that the developer specified.
    if (label.previousFont == nil) {
        label.previousFont = label.font;
    }
    
    label.textColor = currentTextStyle.color;
    label.font = [currentTextStyle.font createFont:label.previousFont];
    
    label.shadowColor = currentShadowStyle.color;
    label.shadowOffset = currentShadowStyle.offset;
    
    [super configureFromStyle];
}

-(UITableViewCell*)findParentCellFromLabel:(UILabel*)label {
    UIView *cell = label;
    while(![cell isKindOfClass:[UITableViewCell class]] && cell.superview) {
        cell = cell.superview;
    }
    if([cell isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell*)cell;
    }
    return nil;
}

@end