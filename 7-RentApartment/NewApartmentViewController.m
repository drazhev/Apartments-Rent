//
//  NewApartmentViewController.m
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/15/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import "NewApartmentViewController.h"

@interface NewApartmentViewController ()

@end

@implementation NewApartmentViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Details about the offer..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Details about the offer...";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"New apartment";
    
    self.nameTextField.delegate = self;
    self.roomsTextField.delegate = self;
    self.priceTextField.delegate = self;
    self.locationTextField.delegate = self;
    
    [[self.detailsTextView layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[self.detailsTextView layer] setBorderWidth:0.5];
    [[self.detailsTextView layer] setCornerRadius:10];
    
    UIBarButtonItem *registerButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Add"
                                       style:UIBarButtonItemStyleBordered
                                       target:self
                                       action:@selector(addButtonTapped:)];
    self.navigationItem.rightBarButtonItem = registerButton;

    
    // Do any additional setup after loading the view from its nib.
}

-(void)addButtonTapped: (id)sender {
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    Apartment* newApartment = [NSEntityDescription insertNewObjectForEntityForName:@"Apartment" inManagedObjectContext:context];
    newApartment.name = self.nameTextField.text;
    newApartment.price = [NSNumber numberWithInt:[self.priceTextField.text integerValue]];
    newApartment.location = self.locationTextField.text;
    newApartment.details = self.detailsTextView.text;
    newApartment.rooms = [NSNumber numberWithInt:[self.roomsTextField.text integerValue]];
    newApartment.imageFile = @"defaultImage.png";
    

    
    NSError* insertError;
    
    if (![newApartment validateForInsert:&insertError]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsuccessful"
                                                        message:insertError.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [context deleteObject:newApartment];
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
            [self.navigationController popViewControllerAnimated:YES];
        }
    }

}

-(void)viewWillAppear:(BOOL)animated {
    self.detailsTextView.delegate = self;
    self.detailsTextView.text = @"Details about the offer...";
    self.detailsTextView.textColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
