//
//  VisualTestViewController.m
//  Beautify
//
//  Created by Chris Grant on 03/07/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "VisualTestViewController.h"
#import "ShadowTestViewController.h"
#import "TableVisualTestViewController.h"
#import "Beautify.h"

#define PADDING 10

@interface VisualTestViewController () <UITableViewDataSource, UITableViewDelegate>
@end

@implementation VisualTestViewController {
    CGFloat yPos;
    UIScrollView *_scrollView;
}

-(id)init {
    if(self = [super init]) {
        [self setTitle:@"Visual Test"];
        
        [self addBarButtonItems];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [_scrollView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
        [_scrollView setAlwaysBounceVertical:YES];
        [_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:_scrollView];

        yPos = 10;
        
        [self addLabels];
        [self addImageViews];

        yPos += 10;

        [self addButtonsWithType:UIButtonTypeCustom andTitle:@"Custom"];
        [self addButtonsWithType:UIButtonTypeRoundedRect andTitle:@"Rounded/System"]; // aka UIButtonTypeSystem in iOS7
     
        [self addSwitches];
        [self addSliders];

        [self addTextFieldsWithBorderStyle:UITextBorderStyleRoundedRect text:@"I am a rounded text field"];
        [self addTextFieldsWithBorderStyle:UITextBorderStyleNone text:@"I am a no border text field"];
        [self addTextFieldsWithBorderStyle:UITextBorderStyleBezel text:@"I am a bezeled text field"];
        [self addTextFieldsWithBorderStyle:UITextBorderStyleLine text:@"I am a line bordered text field"];
        
        [self addTableViews];
        
        [self.renderer setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
    }
    return self;
}

-(void)addBarButtonItems{
    // create default UIBarButtonItem with UIBarButtonItemStyleBordered
    UIBarButtonItem *defaultButtonRight = [[UIBarButtonItem alloc] initWithTitle:@"Default"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self
                                                                     action:@selector(pushView)];
    [defaultButtonRight setImmuneToBeautify:YES];
    
    // create a beautify default UIBarButtonItem with UIBarButtonItemStyleBordered
    UIBarButtonItem *beautifyDefaultButtonRight = [[UIBarButtonItem alloc] initWithTitle:@"Beautify Default"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(pushView)];
    
    // create customized UIBarButtonItem with UIBarButtonItemStyleBordered
    UIBarButtonItem *customizedButtonRight = [[UIBarButtonItem alloc] initWithTitle:@"Customised"
                                                                        style:UIBarButtonItemStyleBordered
                                                                       target:self
                                                                       action:@selector(pushView)];
    
    // Set properties for UIBarButton UIControlStateNormal
    BYBarButtonItemRenderer *renderer = customizedButtonRight.renderer;

    BYBorder *border = [BYBorder new];
    border.width = 5.0f;
    border.color = [UIColor orangeColor];
    border.cornerRadius = 20.0f;
    [renderer setBorder:border forState:UIControlStateNormal];

    BYShadow *innerShadow = [BYShadow shadowWithOffset:CGSizeMake(0, 0) radius:10 color:[UIColor greenColor]];
    [renderer setInnerShadow:innerShadow forState:UIControlStateNormal];
    BYShadow *outerShadow = [BYShadow shadowWithOffset:CGSizeMake(0, 0) radius:20 color:[UIColor redColor]];
    [renderer setOuterShadow:outerShadow forState:UIControlStateNormal];
    
    border = [BYBorder new];
    border.width = 5.0f;
    border.color = [UIColor purpleColor];
    border.cornerRadius = 20.0f;
    [renderer setBorder:border forState:UIControlStateHighlighted];
    
    innerShadow = [BYShadow shadowWithOffset:CGSizeMake(0, 0) radius:15 color:[UIColor redColor]];
    [renderer setInnerShadow:innerShadow forState:UIControlStateHighlighted];
    outerShadow = [BYShadow shadowWithOffset:CGSizeMake(0, 0) radius:20 color:[UIColor greenColor]];
    [renderer setOuterShadow:outerShadow forState:UIControlStateHighlighted];
    
    self.navigationItem.rightBarButtonItems = @[customizedButtonRight, beautifyDefaultButtonRight, defaultButtonRight];
    
    UIBarButtonItem *defaultButtonLeft = [[UIBarButtonItem alloc] initWithTitle:@"D."
                                                                          style:UIBarButtonItemStyleBordered
                                                                         target:nil
                                                                         action:nil];
    [defaultButtonLeft setImmuneToBeautify:YES];

    UIBarButtonItem *beautifyDefaultButtonLeft = [[UIBarButtonItem alloc] initWithTitle:@"B.D."
                                                                                   style:UIBarButtonItemStylePlain
                                                                                  target:nil
                                                                                  action:nil];
    
    UIBarButtonItem *customizedButtonLeft = [[UIBarButtonItem alloc] initWithTitle:@"C"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:nil
                                                                             action:nil];
    
    self.navigationItem.leftBarButtonItems = @[defaultButtonLeft, beautifyDefaultButtonLeft, customizedButtonLeft];
    [self.navigationItem setLeftItemsSupplementBackButton:YES];
    
    defaultButtonLeft.image = [UIImage imageNamed:@"barButtonImage"];
    beautifyDefaultButtonLeft.image = [UIImage imageNamed:@"barButtonImage"];
    customizedButtonLeft.image = [UIImage imageNamed:@"barButtonImage"];
}

-(void)addLabels {
    UILabel *lDefault = [UILabel new];
    [lDefault setText:@"Default"];
    [lDefault setTextAlignment:NSTextAlignmentCenter];
    UILabel *lBeautify = [UILabel new];
    [lBeautify setText:@"Beautify Default"];
    [lBeautify setTextAlignment:NSTextAlignmentCenter];
    UILabel *lCustom = [UILabel new];
    [lCustom setText:@"Customised"];
    [lCustom setTextAlignment:NSTextAlignmentCenter];
    
    BYLabelRenderer *labelRenderer = lCustom.renderer;
    
    BYTextShadow *textShadow = [BYTextShadow new];
    [textShadow setColor:[UIColor blueColor]];
    [textShadow setOffset:CGSizeMake(0, 3)];
    [labelRenderer setTextShadow:textShadow forState:UIControlStateNormal];
    [labelRenderer setAlpha:0.9 forState:UIControlStateNormal];
    
    BYText *text = [BYText new];
    [text setFont:[BYFont fontWithName:@"AvenirNext-Medium"]];
    [labelRenderer setTextStyle:text forState:UIControlStateNormal];
    
    [self addDefaultView:lDefault beautifyDefaultView:lBeautify andCustomisedView:lCustom withHeight:50];
}

-(void)addImageViews {
    UIImage *image = [UIImage imageNamed:@"roller"];
    UIImageView *iv1 = [[UIImageView alloc] initWithImage:image];
    UIImageView *iv2 = [[UIImageView alloc] initWithImage:image];
    UIImageView *iv3 = [[UIImageView alloc] initWithImage:image];
    
    [iv1 setClipsToBounds:YES];
    
    [iv1 setContentMode:UIViewContentModeScaleAspectFill];
    [iv2 setContentMode:UIViewContentModeScaleAspectFill];
    [iv3 setContentMode:UIViewContentModeScaleAspectFill];
    
    [iv2 setImmuneToBeautify:NO];
    [iv3 setImmuneToBeautify:NO];
    
    BYImageViewRenderer *renderer = iv3.renderer;
    
    BYBorder *border = [BYBorder new];
    border.width = 2.0f;
    border.color = [UIColor whiteColor];
    border.cornerRadius = 25.0f;
    [renderer setBorder:border forState:UIControlStateNormal];
    
    BYShadow *shadow1 = [BYShadow shadowWithOffset:CGSizeZero radius:25.0 color:[UIColor blueColor]];
    [renderer setOuterShadow:shadow1 forState:UIControlStateNormal];
    
    BYShadow *shadow2 = [BYShadow shadowWithOffset:CGSizeZero radius:51.0 color:[UIColor blackColor]];
    [renderer setInnerShadow:shadow2 forState:UIControlStateNormal];
    
    [self addDefaultView:iv1 beautifyDefaultView:iv2 andCustomisedView:iv3 withHeight:200];
}

-(void)addSwitches {
    UISwitch *s1 = [UISwitch new];
    UISwitch *s2 = [UISwitch new];
    UISwitch *s3 = [UISwitch new];
    
    
    [s3 setDesiredSwitchSize:CGSizeMake(200, 30)];

    BYSwitchRenderer *renderer = s3.renderer;
    
    BYSwitchState *onState = [BYSwitchState new];
    BYTextShadow *textShadow = [BYTextShadow new];
    textShadow.offset = CGSizeMake(1, 1);
    textShadow.color = [UIColor darkGrayColor];
    onState.textShadow = textShadow;
    onState.text = @"YES";
    onState.textStyle = [BYText textWithFont:[BYFont fontWithName:@"ArialMT-Bold"] color:[UIColor blueColor]];
    onState.backgroundColor = [UIColor redColor];
    [renderer setOnState:onState forState:UIControlStateNormal];

    BYBorder *border = [BYBorder new];
    border.width = 2.0f;
    border.color = [UIColor blackColor];
    border.cornerRadius = 25.0f;
    
    [renderer setBorder:border forState:UIControlStateNormal];
    [renderer setThumbBorder:border forState:UIControlStateNormal];

    [renderer setThumbBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    BYShadow *shadow1 = [BYShadow shadowWithOffset:CGSizeZero radius:100.0 color:[UIColor blackColor]];
    [renderer setThumbInnerShadow:shadow1 forState:UIControlStateNormal];
    
    [self addDefaultView:s1 beautifyDefaultView:s2 andCustomisedView:s3 withHeight:30];
}

-(void)addSliders {
    UISlider *s1 = [UISlider new];
    UISlider *s2 = [UISlider new];
    UISlider *s3 = [UISlider new];
    
    BYSliderRenderer *renderer = s3.renderer;
    
    BYBorder *border = [BYBorder new];
    border.width = 1.0f;
    border.color = [UIColor blackColor];
    border.cornerRadius = 5.0f;
    
    BYShadow *shadow1 = [BYShadow shadowWithOffset:CGSizeZero radius:10.0 color:[UIColor greenColor]];
    [renderer setBarOuterShadow:shadow1 forState:UIControlStateNormal];
    
    // default bar thickness is very thin on ios7 and so trying to draw inner shadow and bar border makes things look a bit ugly
    BYBorder *barBorder = [BYBorder new];
    barBorder.width = 1.0f;
    barBorder.color = [UIColor blackColor];
    barBorder.cornerRadius = 5.0f;
    [renderer setBarBorder:barBorder forState:UIControlStateNormal];

    BYShadow *shadow2 = [BYShadow shadowWithOffset:CGSizeZero radius:5.0 color:[UIColor whiteColor]];
    [renderer setBarInnerShadow:shadow2 forState:UIControlStateNormal];
    
    [renderer setMinimumTrackColor:[UIColor blueColor] forState:UIControlStateNormal];
    [renderer setMinimumTrackBackgroundGradient:[BYGradient new] forState:UIControlStateNormal];

    [renderer setMaximumTrackColor:[UIColor redColor] forState:UIControlStateNormal];
    [renderer setMaximumTrackBackgroundGradient:[BYGradient new] forState:UIControlStateNormal];
    
    BYShadow *shadow4 = [BYShadow shadowWithOffset:CGSizeZero radius:15.0 color:[UIColor yellowColor]];
    [renderer setThumbOuterShadow:shadow4 forState:UIControlStateNormal];
    
    BYBorder *thumbBorder = [BYBorder new];
    thumbBorder.width = 1.0f;
    thumbBorder.color = [UIColor blackColor];
    thumbBorder.cornerRadius = 5.0f;
    [renderer setThumbBorder:thumbBorder forState:UIControlStateNormal];
    
    [renderer setThumbBackgroundColor:[UIColor purpleColor] forState:UIControlStateNormal];
    
    BYShadow *shadow3 = [BYShadow shadowWithOffset:CGSizeZero radius:10.0 color:[UIColor greenColor]];
    [renderer setThumbInnerShadow:shadow3 forState:UIControlStateNormal];
            
    [self addDefaultView:s1 beautifyDefaultView:s2 andCustomisedView:s3 withHeight:25];
}

-(void)addTextFieldsWithBorderStyle:(UITextBorderStyle)borderStyle text:(NSString *)text {
    UITextField *rtf1 = [UITextField new];
    rtf1.borderStyle = borderStyle;
    [rtf1 setText:text];
    UITextField *rtf2 = [UITextField new];
    rtf2.borderStyle = borderStyle;
    [rtf2 setText:text];
    UITextField *rtf3= [UITextField new];
    rtf3.borderStyle = borderStyle;
    [rtf3 setText:text];
    
    BYTextFieldRenderer *renderer = rtf3.renderer;
    
    [renderer setBackgroundColor:[UIColor yellowColor] forState:UIControlStateNormal];
    
    BYBorder *border = [BYBorder new];
    border.width = 5.0f;
    border.color = [UIColor blackColor];
    border.cornerRadius = 15.0f;
    [renderer setBorder:border forState:UIControlStateNormal];
    
    BYShadow *shadow1 = [BYShadow shadowWithOffset:CGSizeZero radius:30.0 color:[UIColor blackColor]];
    [renderer setInnerShadow:shadow1 forState:UIControlStateNormal];
    
    [self addDefaultView:rtf1 beautifyDefaultView:rtf2 andCustomisedView:rtf3 withHeight:44];
}

-(void)addButtonsWithType:(UIButtonType)type andTitle:(NSString*)title {
    UIButton *bcDefault = [UIButton buttonWithType:type];
    [bcDefault setTitle:title forState:UIControlStateNormal];
    [bcDefault addTarget:self action:@selector(pushView) forControlEvents:UIControlEventTouchUpInside];
    UIButton *bcBeautify = [UIButton buttonWithType:type];
    [bcBeautify setTitle:title forState:UIControlStateNormal];
    [bcBeautify addTarget:self action:@selector(pushView) forControlEvents:UIControlEventTouchUpInside];
    UIButton *bcCustom = [UIButton buttonWithType:type];
    [bcCustom setTitle:title forState:UIControlStateNormal];
    [bcCustom addTarget:self action:@selector(pushView) forControlEvents:UIControlEventTouchUpInside];
    
    BYButtonRenderer *buttonRenderer = bcCustom.renderer;
    
    BYText *text = [BYText new];
    [text setFont:[BYFont fontWithName:@"Helvetica"]];
    [text setColor:[UIColor whiteColor]];
    [buttonRenderer setTitleStyle:text forState:UIControlStateNormal];
    
    BYGradient *gradient = [BYGradient new];
    [gradient setStops:@[[BYGradientStop stopWithColor:[UIColor redColor] at:1.0f],
                         [BYGradientStop stopWithColor:[UIColor redColor] at:0.5f],
                         [BYGradientStop stopWithColor:[UIColor orangeColor] at:0.0f]]];
    [buttonRenderer setBackgroundGradient:gradient forState:UIControlStateNormal];
    
    BYGradient *gradient2 = [BYGradient new];
    [gradient2 setStops:@[[BYGradientStop stopWithColor:[UIColor redColor] at:1.0f],
                          [BYGradientStop stopWithColor:[UIColor redColor] at:0.5f],
                          [BYGradientStop stopWithColor:[[UIColor orangeColor] colorWithAlphaComponent:0.5f] at:0.0f]]];
    [buttonRenderer setBackgroundGradient:gradient2 forState:UIControlStateHighlighted];
    
    [self addDefaultView:bcDefault beautifyDefaultView:bcBeautify andCustomisedView:bcCustom withHeight:44];
    
    [buttonRenderer setBorder:[BYBorder new] forState:UIControlStateNormal];
    [buttonRenderer setBorder:[BYBorder new] forState:UIControlStateHighlighted];
}

-(void)addTableViews {
    UITableView *tv1 = [UITableView new];
    [tv1 setDelegate:self];
    [tv1 setDataSource:self];
    UITableView *tv2 = [UITableView new];
    [tv2 setDelegate:self];
    [tv2 setDataSource:self];
    UITableView *tv3 = [UITableView new];
    [tv3 setDataSource:self];
    [tv3 setDelegate:self];
    [self addDefaultView:tv1 beautifyDefaultView:tv2 andCustomisedView:tv3 withHeight:180];
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
    
    yPos += height + PADDING;
    
    [_scrollView setContentSize:CGSizeMake(0, yPos)];
}

-(void)pushView {
    [[self navigationController] pushViewController:[ShadowTestViewController new] animated:YES];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 20; }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { return 50; }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"item %d", indexPath.row];
    cell.detailTextLabel.text = @"hi";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath { return 80; }

#pragma mark - UITableViewDelegate 

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TableVisualTestViewController *tvc = [TableVisualTestViewController new];
    [[self navigationController] pushViewController:tvc animated:YES];
}

@end