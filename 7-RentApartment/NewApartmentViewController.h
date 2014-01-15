//
//  NewApartmentViewController.h
//  7-RentApartment
//
//  Created by Alexandar Drajev on 1/15/14.
//  Copyright (c) 2014 Alexander Drazhev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Apartment.h"
#import "AppDelegate.h"

@interface NewApartmentViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *roomsTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;

@end
