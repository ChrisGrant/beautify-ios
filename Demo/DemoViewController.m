//
//  DemoiPhoneViewController.m
//  Beautify
//
//  Created by Chris Grant on 20/09/2013.
//  Copyright (c) 2013 Beautify. All rights reserved.
//

#import "DemoViewController.h"
#import <Beautify/Beautify.h>

@interface DemoViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation DemoViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.imageView setImmuneToBeautify:NO];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Bar Button"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:nil
                                                                             action:nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell.textLabel setText:[NSString stringWithFormat:@"Cell %i", indexPath.row]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

@end