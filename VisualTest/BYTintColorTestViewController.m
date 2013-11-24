//
//  BYTintColorTestViewController.m
//  Beautify
//
//  Created by Chris Grant on 24/11/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "BYTintColorTestViewController.h"
#import "UIView+Beautify.h"

@interface BYTintColorTestViewController ()
@property (weak, nonatomic) IBOutlet UIButton *customTintButton;
@end

@implementation BYTintColorTestViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [[self.customTintButton renderer] setTintColor:[UIColor orangeColor]];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

@end