//
//  BYTableViewCellRenderer.m
//  Beautify
//
//  Created by Colin Eberhardt on 02/06/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "BYTableViewCellRenderer.h"
#import "BYViewRenderer_Private.h"
#import "BYStyleRenderer_Private.h"
#import "BYTheme.h"
#import "BYControlRenderingLayer.h"
#import "BYControlRenderer_Private.h"
#import "BYBackgroundImage.h"
#import "BYText.h"
#import "BYTextShadow.h"
#import "BYFont.h"
#import "BYFont_Private.h"
#import "BYTableViewCellStyle.h"

@implementation BYTableViewCellRenderer {
    BYControlRenderingLayer* _selectedLayer;
    UIImageView* _selectedNineBoxImage;
}

-(id)initWithView:(id)view theme:(BYTheme*)theme{
    if(self = [super initWithView:view theme:theme]) {        
        UITableViewCell *cell = (UITableViewCell*)view;
        [self setup:cell theme:theme];
    }
    return self;
}

-(void)setup:(UITableViewCell*)cell theme:(BYTheme*)theme {
    
    // for some reason plain-style table cells do not have a background view - so we create one here
    cell.backgroundView = [[UIView alloc] initWithFrame:cell.frame];
    
    // add the renderer and image layer
    [self addRendererLayers:cell.backgroundView];
    
    // replace the selected background view
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    
    // add the nine box image
    _selectedNineBoxImage = [UIImageView new];
    _selectedNineBoxImage.frame = cell.selectedBackgroundView.bounds;
    [cell.selectedBackgroundView addSubview:_selectedNineBoxImage];
    [cell.selectedBackgroundView sendSubviewToBack:_selectedNineBoxImage];
    
    // add the button layer that renders the background and border for selected state
    _selectedLayer = [[BYControlRenderingLayer alloc] initWithRenderer:self state:UIControlStateHighlighted];
    [_selectedLayer setFrame:cell.bounds];
    [_selectedLayer setNeedsDisplay];
    [cell.selectedBackgroundView.layer insertSublayer:_selectedLayer atIndex:0];
        
    [self configureFromStyle];
}
    
-(void)configureFromStyle {
    
    // The superclass takes care of the 'normal' state style
    [super configureFromStyle];
    
    // configure the selected state separately
    [self configureSelectedView];
    
    UITableViewCell *cell = (UITableViewCell*)self.adaptedView;
    
    BYText* textStyle = [self propertyValueForNameWithCurrentState:@"title"];
    BYTextShadow* textShadow = [self propertyValueForNameWithCurrentState:@"titleShadow"];

    UILabel* label = cell.textLabel;
    label.textColor = [UIColor redColor];
    label.font = [textStyle.font createFont:label.font];
    label.shadowColor = textShadow.color;
    label.shadowOffset = textShadow.offset;
    [self makeLabelBackgroundTransparant:cell];
    
    UIImage* accessoryViewImage = [self propertyValueForNameWithCurrentState:@"accessoryViewImage"];
    if ((cell.accessoryType == UITableViewCellAccessoryNone) && (accessoryViewImage != nil)) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:accessoryViewImage];
    }

    UIImage* editingAccessoryViewImage = [self propertyValueForNameWithCurrentState:@"editingAccessoryViewImage"];
    if ((cell.editingAccessoryType == UITableViewCellAccessoryNone) && (editingAccessoryViewImage != nil)) {
        cell.editingAccessoryView = [[UIImageView alloc] initWithImage:editingAccessoryViewImage];
    }
    
}

-(void)configureSelectedView {
    UIView *adaptedView = (UIView*)self.adaptedView;
    BYBackgroundImage* backgroundImage = [self propertyValueForName:@"backgroundImage" forState:UIControlStateHighlighted];
    
    if (backgroundImage == nil) {
        _selectedNineBoxImage.hidden = YES;
        _selectedLayer.hidden = NO;
        [_selectedLayer setFrame:adaptedView.bounds];
        [_selectedLayer setNeedsDisplay];
    }
    else {
        _selectedLayer.hidden = YES;
        _selectedNineBoxImage.hidden = NO;
        _selectedNineBoxImage.image = backgroundImage.image;
    }
}

// recursively find labels and make their background color transparant.
-(void)makeLabelBackgroundTransparant:(UIView*)view {
    UILabel* label = (UILabel*)view;
    if (label) {
        label.backgroundColor = [UIColor clearColor];
    }
    for(UIView* child in view.subviews) {
        [self makeLabelBackgroundTransparant:child];
    }
}

-(id)styleFromTheme:(BYTheme*)theme {
    if(theme.tableViewCellStyle) {
        return theme.tableViewCellStyle;
    }
    return [BYTableViewCellStyle defaultStyle];
}

-(UIControlState)currentControlState {
    return UIControlStateNormal;
}

@end