//
//  SCTableViewCellLabelRenderer.m
//  Beautify
//
//  Created by Colin Eberhardt on 03/06/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "SCTableViewCellLabelRenderer.h"
#import "SCStyleRenderer_Private.h"
#import "SCViewRenderer_Private.h"
#import "SCTheme.h"
#import "SCTextShadow.h"
#import "SCText.h"
#import "SCFont.h"
#import "SCShadow.h"
#import "SCFont_Private.h"
#import "UIView+Utilities.h"
#import "SCTableViewCellStyle.h"

@implementation SCTableViewCellLabelRenderer {
    UITableViewCell *_parentCell;
}

-(id)initWithView:(id)view theme:(SCTheme*)theme {
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

-(id)styleFromTheme:(SCTheme*)theme {
    if(theme.tableViewCellStyle) {
        return theme.tableViewCellStyle;
    }
    return [SCTableViewCellStyle defaultStyle];
}

-(void)configureFromStyle {
    SCText *textStyle = [self propertyValueForName:@"title" forState:UIControlStateNormal];
    SCText *highlightedTextStyle = [self propertyValueForName:@"title" forState:UIControlStateHighlighted];
    
    SCTextShadow *textShadow = [self propertyValueForName:@"titleShadow" forState:UIControlStateNormal];
    SCTextShadow *highlightedShadow = [self propertyValueForName:@"titleShadow" forState:UIControlStateHighlighted];
    
    UILabel* label = [self adaptedView];
    
    SCText *currentTextStyle = textStyle;
    SCTextShadow *currentShadowStyle = textShadow;
    
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