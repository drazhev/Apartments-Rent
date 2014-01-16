//
//  LoginViewController.m
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/14/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    self.title = @"Login";
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerButtonTapped:(id)sender {
    RegisterViewController* registerVC = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
}
- (IBAction)loginButtonTapped:(id)sender {
    
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    request.sortDescriptors = nil;
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"username = %@", self.usernameTextField.text]];
    
    NSArray* results = [appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    
    if (results.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsuccessful"
                                                        message:@"The username does not exist :("
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if ( ![((User*)results[0]).password isEqualToString:self.passwordTextField.text] ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsuccessful"
                                                        message:@"Wrong password :("
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    else {
        ApartmentsCollectionViewController* apartmentsVC = [[ApartmentsCollectionViewController alloc] initWithNibName:@"ApartmentsCollectionViewController" bundle:nil];
        [self.navigationController pushViewController:apartmentsVC animated:YES];
    }

    
}

@end
