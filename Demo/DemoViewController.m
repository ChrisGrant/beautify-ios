//
//  DemoiPhoneViewController.m
//  Beautify
//
//  Created by Chris Grant on 20/09/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation DemoViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    if(self.applyCustomStyles) {
        
    }
}

@end