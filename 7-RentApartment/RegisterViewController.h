//
//  RegisterViewController.h
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/14/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "AppDelegate.h"

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;

@end
