//
//  DemoiPhoneViewController.m
//  Beautify
//
//  Created by Chris Grant on 20/09/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "DemoViewController.h"
#import <Beautify/Beautify.h>

@interface DemoViewController () <UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISwitch *customStyleSwitch;
@end

@implementation DemoViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    // you have to explicitly enable beautify for image views
    [self.imageView setImmuneToBeautify:NO];
    
    [self.descriptionLabel setText:self.beautifyDescripiton];
    UIBarButtonItem *one = [[UIBarButtonItem alloc] initWithTitle:@"1"
                                                            style:UIBarButtonItemStylePlain
                                                           target:nil
                                                           action:nil];
    
    UIBarButtonItem *two = [[UIBarButtonItem alloc] initWithTitle:@"2"
                                                            style:UIBarButtonItemStylePlain
                                                           target:nil
                                                           action:nil];
    
    UIBarButtonItem *three = [[UIBarButtonItem alloc] initWithTitle:@"3"
                                                            style:UIBarButtonItemStylePlain
                                                           target:nil
                                                           action:nil];
    
    self.navigationItem.rightBarButtonItems = @[one, two, three];
    
    if(self.applyCustomStyles) {
        self.customStyleSwitch.hidden = NO;
        [self.customStyleSwitch setDesiredSwitchSize:CGSizeMake(100, 30)];
        BYSwitchState *offState = [BYSwitchState new];
        offState.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        offState.textStyle = [BYText textWithFont:[BYFont fontWithName:@"HelveticaNeue"] color:[UIColor blackColor]];
        offState.text = @"Dark";
        [self.customStyleSwitch.renderer setOffState:offState forState:UIControlStateNormal];
        [self.customStyleSwitch.renderer setOffState:offState forState:UIControlStateHighlighted];
        [self.customStyleSwitch addTarget:self action:@selector(customStyleSwitchValueChanged:)
                         forControlEvents:UIControlEventValueChanged];
        
        BYSwitchState *onState = [BYSwitchState new];
        onState.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1.0];
        onState.textStyle = [BYText textWithFont:[BYFont fontWithName:@"HelveticaNeue"] color:[UIColor whiteColor]];
        onState.text = @"Light";
        [self.customStyleSwitch.renderer setOnState:onState forState:UIControlStateNormal];
        [self.customStyleSwitch.renderer setOnState:onState forState:UIControlStateHighlighted];
        [self.customStyleSwitch addTarget:self action:@selector(customStyleSwitchValueChanged:)
                         forControlEvents:UIControlEventValueChanged];
        
        [self.rightSwitch setDesiredSwitchSize:CGSizeMake(70, 40)];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self applyStyleBasedOnSwitchState];
}

-(void)applyStyleBasedOnSwitchState {
    if(self.applyCustomStyles) {
        if(self.customStyleSwitch.on) {
            BYTheme *theme = [BYTheme fromFile:@"flat"];
            [[BYThemeManager instance] applyTheme:theme];
        }
        else {
            BYTheme *theme = [BYTheme fromFile:@"dark"];
            [[BYThemeManager instance] applyTheme:theme];
        }
    }
}

-(void)customStyleSwitchValueChanged:(UISwitch*)styleSwitch {
    [self applyStyleBasedOnSwitchState];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField {
    // Hide the keyboard when the 'done' button on the keyboard is tapped.
    [self.textField resignFirstResponder];
    return YES;
}

-(UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell.textLabel setText:[NSString stringWithFormat:@"Cell %i", indexPath.row]];
    return cell;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (IBAction)buttonTapped:(UIButton *)sender {
    
    UIViewController *vc = [UIViewController new];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [vc.view addSubview:button];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end