//
//  RegisterViewController.m
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/14/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    self.title = @"Register";
    UIBarButtonItem *registerButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Register"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(registerButtonTapped:)];
    self.navigationItem.rightBarButtonItem = registerButton;
    
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.addressTextField.delegate = self;
    self.ageTextField.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)registerButtonTapped:(id)sender {

    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context = appDelegate.managedObjectContext;
    
    User* newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    newUser.firstName = self.firstNameTextField.text;
    newUser.lastName = self.lastNameTextField.text;
    newUser.age = [NSNumber numberWithInt:[self.ageTextField.text integerValue]];
    
    
    NSError* insertError;
    
    if (![newUser validateForInsert:&insertError]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsuccessful"
                                                        message:insertError.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [context deleteObject:newUser];
        [context save:nil];
    }
    else {
        NSError* error;
        [context save:&error];
        
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsuccessful"
                                                            message:@"There was a problem with the database. Sorry :("
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
        else {
            ApartamentsCollectionViewController* apartmentsVC = [[ApartamentsCollectionViewController alloc] initWithNibName:@"ApartamentsCollectionViewController" bundle:nil];
            [self.navigationController pushViewController:apartmentsVC animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
