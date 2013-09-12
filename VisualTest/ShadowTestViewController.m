//
//  ShadowTestViewController.m
//  Beautify
//
//  Created by Chris Grant on 16/08/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "ShadowTestViewController.h"
#import "Beautify.h"

@interface ShadowTestViewController ()
@end

@implementation ShadowTestViewController {
    CGFloat yPos;
    UIScrollView *_scrollView;
}

-(id)init {
    self = [super init];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [_scrollView setAlwaysBounceVertical:YES];
        [_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:_scrollView];
        
        yPos = 10;
        
        [self addTextFieldsWithBorderStyle:UITextBorderStyleRoundedRect];
    }
    return self;
}

- (void)modifyTextField:(UITextField *)textField withWidth:(int)width andRadius:(int)radius {
    SCTextFieldRenderer *renderer1 = ((SCTextFieldRenderer*)textField.renderer);
    [renderer1 setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    SCBorder *border1 = [SCBorder new];
    border1.color = [UIColor redColor];
    border1.width = width;
    border1.cornerRadius = radius;
    [renderer1 setBorder:border1 forState:UIControlStateNormal];
    
    SCShadow *shadow2 = [[SCShadow alloc] initWithOffset:CGSizeZero radius:75.0 color:[UIColor blackColor] isInset:YES];
    [renderer1 setInnerShadows:@[shadow2] forState:UIControlStateNormal];
}

-(void)addTextFieldsWithBorderStyle:(UITextBorderStyle)borderStyle {
    
    for(int i = 0, j = 40; i < 40; i+=2, j-=2) {
        
        UITextField *rtf1 = [UITextField new];
        rtf1.textAlignment = NSTextAlignmentCenter;
        rtf1.borderStyle = borderStyle;
        [rtf1 setText:[NSString stringWithFormat:@"Width: %i Radius: %i", i, i]];
        
        UITextField *rtf2 = [UITextField new];
        rtf2.textAlignment = NSTextAlignmentCenter;
        rtf2.borderStyle = borderStyle;
        [rtf2 setText:[NSString stringWithFormat:@"Width: %i Radius: %i", j, i]];
        
        UITextField *rtf3= [UITextField new];
        rtf3.textAlignment = NSTextAlignmentCenter;
        rtf3.borderStyle = borderStyle;
        [rtf3 setText:[NSString stringWithFormat:@"Width: %i Radius: %i", i, j]];
        
        [self modifyTextField:rtf1 withWidth:i andRadius:i];
        [self modifyTextField:rtf2 withWidth:j andRadius:i];
        [self modifyTextField:rtf3 withWidth:i andRadius:j];
        
        [self addDefaultView:rtf1 beautifyDefaultView:rtf2 andCustomisedView:rtf3 withHeight:100];
    }
}

-(void)addDefaultView:(UIView*)defaultView
  beautifyDefaultView:(UIView*)beautifyDefaultView
    andCustomisedView:(UIView*)customisedView
           withHeight:(CGFloat)height {
    [defaultView setImmuneToBeautify:YES];
    
    [defaultView setFrame:CGRectMake(5, yPos,
                                     ceilf(self.view.frame.size.width / 3) - 20, height)];
    [beautifyDefaultView setFrame:CGRectMake(ceilf(self.view.frame.size.width / 3), yPos,
                                             ceilf(self.view.frame.size.width / 3) - 20, height)];
    [customisedView setFrame:CGRectMake(ceilf(self.view.frame.size.width / 3) * 2, yPos,
                                        ceilf(self.view.frame.size.width / 3) - 20, height)];
    
    [defaultView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin];
    [beautifyDefaultView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
    [customisedView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin];
    
    [_scrollView addSubview:defaultView];
    [_scrollView addSubview:beautifyDefaultView];
    [_scrollView addSubview:customisedView];
    
    yPos += height + 10;
    
    [_scrollView setContentSize:CGSizeMake(0, yPos)];
}

@end