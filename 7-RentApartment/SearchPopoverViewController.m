//
//  SearchPopoverViewController.m
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/15/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import "SearchPopoverViewController.h"

@interface SearchPopoverViewController ()

@end

@implementation SearchPopoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.priceFromTextField.delegate = self;
    self.priceToTextField.delegate = self;
    self.locationTextField.delegate = self;
    self.roomsTextField.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchButtonPressed:(id)sender {
    [self.delegate popoverSearchButtonPressedWithRooms:[self.roomsTextField.text integerValue] priceFrom:[self.priceFromTextField.text integerValue] priceTo:[self.priceToTextField.text integerValue] andLocation:self.locationTextField.text];
}

@end
